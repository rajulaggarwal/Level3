<%@ Page Language="C#" Inherits="Basic.Web.BaseViewPage<AppUser>" %>
<asp:content contentplaceholderid="pageNameContent" runat="server">
My Profile
</asp:content>
<asp:Content runat="server" ContentPlaceHolderID="HeaderContent">
<%
    ViewData["UserManageSubMenu"] = UserManageSubMenu.UserProfile;
    Html.RenderPartial("~/admin/Controls/Menus/UserManageMenu.ascx", ViewData);
%>
</asp:Content>
<asp:content contentplaceholderid="operationContent" runat="server">

</asp:content>
<asp:content id="Content3" contentplaceholderid="wideContent" runat="server">
<%
    string returnUrl = string.Empty;
    if (TempData["returnUrl"] != null)
        returnUrl = TempData.GetString("returnUrl");  
    if (TempData["StatusMessageType"] != null)
    {
        StatusMessageType messageType = (StatusMessageType)TempData.GetInt("StatusMessageType", (int)StatusMessageType.Error);
        Response.Write(BaseHtmlHelper.Instance().StatusMessage(messageType, TempData.GetString("StatusMessageContent", string.Empty), 3000));
        TempData["StatusMessageType"] = null;
    }
    
    if (ViewData.Model != null)
    {
        AppUser u = ViewData.Model as AppUser;
        if (u != null)
        {        
%>
<form id="EditProfile" action="<%=Url.Action("UpdateProfile", "App", new { userID = u.UserID })%>" method="post">
<input type="hidden" id="returnUrl" name="returnUrl" value="<%=returnUrl %>"  />
  <div class="tn-form tn-label-right spb-modify-user-info">
    <h4 class="tn-text-heading tn-border-gray tn-border-bottom">Edit Profile</h4>
    <div class="tn-form-row">
      <label class="tn-form-label">UserName：</label>
      <%=u.User.UserName%> 
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Is System Admin：</label>
      <%=u.User.IsSystemAdministrator ? "Yes" : "No"%> 
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">LastLoginIP：</label>
      <%=u.User.LastLoginIP%> 
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">LastLoginDate：</label>
      <%=u.User.LastLoginDate.ToString()%> 
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Company Name：</label>
      <%= u.Company.CompanyName %>
    </div>
    
    <div class="tn-form-row">
      <label class="tn-form-label">NickName：</label> 
      <input id="NickName" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Nick name" name="NickName" value="<%=u.User.NickName%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">RealName：</label> 
      <input id="RealName" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Real Name" name="RealName" value="<%=u.User.RealName%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Email：</label> 
      <input id="email" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Email" name="Email" value="<%=u.User.Email%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Mobile No.：</label> 
      <input id="mobileNo" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Mobile No." name="MobileNo" value="<%=u.User.MobileNo%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Tel No.：</label> 
      <input id="telNo" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Telephone No." name="TelNo" value="<%=u.User.TelNo%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Fax：</label> 
      <input id="fax" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Fax" name="Fax" value="<%=u.User.Fax%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">Address：</label> 
      <input id="address" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Address" name="Address" value="<%=u.User.Address%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">TaxID：</label> 
      <input id="taxID" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Tax ID" name="taxID" value="<%= u.TaxID %>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">DataSourceNumber：</label> 
      <input id="dataSourceNumber" class="tn-textbox tn-input-long tn-border-gray" type="text" title="DataSource Number" name="dataSourceNumber" value="<%=u.DataSourceNumber%>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">AccountNumber：</label>
      <input id="accountNumber" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Account Number" name="accountNumber" value="<%= u.AccountNumber %>" />
    </div>
    <div class="tn-form-row">
      <label class="tn-form-label">ProcessorNum：</label>
      <input id="processorNum" class="tn-textbox tn-input-long tn-border-gray" type="text" title="Processor Num" name="processorNum" value="<%= u.ProcessorNum %>" />
    </div>

    <div class="tn-form-row tn-form-row-button"><label class="tn-form-label"></label>
      <%=BaseHtmlHelper.Instance().SubmitButton("saveButton", GetResourceString("Button_Save"), ButtonSizes.Default,null, null)%> 
       <% if (Request.UrlReferrer != null)
          {%>
        <%=BaseHtmlHelper.Instance().LinkButton("", GetResourceString("Button_Cancel"),Request.UrlReferrer.AbsoluteUri, ButtonSizes.Large, HighlightStyles.Secondary, null, TextIconLayout.TextOnly)%>
    <%} %>
     </div>
    <script type="text/javascript">
        $(document).ready(function () {
            //            $('#UserStatus').change();
            //            $('#ManageState').change();
            $("#smsIDMessageSuccess").hide();
            $("#smsIDMessageSuccess").hide();
            $("#smsIDMessageError").hide();
            $("#EditProfile").validate({
                rules: {
                    realName: { required: true, maxBlength: 30 }
                },
                messages: {
                    realName: { required: "Please enter a name", maxBlength: "Enter up to 30 words" }
                }
            });

            $("#smsID").blur(function () {
                if ($('#smsID').attr("value"))
                    $.get('<%=Url.Action("ValidateSmsID","App") %>', { smsID: $('#smsID').attr("value") }, function (data) {

                        $("#smsIDMessageNormal").text(data.result);
                        if (data.isSuccess) {
                            $("#smsIDMessageSuccess").show();
                            $("#smsIDMessageError").hide();
                        }
                        else {
                            $("#smsIDMessageError").show();
                            $("#smsIDMessageSuccess").hide();
                        }
                    });
            });

        });

    </script>
  </div>
</form>
<%
        }
    }
%>
</asp:content>
