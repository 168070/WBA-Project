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
            <%= Html.ActionLink("Kup", "Buy", new { id=item.NrProduktu }) %> |
            
            <!-- wszystko out, podzia³ na widoki poprzez foldery a nie render partial -->
            <!-- Widok zale¿ny od roli w systemie -->
            <% Html.RenderPartial("TowarEdit"); %>
            
                                    <!-- tylko dla sprzedawcy-->
                <%= Html.ActionLink("Edytuj", "Edit", new { id=item.NrProduktu }) %> |
                <%= Html.ActionLink("Detale", "Details", new { id=item.NrProduktu })%>
                <%= Html.ActionLink("Usuñ", "Delete", new { id=item.NrProduktu })%>
 
            </td>
            <td>
                <%= Html.Encode(item.NrProduktu) %>
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
        jeszcze raz
        
        <%= Html.ActionLink(GuiHelper.Label("me", "this"), GuiHelper.Label("me", "this"))%>
        
        </p>
        
        <p>
        <%
StringBuilder builder = new StringBuilder();
builder.AppendLine("<ul>");

for (int i = 0; i < 5; i++)
{
builder.AppendLine("<li>");
builder.AppendLine(i.ToString());
builder.AppendLine("</li>");
}

builder.AppendLine("</ul>");
Writer.Write(builder.ToString());
%>
        </p>
        
        <p>
        <% Html.RenderPartial("AdminTools"); %>
        </p>


  <p><%= Html.ActionLink("Create New", "Create") %></p>


   <% foreach (var item in Model) { %>
        <div id="grid" class="grid">
            <div id="p_1" class="gridItem" onmouseover="enlarge(this);" onmouseout="enlarge(this);">
                <div class="frame">
                    <img src="../../Content/images/products/<%= Html.Encode(item.NrProduktu) %>.jpg" />
                </div>
                <div class="content">
                    <div class="price"> <%= Html.Encode(String.Format("{0:F}", item.CenaJednostkowa)) %> PLN</div>
                    <div class="addtocart"><a href="home/addtocart/<%= Html.Encode(item.NrProduktu) %>"><img src="../../Content/images/AddToCart.png" /></a></div>
                    <div class="name"><a href=""><%= Html.Encode(item.NazwaProduktu) %></a></div>
                    <div class="desc"><%= Html.Encode(item.OpisProduktu) %></div>
                </div>
            </div>
            
            
            
            </div>
            
              <% } %>
</asp:Content>




