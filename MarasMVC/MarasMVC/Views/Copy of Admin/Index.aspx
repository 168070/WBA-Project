<%@ Page Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>

<asp:Content ID="indexContent" ContentPlaceHolderID="MainContent" runat="server">
  
        
        <div id="gridTopic" class="topic">
            <h2>Wkrótce dostępne</h2>
            <div class="display">
                <div id="gridTopic_grid" class="gridview" onmouseover="displaySwitch('grid')" onmouseout="displaySwitch('grid')" onclick="changeDisplay(this, 'grid')"></div>
                <div id="gridTopic_list" class="listview" onmouseover="displaySwitch('list')" onmouseout="displaySwitch('list')" onclick="changeDisplay(this, 'grid')"></div>
            </div>
        </div>
       
        
        
</asp:Content>