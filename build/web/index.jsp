<%-- 
    Document   : index
    Created on : 22 de nov. de 2021, 19:50:13
    Author     : danto
--%>
<%@page import="classe.Tarefa"%>
<%@page import="java.util.ArrayList"%>
<%@page import="db.TaskConnector"%>
<%@page import="web.DantonDbListener"%>
<% 
    ArrayList<Object> taskList = new ArrayList<>();
    Exception erros = null;
    try{
       if(request.getParameter("add") != null){
           String tarefa = request.getParameter("title");
           TaskConnector.addTask((String)session.getAttribute("user"), tarefa);
           response.sendRedirect(request.getRequestURI());
       }
       
       if(request.getParameter("remove") != null){
           int id = Integer.parseInt(request.getParameter("id"));
           TaskConnector.removeTask(id);
           response.sendRedirect(request.getRequestURI());
       }
       taskList = TaskConnector.getTasks((String)session.getAttribute("user"));
    }
    catch(Exception ex){
        erros = ex;
    }
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <%@include file="WEB-INF/jspf/header.jspf"%>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DantonTasksApp</title>
    </head>
    <body>
        <% if(DantonDbListener.exception != null) { %>
            <div>Erro do BD: <%= DantonDbListener.exception.getMessage() %></div>
        <% } %>
        <% if(erros != null) { %>
            <div>Erro nas tarefas: <%= erros.getMessage() %></div>
        <% } %>
        <% if(nome != null){ %>
        <form>
             <input type="text" name="title" required>
            <input type="submit" name="add" value="Adicionar">
        </form>
        
        <table>
            <% for (Object task: taskList){ 
                Tarefa t = (Tarefa) task;
            %>
            <tr>
                <td><%= t.getTitle() %></td>
                <td>
                    <form>
                        <input type="hidden" name="id" value="<%= t.getId() %>">
                        <input type="submit" name="remove" value="remover">
                    </form>
                </td>
            </tr>
            <% } %>
        </table>
        <% } else{ %>
            <h2>Identifique-se para visualizar as tarefas</h2>
        <% }%>
    </body>
</html>
