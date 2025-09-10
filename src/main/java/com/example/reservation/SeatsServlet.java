package com.example.reservation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.LinkedHashMap;
import java.util.Map;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/SeatServlet")
public class SeatsServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String movieIdStr = request.getParameter("movie_id");
        String scheduleIdStr = request.getParameter("schedule_id");

        if (movieIdStr == null || scheduleIdStr == null) {
            response.sendRedirect("index.jsp"); // パラメータ不正ならトップに戻す
            return;
        }

        int movieId = Integer.parseInt(movieIdStr);
        int scheduleId = Integer.parseInt(scheduleIdStr);

        Map<Integer, String> seatMap = new LinkedHashMap<>();
        java.util.Set<Integer> reservedSeatIds = new java.util.HashSet<>();

        try (Connection conn = DBUtil.getConnection()) {
            // 全席取得
            String sql = "SELECT id, seat_number FROM seats WHERE schedule_id = ? ORDER BY seat_number";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, scheduleId);
                try (ResultSet rs = stmt.executeQuery()) {
                    while (rs.next()) {
                        int seatId = rs.getInt("id");
                        String seatNumber = rs.getString("seat_number");
                        seatMap.put(seatId, seatNumber);
                    }
                }
            }
            // 予約済み席ID取得
            String reservedSql = "SELECT seat_id FROM reservations WHERE schedule_id = ?";
            try (PreparedStatement reservedStmt = conn.prepareStatement(reservedSql)) {
                reservedStmt.setInt(1, scheduleId);
                try (ResultSet rs = reservedStmt.executeQuery()) {
                    while (rs.next()) {
                        reservedSeatIds.add(rs.getInt("seat_id"));
                    }
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }

        request.setAttribute("movieId", movieId);
        request.setAttribute("scheduleId", scheduleId);
        request.setAttribute("seatMap", seatMap);
        request.setAttribute("reservedSeatIds", reservedSeatIds);

        request.getRequestDispatcher("seats.jsp").forward(request, response);
    }
}
