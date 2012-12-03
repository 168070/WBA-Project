<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Category
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Kategorie</h2>
    
       <% foreach (var ca in  (IEnumerable) ViewData["categories"])
          { %>
       
        <p>
                <%= Html.Encode(ca) %>
            </p>
           <% } %>

</asp:Content>
