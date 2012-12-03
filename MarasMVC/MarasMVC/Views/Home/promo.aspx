<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<IEnumerable<MarasMVC.Models.Produkt>>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	promo
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Aktualne promocje - polecamy!</h2>
    
      <% foreach (var item in Model) { %>
        <div id="grid" class="grid">
            <div id="p_1" class="gridItem" onmouseover="enlarge(this);" onmouseout="enlarge(this);">
                <div class="frame">
                    <img src="../../Content/images/products/<%= Html.Encode(item.NrProduktu) %>.jpg" />
                </div>
                <div class="content">
                    <div class="price"> <%= Html.Encode(String.Format("{0:F}", item.CenaJednostkowa)) %> PLN</div>
                    <div class="addtocart"><a href="/home/buy/<%= Html.Encode(item.NrProduktu) %>"><img src="../../Content/images/AddToCart.png" 
/></a></div>
                    <div class="name"><a href=""><%= Html.Encode(item.NazwaProduktu) %></a></div>
                    <div class="desc"><%= Html.Encode(item.OpisProduktu) %></div>
                </div>
            </div>
            
            
            
            </div>
            
              <% } %>

</asp:Content>
