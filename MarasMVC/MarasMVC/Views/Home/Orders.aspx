<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.RejestrZamowien>>" %>
<%@ Import Namespace="MarasMVC.Models"%>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Orders
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Zam�wienia oczekuj�ce na realizacj�</h2>

    <table>
        <tr>
            <th></th>
            <th>
                Nr
            </th>
            <th>
                Rodzaj
            </th>
            <th>
                Warto��
            </th>
            <th>
                Data
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Wi�cej", "Orderdet", new { id=item.NrZamowienia })%>
            </td>
            <td>
                <%= Html.Encode(item.NrZamowienia) %>
            </td>
            <td>
                <%= Html.Encode(item.RodzajTranzakcji) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.WartoscZamowienia)) %>
            </td>
            <td>
                <%= Html.Encode(item.Data) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    <p>
        <%= Html.ActionLink("Powr�t", "Index") %>
    </p>
    
    
     <h3>Zam�wienia zrealizowane</h3>
     
     <ul>
     <%
       foreach (var zam in (ViewData["Zam2"] as List<RejestrZamowien>))
       { %>
           <li><%= Html.ActionLink("Wi�cej", "Orderdet", new { id=zam.NrZamowienia })%> Nr: <%= Html.Encode(zam.NrZamowienia) %>  z dnia <%=Html.Encode(zam.Data) %> ,o warto�ci: <%=Html.Encode(zam.WartoscZamowienia) %></li>
   <%   } %>
     <ul>

</asp:Content>

