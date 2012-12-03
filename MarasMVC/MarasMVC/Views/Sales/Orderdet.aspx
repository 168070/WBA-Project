<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Orderdet
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2><%= ViewData["Message"] %></h2>

    <table>
        <tr>
            <th></th>
            <th>
                NrProduktu
            </th>
            <th>
                NazwaProduktu
            </th>
            <th>
                TypProduktu
            </th>
            <th>
                Cena
            </th>
            <th>
                OpisProduktu
            </th>
            <th>
                RokProdukcji
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Details", "Details", new { id=item.NrProduktu })%>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrProduktu)) %>
            </td>
            <td>
                <%= Html.Encode(item.NazwaProduktu) %>
            </td>
            <td>
                <%= Html.Encode(item.TypProduktu) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.CenaJednostkowa)) %>
            </td>
            <td>
                <%= Html.Encode(item.OpisProduktu) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:g}", item.RokProdukcji)) %>
            </td>
        </tr>
    
    <% } %>

    </table>
    <p>
        <%= Html.ActionLink("Powrót", "orders")%>
    </p>

</asp:Content>

