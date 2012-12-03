<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/SiteA.Master" Inherits="System.Web.Mvc.ViewPage<MarasMVC.Models.Klinet>" %>

<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
	Detailsu
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">

    <h2>Szczegó³y u¿ytkownika</h2>

    <fieldset>
        <legend>Fields</legend>
        <p>
            NrKlienta:
            <%= Html.Encode(String.Format("{0:F}", Model.NrKlienta)) %>
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
            E_Mail:
            <%= Html.Encode(Model.E_Mail) %>
        </p>
        <p>
            NIP:
            <%= Html.Encode(Model.NIP) %>
        </p>
        <p>
            Telefon:
            <%= Html.Encode(Model.Telefon) %>
        </p>
        <p>
            OpisKlienta:
            <%= Html.Encode(Model.OpisKlienta) %>
        </p>
        <p>
            Haslo:
            <%= Html.Encode(Model.Haslo) %>
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


        <%=Html.ActionLink("Powrót", "users") %>
    </p>

</asp:Content>

