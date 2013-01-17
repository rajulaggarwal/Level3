<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<% SystemManageMenu systemManageMenu = SystemManageMenu.BasicDataManage;
   SystemManageSubMenu systemManageSubMenu = SystemManageSubMenu.ProductListing;
   if (ViewData["SystemManageMenu"] != null)
       systemManageMenu = ViewData.Get<SystemManageMenu>("SystemManageMenu");
   if (ViewData["SystemManageSubMenu"] != null)
       systemManageSubMenu = ViewData.Get<SystemManageSubMenu>("SystemManageSubMenu");
%>
<div class="tn-collapsible <%if (systemManageMenu == SystemManageMenu.BasicDataManage) Response.Write(" tn-collapsible-opend"); else Response.Write("  tn-collapsible-closed");%>">
    <div class="tn-border-bottom tn-border-gray tn-collapsible-header tn-switch-left">
        <h4 class="tn-helper-reset">
            <span>Basic Data</span></h4>
        <span class="tn-icon tn-switch tn-icon-collapse-close"></span>
    </div>
    <div style="" class="tn-collapsible-content">
        <ul class="tn-side-menu">
            <li class="<% if (systemManageSubMenu == SystemManageSubMenu.ProductListing) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("List_Products","App") %>"><span>Product Listing</span></a></li>
            <li class="<% if (systemManageSubMenu == SystemManageSubMenu.CardholderListing) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("List_Cardholders","App") %>"><span>Cardholder Listing</span></a></li>
           <%if (CurrentUser.IsSystemAdministrator)
            { %>
            <li class="<% if (systemManageSubMenu == SystemManageSubMenu.CompanyListing) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("List_Companys","App") %>"><span>Company Listing</span></a></li>
            <%} %>
        </ul>
    </div>
</div>
<%if (CurrentUser.IsSystemAdministrator)
{ %>
<div class="tn-collapsible <%if (systemManageMenu == SystemManageMenu.SystemManage) Response.Write(" tn-collapsible-opend"); else Response.Write("  tn-collapsible-closed");%>">
    <div class="tn-border-bottom tn-border-gray tn-collapsible-header tn-switch-left">
        <h4 class="tn-helper-reset">
            <span>Tools</span></h4>
        <span class="tn-icon tn-switch tn-icon-collapse-close"></span>
    </div>
    <div class="tn-collapsible-content">
        <ul class="tn-side-menu">
            <li class="<% if (systemManageSubMenu == SystemManageSubMenu.EventLogManage) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a href="<%=BaseUrlHelper.Action("EventLog","Common") %>" class="tn-menu-text">Log Management</a></li>      
        </ul>
    </div>
</div>
 <%} %>
