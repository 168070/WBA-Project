<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Produkt>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Details
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Details</h2>

    <fieldset>
        <legend>Fields</legend>
        <p>
            NrProduktu:
            <%= Html.Encode(Model.NrProduktu) %>
        </p>
        <p>
            NazwaProduktu:
            <%= Html.Encode(Model.NazwaProduktu) %>
        </p>
        <p>
            TypProduktu:
            <%= Html.Encode(Model.TypProduktu) %>
        </p>
        <p>
            Ilosc:
            <%= Html.Encode(Model.Ilosc) %>
        </p>
        <p>
            CenaJednostkowa:
            <%= Html.Encode(String.Format("{0:F}", Model.CenaJednostkowa)) %>
        </p>
        <p>
            Jednostka:
            <%= Html.Encode(Model.Jednostka) %>
        </p>
        <p>
            OpisProduktu:
            <%= Html.Encode(Model.OpisProduktu) %>
        </p>
        <p>
            RokProdukcji:
            <%= Html.Encode(String.Format("{0:g}", Model.RokProdukcji)) %>
        </p>
    </fieldset>
    <p>

        <%=Html.ActionLink("Edit", "Edit", new { id=Model.NrProduktu }) %> |
        <%=Html.ActionLink("Back to List", "Products") %>
    </p>

</asp:Content>

