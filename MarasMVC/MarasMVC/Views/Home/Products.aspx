<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>
<%@ Import Namespace="MarasMVC.Helpers" %>
<%@ Import Namespace="MarasMVC.Controllers" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Products
    <%= Html.Encode(ViewData["Msg"].ToString()) %>
    </h2>
    
    <table>
        <tr>
            <th></th>
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
                Cena
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
            <%= Html.ActionLink("Kup", "Buy", new { id=item.NrProduktu }) %> 
            <%= Html.ActionLink("Detale", "Details", new { id=item.NrProduktu })%>
         
 
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
                <%= Html.Encode(ViewData["Msg"]) %>
       </p>       
        <p>
        <% Html.RenderPartial("AdminTools"); %>
        </p>





</asp:Content>




