<%@ page import="com.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.BookDtls" %>
<%@ page import="com.DB.DBConnect" %>
<%@ page import="com.DAO.BookDAO" %>
<%@ page import="com.DAO.BookDAOImpl" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>User : Old Book</title>
<%@ include file="all_component/allCss.jsp" %>
</head>
<body style="background-color:#f0f1f2;">
    <%@ include file="all_component/navbar.jsp" %>
    <div class="container p-5">
    <c:if test="${not empty succMsg }">
      <div class="alert alert-success text-center">
      ${succMsg }
      </div>
      <c:remove var="succMsg" scope="session"/> 
   </c:if>
        <table class="table table-striped">
            <thead class="bg-primary text-white">
                <tr>
                    <th scope="col">Book Name</th>
                    <th scope="col">Author</th>
                    <th scope="col">Price</th>
                    <th scope="col">Category</th>
                    <th scope="col">Action</th>
                </tr>
            </thead>
            <tbody>
                <%
                User u = (User) session.getAttribute("userobj");
                if (u != null) {
                    String email = u.getEmail();
                    BookDAOImpl dao = new BookDAOImpl(DBConnect.getConn());
                    List<BookDtls> list = dao.getBookByOld(email, "Old");
                    for (BookDtls b : list) {
                %>
                <tr>
                    <td><%= b.getBookname() %></td>
                    <td><%= b.getAuthor() %></td>
                    <td><%= b.getPrice() %></td>
                    <td><%= b.getBookCategory() %></td>
                    <td><a href="delete_old_book?em=<%=email %>&&id=<%=b.getBookId() %>" class="btn btn-sm btn-danger">Delete</a></td>
                </tr>
                <%
                    }
                } else {
                    out.println("User session not found.");
                }
                %>
            </tbody>
        </table>
    </div>
    <div style="margin-top:130px;">
        <%@ include file="all_component/footer.jsp" %>
    </div>
</body>
</html>
