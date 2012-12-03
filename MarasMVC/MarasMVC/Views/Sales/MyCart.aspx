<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	MyCart
</asp:Content>



<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>MyCart</h2>

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
                CenaJednostkowa
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
                <%= Html.ActionLink("Edit", "Edit", new { id=item.NrProduktu }) %> |
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
        <%= Html.ActionLink("Create New", "Create") %>
    </p>

    <p>
        
    
    <br /><br />
    
        <b>Cookie Value:</b> <%= ViewData["myCookie"] %>
        <b>Chce kupiæ te produkty</b>
         <%= Html.ActionLink("Do kasy!", "CheckOut") %>
    </p>

</asp:Content>

