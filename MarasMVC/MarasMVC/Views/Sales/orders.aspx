<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.RejestrZamowien>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	orders
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Zamówienia oczekuj¹ce na realizajcê</h2>

    <table>
        <tr>
            <th></th>
            <th>
                NrZamowienia
            </th>
            <th>
                NrPracownika
            </th>
            <th>
                NrKlienta
            </th>
            <th>
                Rodzaj
            </th>
            <th>
                Wartosc
            </th>
            <th>
                Data
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
               <%= Html.ActionLink("Szczegó³y", "Orderdet", new { id=item.NrZamowienia })%>
               <%= Html.ActionLink("Realizuj", "Realize", new { id=item.NrZamowienia })%>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrZamowienia)) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrPracownika)) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrKlienta)) %>
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
    <%= Html.ActionLink("Poka¿ zrealizowane", "Oldorders")%>


</asp:Content>

