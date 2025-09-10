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
    <style>
        body { font-family: Arial, sans-serif; }
        .seat { display: inline-block; margin: 5px; padding: 10px; background: #ccc; cursor: pointer; }
        .seat.selected { background: #6c6; }
        .seat.reserved { background: #aaa; color: #fff; cursor: not-allowed; }
    </style>
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
    <h1>座席選択</h1>
    <form action="ReservationServlet" method="post">
        <input type="hidden" name="movie_id" value="<%=movieId%>">
        <input type="hidden" name="schedule_id" value="<%=scheduleId%>">

        <div>
            <% for(Map.Entry<Integer, String> entry : seatMap.entrySet()) { 
                boolean reserved = reservedSeatIds.contains(entry.getKey()); %>
                <div class="seat<%= reserved ? " reserved" : "" %>" onclick="selectSeat(this)" <%= reserved ? "style='pointer-events:none;'" : "" %>>
                    <%= entry.getValue() %>
                    <input type="radio" name="seat_id" value="<%= entry.getKey() %>" style="display:none;" <%= reserved ? "disabled" : "" %>>
                </div>
            <% } %>
        </div>

        <div style="margin-top:20px;">
            名前: <input type="text" name="name" required>
            メール: <input type="email" name="email" required>
        </div>

        <button type="submit" style="margin-top:20px;">予約する</button>
    </form>
</body>
</html>
