<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	CheckOut
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Zawartoœæ koszyka</h2>

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
                Ilosc
            </th>
            <th>
                CenaJednostkowa
            </th>
            <th>
                Jednostka
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
                <%= Html.ActionLink("Usun z koszyka", "UnBuy", new { id=item.NrProduktu }) %> |
               
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
                <%= Html.Encode(item.Ilosc) %>
            </td>
            <td>
                <%= Html.Encode(String.Format("{0:F}", item.CenaJednostkowa)) %>
            </td>
            <td>
                <%= Html.Encode(item.Jednostka) %>
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
        <%=Html.ActionLink("Zamow te towary", "CheckOut2", new {ct = Model.ToList() })%>
    </p>

</asp:Content>

