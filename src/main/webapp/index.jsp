<%@ page import="java.sql.*, com.example.reservation.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>映画予約</title>
    <style>
        body { font-family: Arial; background:#f5f5f5; }
        .container { width: 500px; margin: 50px auto; padding: 20px; background:white; border-radius:8px; box-shadow:0 0 10px #ccc; }
        .movie { margin: 10px 0; }
        button { padding:8px 16px; background:#007bff; color:white; border:none; border-radius:4px; cursor:pointer; }
        button:hover { background:#0056b3; }
    </style>
</head>
<body>
<div class="container">
    <h2>映画を選択</h2>
    <form action="ScheduleServlet" method="get">
        <select name="movie_id">
        <%
            try (Connection conn = DBUtil.getConnection()) {
                Statement stmt = conn.createStatement();
                ResultSet rs = stmt.executeQuery("SELECT id, title FROM movies");
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("title");
        %>
                    <option value="<%=id%>"><%=title%></option>
        <%
                }
            } catch (SQLException e) {
                e.printStackTrace();
            }
        %>
        </select>
        <button type="submit">次へ</button>
    </form>
</div>
</body>
</html>
