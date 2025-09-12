<%@ page import="java.sql.*, javax.servlet.http.*, java.util.*" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%
    int movieId = (Integer) request.getAttribute("movie_id");
    ResultSet rs = (ResultSet) request.getAttribute("schedules");
%>
<html>
<head>
    <title>上映スケジュール</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
<div class="container">
<h2>上映スケジュールを選択</h2>
<form action="SeatsServlet" method="get">
    <input type="hidden" name="movie_id" value="<%=movieId%>">
    <select name="schedule_id">
    <%
        while(rs.next()) {
            int id = rs.getInt("id");
            Timestamp time = rs.getTimestamp("show_time");
    %>
        <option value="<%=id%>"><%=time%></option>
    <%
        }
    %>
    </select>
    <button type="submit">次へ</button>
</form>
</div>
</body>
</html>
