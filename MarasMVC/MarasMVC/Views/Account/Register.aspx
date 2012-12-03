<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="registerTitle" ContentPlaceHolderID="TitleContent" runat="server">
    Register
</asp:Content>

<asp:Content ID="registerContent" ContentPlaceHolderID="MainContent" runat="server">
    <h2>Utwórz nowe konto</h2>
    <p>
        Skorzystaj z poniższego formularza, aby utworzyć nowe konto.
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
                    <label for="tel">Telefon:</label>
                    <%= Html.TextBox("tel") %>
                    <%= Html.ValidationMessage("tel") %>
                </p>                
                <p>
                    <label for="email">E-mail:</label>
                    <%= Html.TextBox("email") %>
                    <%= Html.ValidationMessage("email") %>
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
                <p> <label>Dane teleadresowe</label>
                </p>
                    <label for="city">Miasto:</label>
                    <%= Html.TextBox("city") %>
                <p>
                </p>
                    <label for="citycode">Kod pocztowy:</label>
                    <%= Html.TextBox("citycode") %>
                <p>
                </p>
                    <label for="street">Ulica:</label>
                    <%= Html.TextBox("street") %>
                <p>
                </p>
                    <label for="streetNo">Nr domu:</label>
                    <%= Html.TextBox("streetNo")%>
                <p>
                    <input type="submit" value="Rejestracja" />                
                </p>
                          
            </fieldset>
            <br /><br /><br /><br /><br /><br />
        </div>
    <% } %>
</asp:Content>
