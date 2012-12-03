<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteA.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Sprzedawca>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Edits
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Edytuj sprzedawcê</h2>

    <%= Html.ValidationSummary("Edit was unsuccessful. Please correct the errors and try again.") %>

    <% using (Html.BeginForm()) {%>

        <fieldset>
            <legend>Fields</legend>
            <p>
                <label for="NrPracownika">NrPracownika:</label>
                <%= Html.TextBox("NrPracownika", String.Format("{0:F}", Model.NrPracownika)) %>
                <%= Html.ValidationMessage("NrPracownika", "*") %>
            </p>
            <p>
                <label for="Imie">Imie:</label>
                <%= Html.TextBox("Imie", Model.Imie) %>
                <%= Html.ValidationMessage("Imie", "*") %>
            </p>
            <p>
                <label for="Nazwisko">Nazwisko:</label>
                <%= Html.TextBox("Nazwisko", Model.Nazwisko) %>
                <%= Html.ValidationMessage("Nazwisko", "*") %>
            </p>
            <p>
                <label for="Stanowisko">Stanowisko:</label>
                <%= Html.TextBox("Stanowisko", Model.Stanowisko) %>
                <%= Html.ValidationMessage("Stanowisko", "*") %>
            </p>
            <p>
                <label for="NIP">NIP:</label>
                <%= Html.TextBox("NIP", Model.NIP) %>
                <%= Html.ValidationMessage("NIP", "*") %>
            </p>
            <p>
                <label for="Login">Login:</label>
                <%= Html.TextBox("Login", Model.Login) %>
                <%= Html.ValidationMessage("Login", "*") %>
            </p>
            <p>
                <label for="Rola_w_systemie">Rola_w_systemie:</label>
                <%= Html.TextBox("Rola_w_systemie", Model.Rola_w_systemie) %>
                <%= Html.ValidationMessage("Rola_w_systemie", "*") %>
            </p>
            <p>
                <input type="submit" value="Save" />
            </p>
        </fieldset>

    <% } %>

    <div>
        <%=Html.ActionLink("Powrót", "sales") %>
    </div>

</asp:Content>

