<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<%
    if (Request.IsAuthenticated) {
%>
        Welcome <b><%= Html.Encode(Page.User.Identity.Name) %></b>!
        [ <%= Html.ActionLink("Log Off", "LogOff", "Account") %> ]
<%
    }
    else {
%> 
        [ <%= Html.ActionLink("Log On", "LogOn", "Account") %> ]
<%
    }
%>




     <%
    if (Page.User.IsInRole("Administrator"))
         {
%>
        Tryb <b>administratora</b>!
        [ <%= Html.ActionLink("Dodaj sprzedawcę", "RegisterSp", "Account") %> ]
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

