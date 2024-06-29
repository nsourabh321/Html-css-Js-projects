<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URLDecoder" %>
<%@ page import="java.util.UUID" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Simple Todo List</title>
    <link href="./styles.css" rel="stylesheet" type="text/css">
</head>
<body >
    <h1>Simple Todo List</h1>
    
    <form action="todo.jsp" method="post" id="todo-form">
        <input type="text" name="task" placeholder="Enter a new task" required>
        <input type="submit" value="Add Task">
    </form>
    
    <h2>Tasks:</h2>
    <ul id="todo-list">
    <%
        // Handle new task submission
        String newTask = request.getParameter("task");
        if (newTask != null && !newTask.trim().isEmpty()) {
            String taskId = "task_" + UUID.randomUUID().toString().replace("-", "");
            Cookie taskCookie = new Cookie(taskId, URLEncoder.encode(newTask, "UTF-8"));
            taskCookie.setMaxAge(24 * 60 * 60); // 24 hours
            response.addCookie(taskCookie);
        }
        
        // Handle task deletion
        String deleteTaskId = request.getParameter("delete");
        if (deleteTaskId != null) {
            Cookie deleteCookie = new Cookie(deleteTaskId, "");
            deleteCookie.setMaxAge(0); // Delete the cookie
            response.addCookie(deleteCookie);
        }
        
        // Display tasks
        ArrayList<String[]> taskList = new ArrayList<>();
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().startsWith("task_")) {
                    taskList.add(new String[]{cookie.getName(), URLDecoder.decode(cookie.getValue(), "UTF-8")});
                }
            }
        }
        
        // Sort tasks in reverse order (newest first)
        taskList.sort((a, b) -> b[0].compareTo(a[0]));
        
        for (String[] task : taskList) {
            String taskId = task[0];
            String taskText = task[1];
            out.println("<li><span>" + taskText + "</span><button class='delete-btn' data-id='" + taskId + "'>Delete</button></li>");
        }
    %>
    </ul>
    <script src="script.js"></script>

</body>
</html>