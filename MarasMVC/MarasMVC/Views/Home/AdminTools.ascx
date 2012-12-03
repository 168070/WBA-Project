<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
     
     <%
    if (Page.User.IsInRole("Administrator"))
         {
%>
        Tryb <b>administratora</b>!
     <%
         }
    else if (Page.User.IsInRole("Sprzedawca"))
    {
%>      
        <b>Tryb sprzedawcy</b>
     <%
    }
    else if (Page.User.IsInRole("Klient"))
    {
%>         
        <b>Możesz kupić dowolny produkt</b>
      
<%
         }
%>
