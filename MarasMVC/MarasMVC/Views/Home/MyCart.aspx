<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	MyCart
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>MyCart</h2>

  
    
        <b>Cookie Value:</b> <%= ViewData["myCookie"] %>
        <b>Chce kupiæ te produkty</b>
         <%= Html.ActionLink("Do kasy!", "CheckOut") %>
    </p>

</asp:Content>

