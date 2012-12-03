<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
     
     <%
    if (Page.User.IsInRole("Administrator"))
         {
%>
       
     <%
         }
    else if (Page.User.IsInRole("Sprzedawca"))
    {
%>      

     <%
    }
    else if (Page.User.IsInRole("Klient"))
    {
%>         
        [ <%= Html.ActionLink("Kup", "Kup", "Home") %> ]
      
<%
         }
%>
