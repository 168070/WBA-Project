<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CheckOut2
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Realizacja zamówienia</h2>
    <p> 
        <%= Html.Encode(ViewData["1"].ToString()) %>
    </p>
    <p> <%= Html.Encode(ViewData["2"].ToString()) %>
    </p>




  
  
</asp:Content>
