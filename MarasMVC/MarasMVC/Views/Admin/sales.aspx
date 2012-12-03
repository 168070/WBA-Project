<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteA.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Sprzedawca>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	sales
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Sprzedawcy</h2>

    <table>
        <tr>
            <th></th>
            <th>
                NrPracownika
            </th>
            <th>
                Imie
            </th>
            <th>
                Nazwisko
            </th>
            <th>
                Stanowisko
            </th>
            <th>
                NIP
            </th>
            <th>
                Login
            </th>
            <th>
                Rola_w_systemie
            </th>
        </tr>

    <% foreach (var item in Model) { %>
    
        <tr>
            <td>
                <%= Html.ActionLink("Edit", "Edits", new { id=item.NrPracownika })%>
                <%= Html.ActionLink("Details", "Detailss", new { id=item.NrPracownika })%>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrPracownika)) %>
            </td>
            <td>
                <%= Html.Encode(item.Imie) %>
            </td>
            <td>
                <%= Html.Encode(item.Nazwisko) %>
            </td>
            <td>
                <%= Html.Encode(item.Stanowisko) %>
            </td>
            <td>
                <%= Html.Encode(item.NIP) %>
            </td>
            <td>
                <%= Html.Encode(item.Login) %>
            </td>
            <td>
                <%= Html.Encode(item.Rola_w_systemie) %>
            </td>
        </tr>
    
    <% } %>

    </table>

    

</asp:Content>

