<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteA.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Klinet>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	users
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>U¿ytkownicy - klienci</h2>

    <table>
        <tr>
            <th></th>
            <th>
                NrKlienta
            </th>
            <th>
                Imie
            </th>
            <th>
                Nazwisko
            </th>
            <th>
                E_Mail
            </th>
            <th>
                NIP
            </th>
            <th>
                Telefon
            </th>
            <th>
                OpisKlienta
            </th>
            <th>
                Haslo
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
                <%= Html.ActionLink("Details", "Detailsu", new { id=item.NrKlienta })%>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.NrKlienta)) %>
            </td>
            <td>
                <%= Html.Encode(item.Imie) %>
            </td>
            <td>
                <%= Html.Encode(item.Nazwisko) %>
            </td>
            <td>
                <%= Html.Encode(item.E_Mail) %>
            </td>
            <td>
                <%= Html.Encode(item.NIP) %>
            </td>
            <td>
                <%= Html.Encode(item.Telefon) %>
            </td>
            <td>
                <%= Html.Encode(item.OpisKlienta) %>
            </td>
            <td>
                <%= Html.Encode(item.Haslo) %>
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

