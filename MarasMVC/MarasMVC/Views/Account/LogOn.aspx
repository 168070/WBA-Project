<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="loginTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Log On
</asp:Content>

<asp:Content ID="loginContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Logowanie</h2>
    <p>
        Proszę podać login i hasło. <%= Html.ActionLink("Register", "Register") %> jeśli nie posiadasz konta. 
    </p>
    <%= Html.ValidationSummary("Logowanie nie powidoło się. Proszę poprawić błędy i spróbować jeszcze raz.") %>

    <% using (Html.BeginForm()) { %>
        <div>
            <fieldset>
                <legend>Informacje o koncie:</legend>
                <p>
                    <label for="username">Login:</label>
                    <%= Html.TextBox("username") %>
                    <%= Html.ValidationMessage("username") %>
                </p>
                <p>
                    <label for="password">Hasło:</label>
                    <%= Html.Password("password") %>
                    <%= Html.ValidationMessage("password") %>
                </p>
                <p>
                    <%= Html.CheckBox("rememberMe") %> <label class="inline" for="rememberMe">Zapamietaj mnie ?</label>
                </p>
                <p>
                    <input type="submit" value="Zaloguj" />
                </p>
                
            </fieldset>
            <br /><br /><br /><br /><br /><br /><br /><br /><br />
        </div>
    <% } %>
</asp:Content>
