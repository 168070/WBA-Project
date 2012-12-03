<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site2.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.RejestrZamowien>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Realize
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Realize</h2>

    <fieldset>
        <legend>Fields</legend>
        <p>
            NrZamowienia:
            <%= Html.Encode(String.Format("{0:F}", Model.NrZamowienia)) %>
        </p>
        <p>
            NrPracownika:
            <%= Html.Encode(String.Format("{0:F}", Model.NrPracownika)) %>
        </p>
        <p>
            NrKlienta:
            <%= Html.Encode(String.Format("{0:F}", Model.NrKlienta)) %>
        </p>
        <p>
            RodzajTranzakcji:
            <%= Html.Encode(Model.RodzajTranzakcji) %>
        </p>
        <p>
            WartoscZamowienia:
            <%= Html.Encode(String.Format("{0:F}", Model.WartoscZamowienia)) %>
        </p>
        <p>
            Data:
            <%= Html.Encode(String.Format("{0:g}", Model.Data)) %>
        </p>
    </fieldset>
    <p>

        <%=Html.ActionLink("ZatwierdŸ realizacjê", "Realize2", new { id = Model.NrZamowienia })%> |
        <%=Html.ActionLink("Powrót", "orders")%>
    </p>

</asp:Content>

