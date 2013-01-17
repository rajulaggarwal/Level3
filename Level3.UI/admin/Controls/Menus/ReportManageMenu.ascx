<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<% ReportingManageMenu reportingManageMenu = ReportingManageMenu.ReportingManage;
   ReportingManageSubMenu reportingManageSubMenu = ReportingManageSubMenu.ReportSearch;
   if (ViewData["ReportingManageMenu"] != null)
       reportingManageMenu = ViewData.Get<ReportingManageMenu>("ReportingManageMenu");
   if (ViewData["ReportingManageSubMenu"] != null)
       reportingManageSubMenu = ViewData.Get<ReportingManageSubMenu>("ReportingManageSubMenu");
%>
<div class="tn-collapsible <%if (reportingManageMenu == ReportingManageMenu.ReportingManage) Response.Write(" tn-collapsible-opend"); else Response.Write("  tn-collapsible-closed");%>">
    <div class="tn-border-bottom tn-border-gray tn-collapsible-header tn-switch-left">
        <h4 class="tn-helper-reset">
            <span>Reporting</span></h4>
        <span class="tn-icon tn-switch tn-icon-collapse-close"></span>
    </div>
    <div style="" class="tn-collapsible-content">
        <ul class="tn-side-menu">
            <li class="<% if (reportingManageSubMenu == ReportingManageSubMenu.ReportSearch) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("ReportSearch", "App")%>"><span>Report Search</span></a></li>
            <li class="<% if (reportingManageSubMenu == ReportingManageSubMenu.ReportListing) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("List_Reports","App") %>"><span>Report Listing</span></a></li>
        </ul>
    </div>
</div>

