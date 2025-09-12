<%@ page import="java.sql.*, com.example.reservation.DBUtil" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<html>
<head>
    <title>映画予約</title>
    <link rel="stylesheet" href="style.css">
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
