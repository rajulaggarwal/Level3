<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<% TransactionManageMenu transactionManageMenu = TransactionManageMenu.TransactionManage;
   TransactionManageSubMenu transactionManageSubMenu = TransactionManageSubMenu.TransactionListing;
   if (ViewData["TransactionManageMenu"] != null)
       transactionManageMenu = ViewData.Get<TransactionManageMenu>("TransactionManageMenu");
   if (ViewData["TransactionManageSubMenu"] != null)
       transactionManageSubMenu = ViewData.Get<TransactionManageSubMenu>("TransactionManageSubMenu");
%>
<div class="tn-collapsible <%if (transactionManageMenu == TransactionManageMenu.TransactionManage) Response.Write(" tn-collapsible-opend"); else Response.Write("  tn-collapsible-closed");%>">
    <div class="tn-border-bottom tn-border-gray tn-collapsible-header tn-switch-left">
        <h4 class="tn-helper-reset">
            <span>Transactions</span></h4>
        <span class="tn-icon tn-switch tn-icon-collapse-close"></span>
    </div>
    <div style="" class="tn-collapsible-content">
        <ul class="tn-side-menu">
            <li class="<% if (transactionManageSubMenu == TransactionManageSubMenu.AddTransaction) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("Edit_Transaction", "App")%>"><span>Create Transaction</span></a></li>
            <li class="<% if (transactionManageSubMenu == TransactionManageSubMenu.UploadTrans) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("UploadTrans", "App")%>"><span>Upload Transaction</span></a></li>
            <li class="<% if (transactionManageSubMenu == TransactionManageSubMenu.TransactionListing) { Response.Write("tn-selected tn-widget-content tn-bg-light tn-corner-all"); } %>">
                <a class="tn-menu-text" href="<%=Url.Action("List_Transactions","App") %>"><span>Transaction Listing</span></a></li>
           
        </ul>
    </div>
</div>

