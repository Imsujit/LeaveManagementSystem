<%@ page import="jakarta.servlet.http.HttpSession" %>
<%

  if (session != null) {
    session.invalidate();
  }
  response.sendRedirect("login.jsp");
%>
