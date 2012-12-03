<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteA.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Sprzedawca>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Detailss
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Detailss</h2>

    <fieldset>
        <legend>Fields</legend>
        <p>
            NrPracownika:
            <%= Html.Encode(String.Format("{0:F}", Model.NrPracownika)) %>
        </p>
        <p>
            Imie:
            <%= Html.Encode(Model.Imie) %>
        </p>
        <p>
            Nazwisko:
            <%= Html.Encode(Model.Nazwisko) %>
        </p>
        <p>
            Stanowisko:
            <%= Html.Encode(Model.Stanowisko) %>
        </p>
        <p>
            NIP:
            <%= Html.Encode(Model.NIP) %>
        </p>
        <p>
            Login:
            <%= Html.Encode(Model.Login) %>
        </p>
        <p>
            Rola_w_systemie:
            <%= Html.Encode(Model.Rola_w_systemie) %>
        </p>
    </fieldset>
    <p>

        <%=Html.ActionLink("Edytuj", "Edits", new { id=Model.NrPracownika }) %> |
        <%=Html.ActionLink("Powrót", "sales") %>
    </p>

</asp:Content>

