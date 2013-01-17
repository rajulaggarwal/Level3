<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<div class="tn-collapsible tn-collapsible-opend">
    <div class="tn-border-bottom tn-border-gray tn-collapsible-header tn-switch-left">
        <h4 class="tn-helper-reset">
            <span>User Management</span></h4>
        <span class="tn-icon tn-switch tn-icon-collapse-close"></span>
    </div>
    <div style="" class="tn-collapsible-content">
        <ul class="tn-side-menu">
            <li class="tn-selected tn-widget-content tn-bg-light tn-corner-all">
                <a class="tn-menu-text" href="<%=Url.Action("EditProfile", "App")%>"><span>My Profile</span></a>
            </li>
            <li class="tn-selected tn-widget-content tn-bg-light tn-corner-all">
                <a class="tn-menu-text" href='<% =ResolveUrl("~/TestPage1.aspx")%> ' ><span>Test page</span></a>
            </li>
            <li class="tn-selected tn-widget-content tn-bg-light tn-corner-all">
                <a class="tn-menu-text" href='<% =ResolveUrl("~/WebForm1.aspx")%> ' ><span>Web page</span></a>
            </li>
        </ul>
    </div>
</div>

