package com.example.reservation;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        // パラメータ取得
        String scheduleIdStr = request.getParameter("schedule_id");
        String seatIdStr = request.getParameter("seat_id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        // nullチェック
        if (scheduleIdStr == null || seatIdStr == null ||
            name == null || email == null ||
            scheduleIdStr.isEmpty() || seatIdStr.isEmpty() ||
            name.isEmpty() || email.isEmpty()) {

            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "必要なパラメータが不足しています");
            return;
        }

        int scheduleId, seatId;
        try {
            scheduleId = Integer.parseInt(scheduleIdStr);
            seatId = Integer.parseInt(seatIdStr);
        } catch (NumberFormatException e) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "数値パラメータが不正です");
            return;
        }

        // DBに保存
        try (Connection conn = DBUtil.getConnection()) {
            String sql = "INSERT INTO reservations (schedule_id, seat_id, name, email) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setInt(1, scheduleId);
                stmt.setInt(2, seatId);
                stmt.setString(3, name);
                stmt.setString(4, email);
                stmt.executeUpdate();
            }
        } catch (SQLException e) {
            throw new ServletException("DBエラー: " + e.getMessage(), e);
        }

        // 完了ページへリダイレクト
        response.sendRedirect("complete.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // GETでアクセスされた場合はPOSTへフォワード
        doPost(request, response);
    }
}
