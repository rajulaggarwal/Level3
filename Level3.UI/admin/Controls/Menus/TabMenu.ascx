<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<%ManageMenu manageMenu = ViewData.Get<ManageMenu>("ManageMenu", ManageMenu.HomeManage);  %>
<ul class="tn-nav1 tn-helper-reset">
      <li class="tn-nav-item <%if (manageMenu == ManageMenu.UserManage) Response.Write(" tn-selected"); %>">
            <a href="<%=BaseUrlHelper.Action("EditProfile", "App")%>"><span>User Management</span></a>
      </li>
</ul>
                                                                                                                