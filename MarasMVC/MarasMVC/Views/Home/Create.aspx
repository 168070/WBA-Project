<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Produkt>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Create
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Create</h2>

    <%= Html.ValidationSummary("Create was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>

            <p>
                <label for="NazwaProduktu">NazwaProduktu:</label>
                <%= Html.TextBox("NazwaProduktu") %>
                <%= Html.ValidationMessage("NazwaProduktu", "*") %>
            </p>
            <p>
                <label for="TypProduktu">TypProduktu:</label>
                <%= Html.TextBox("TypProduktu") %>
                <%= Html.ValidationMessage("TypProduktu", "*") %>
            </p>
            <p>
                <label for="Ilosc">Ilosc:</label>
                <%= Html.TextBox("Ilosc") %>
                <%= Html.ValidationMessage("Ilosc", "*") %>
            </p>
            <p>
                <label for="CenaJednostkowa">CenaJednostkowa:</label>
                <%= Html.TextBox("CenaJednostkowa") %>
                <%= Html.ValidationMessage("CenaJednostkowa", "*") %>
            </p>
            <p>
                <label for="Jednostka">Jednostka:</label>
                <%= Html.TextBox("Jednostka") %>
                <%= Html.ValidationMessage("Jednostka", "*") %>
            </p>
            <p>
                <label for="OpisProduktu">OpisProduktu:</label>
                <%= Html.TextBox("OpisProduktu") %>
                <%= Html.ValidationMessage("OpisProduktu", "*") %>
            </p>
            <p>
                <label for="RokProdukcji">RokProdukcji:</label>
                <%= Html.TextBox("RokProdukcji") %>
                <%= Html.ValidationMessage("RokProdukcji", "*") %>
            </p>
            <p>
                <input type="submit" value="Create" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Back to List", "Products") %>
    </div>

</asp:Content>

