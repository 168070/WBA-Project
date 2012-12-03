<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Realize2
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Zamówienie zosta³o pomyœlnie zrealizowane</h2>
    
       <p>
                <%= Html.Encode(ViewData["Msg"].ToString()) %>
       </p>  

</asp:Content>
