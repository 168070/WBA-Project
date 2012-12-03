<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Produkt>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Delete
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Czy napewno skasowaæ nastêpuj¹cy produkt?</h2>
    
      <% using (Html.BeginForm()) {%>

    <fieldset>
        <legend>Fields</legend>
        <p>
            <label for="NrProduktu">NrProduktu:</label>
            <%= Html.Encode(String.Format("{0:F}", Model.NrProduktu))%>
        </p>
        <p>
            <label for="NazwaProduktu">NazwaProduktu:</label>
            <%= Html.Encode(Model.NazwaProduktu) %>
        </p>
        <p>
           <label for="TypProduktu">TypProduktu:</label>
            <%= Html.Encode(Model.TypProduktu) %>
        </p>
        <p>
            <label for="Ilosc">Ilosc:</label>
            <%= Html.Encode(Model.Ilosc) %>
        </p>
        <p>
             <label for="CenaJednostkowa">CenaJednostkowa:</label>
            <%= Html.Encode(String.Format("{0:F}", Model.CenaJednostkowa)) %>
        </p>
        <p>
            <label for="Jednostka">Jednostka:</label>
            <%= Html.Encode(Model.Jednostka) %>
        </p>
        <p>
            <label for="OpisProduktu">OpisProduktu:</label>
            <%= Html.Encode(Model.OpisProduktu) %>
        </p>
        <p>
            <label for="RokProdukcji">RokProdukcji:</label>
            <%= Html.Encode(String.Format("{0:g}", Model.RokProdukcji)) %>
        </p>
        <p>
        <input type="submit" value="Delete" />
         <%=Html.ActionLink("Tak skasuj", "Delete", Model ) %> |
        </p>
    </fieldset>
        <% } %>
        
        
    <p>

        <%=Html.ActionLink("Edytuj", "Edit", new { id=Model.NrProduktu }) %> |
        <%=Html.ActionLink("Powrót", "Products") %>
    </p>

</asp:Content>

