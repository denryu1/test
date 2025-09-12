<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.Map, java.util.Set" %>

<%
    int movieId = (int) request.getAttribute("movieId");
    int scheduleId = (int) request.getAttribute("scheduleId");
    Map<Integer, String> seatMap = (Map<Integer, String>) request.getAttribute("seatMap");
    Set<Integer> reservedSeatIds = (Set<Integer>) request.getAttribute("reservedSeatIds");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>座席選択</title>
    <link rel="stylesheet" href="style.css">
    <script>
        function selectSeat(el) {
            if (el.classList.contains('reserved')) return;
            const checkboxes = document.querySelectorAll('input[name="seat_id"]');
            checkboxes.forEach(cb => cb.checked = false);
            el.querySelector('input').checked = true;
            document.querySelectorAll('.seat').forEach(s => s.classList.remove('selected'));
            el.classList.add('selected');
        }
    </script>
</head>
<body>
    <div class="container">
        <h1>座席選択</h1>
        <form action="ReservationServlet" method="post">
            <input type="hidden" name="movie_id" value="<%=movieId%>">
            <input type="hidden" name="schedule_id" value="<%=scheduleId%>">

            <div class="seats-area">
                <% for(Map.Entry<Integer, String> entry : seatMap.entrySet()) { 
                    boolean reserved = reservedSeatIds.contains(entry.getKey()); %>
                    <div class="seat<%= reserved ? " reserved" : "" %>" onclick="selectSeat(this)">
                        <%= entry.getValue() %>
                        <input type="radio" name="seat_id" value="<%= entry.getKey() %>" style="display:none;" <%= reserved ? "disabled" : "" %>>
                    </div>
                <% } %>
            </div>

            <div class="form-group">
                <input type="text" name="name" placeholder="お名前" required>
                <input type="email" name="email" placeholder="メールアドレス" required>
            </div>

            <button type="submit">予約する</button>
        </form>
    </div>
</body>
</html>
