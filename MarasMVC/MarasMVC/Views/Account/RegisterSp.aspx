<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Dodaj nowego sprzedawcę</h2>
    <p>
        Skorzystaj z poniższego formularza, aby utworzyć konto sprzedawcy.
    </p>
    <p>
        Hasła muszą być co najmniej <%=Html.Encode(ViewData["PasswordLength"])%> znakowe.
    </p>
    <%= Html.ValidationSummary("Utworzenie konta nie powidoło się. Proszę poprawić błędy i spróbować jeszcze raz.") %>

    <% using (Html.BeginForm()) { %>
        <div>
            <fieldset>
                <legend>Informacje o koncie</legend>
                <p>
                    <label for="imie">Imie:</label>
                    <%= Html.TextBox("imie") %>
                    <%= Html.ValidationMessage("imie") %>
                </p>
                <p>
                    <label for="nazwisko">Nazwisko:</label>
                    <%= Html.TextBox("nazwisko") %>
                    <%= Html.ValidationMessage("nazwisko") %>
                </p>
                <p>
                    <label for="nip">Nip:</label>
                    <%= Html.TextBox("nip") %>
                    <%= Html.ValidationMessage("nip") %>
                </p>
                <p>
                    <label for="stanowisko">Stanowisko:</label>
                    <%= Html.TextBox("stanowisko") %>
                    <%= Html.ValidationMessage("stanowisko") %>
                </p>
                <p>
                    Dane systemowe:
                </p>                

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
                    <label for="confirmPassword">Potwierdź hasło:</label>
                    <%= Html.Password("confirmPassword") %>
                    <%= Html.ValidationMessage("confirmPassword") %>
                </p>
                <p>
                    <label for="email">E-mail:</label>
                    <%= Html.TextBox("email") %>
                    <%= Html.ValidationMessage("email") %>
                </p>
                <p>
                    <input type="submit" value="Rejestracja" />                
                </p>
                          
            </fieldset>
            <p>
               [ <%= Html.ActionLink("Powrót", "Index", "Admin") %> ]
               </p>
            <br /><br /><br /><br /><br /><br />
        </div>
    <% } %>
</asp:Content>
