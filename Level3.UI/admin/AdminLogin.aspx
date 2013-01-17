<%@ Page Language="C#" Inherits="Basic.Web.BaseViewPage" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<title>Level3 Login</title>
<style>
<!--
*{padding:0; margin:0;}
body{background:#f7f7f7;font-size:12px;}
#login{width:489px;height:311px;background:url(<%=ResolveClientUrl("~/admin/images/login.gif")%>) no-repeat; position:absolute; top:50%;left:50%; 
margin:-155px 0 0 -244px;} 
h1{height:54px;width:269px;background:url(<%=ResolveClientUrl("~/admin/images/logo5.gif")%>) no-repeat;margin:37px 0 0 45px;}
form {width:375px; height:90px; margin:0 auto; padding:0; position:relative}
.item{width:265px;float:left; text-align:left;color:#666666; margin-top:16px;}
.input{border:1px #d2d2d2 solid;padding:5px 5px 0; float:right;line-height:21px; height:21px;background:url(<%=ResolveClientUrl("~/admin/images/inputbg.gif")%>);width:176px;}
.input input{border-width: 0;width:150px;height:18px;margin-left:8px;_margin-left:5px;}
label{line-height:28px; font-weight:bold;}
.icon{width:12px;height:18px; overflow:hidden;float:left;background:url(<%=ResolveClientUrl("~/admin/images/login_name.gif")%>) 0 2px no-repeat}
.icon2{width:12px;height:18px; float:left;background:url(<%=ResolveClientUrl("~/admin/images/login_password.gif")%>) no-repeat}
.icon3{width:12px;height:18px; float:left;background:url(<%=ResolveClientUrl("~/admin/images/login_validate.gif")%>) 0 2px no-repeat}
.submit{width:83px;height:75px;border:0; position:absolute; top:15px; right:0;background:url(<%=ResolveClientUrl("~/admin/images/login_submit.gif")%>); float:right; cursor:pointer}
.copyright{color:#aaaaaa;font-family:Arial,Helvetica,sans-serif; text-align:center; margin-top:20px;}
#notice{border:0;width:250px;height:20px;line-height:20px;clear:both;color:#FF0000;margin:8px 0 0 134px;}
td{font-size:12px; line-height:18px;}
.validate .input{width:100px;}
.validate .input input{text-transform:uppercase;}
.validate .vdimgck{width:70px;margin-left:6px;float:right;}
.validate .vdimgck img{border:1px solid #D2D2D2;margin-top:1px;cursor: pointer;}
-->
</style>
</head>
<body>
<div id="login">
	<div class="warp">
    	<div class="content">
            <h1></h1>
            <form method="post" name="form1" action="<%=Url.Action("AdminLoginAction","AppCommon",new { returnUrl=ViewData.GetString("returnUrl","") }) %>" >
			
			<input type="hidden" name="dopost" value="login" />
			<input name='adminstyle' type='hidden' value='newdedecms' />
            <div class="item">
				<div class="input">
					<div class="icon" title="UserName"></div>
						<input name="userName" value="" id="userName" tabindex="1" type="text" />
				</div>
				<label>UserName：</label>
			</div>
            <div class="item">
				<div class="input">
					<div class="icon2" title="Password"></div>
					<input name="password" value="" id="password" tabindex="2" type="password" />
				</div>
				<label>Password：</label>
			</div>
            <div class="item validate">
             <label style=" padding-right:80px;"></label>
              <%=BaseHtmlHelper.Instance().SubmitButton("loginButton", "Login", ButtonSizes.Large,null,null)%>
              </div>
			<%--<?php
			if(preg_match("/6/",$safe_gdopen))
			{
			?>
            <div class="item validate">
				<div class="vdimgck"><img id="vdimgck" onClick="this.src=this.src+'?'" alt="看不清？点击更换" src="../include/vdimgck.php"/></div>
				<div class="input">
					<div class="icon3" title="验证码"></div>
					<input name="validate" value="" id="validate" tabindex="2" type="text" style="width:75px;" />
				</div>
				<label>验证码：</label>
			</div>--%>
		
			<div class="item"><div style="line-height:22px; height:22px;"></div></div>
			
			<%--<input type="submit" tabindex="3" value="" class="submit" />--%>
            </form
    		<div id="notice"></div>
            <p class="copyright">Current IP:<%=IPHelper.GetIP() %></p>
        </div>
    </div>
</div>
 <%   
     TempData["CurrentIpAddress"] = IPHelper.GetIP();
         
     string refreshJS = "";
    //用户角色判断->角色权限判断->登录成功
    if (Request.QueryString.GetBool("isPermissionError", false))
    {
        StatusMessageType messageType = (StatusMessageType)TempData.GetInt("StatusMessageType", (int)StatusMessageType.Error);
        Response.Write(BaseHtmlHelper.Instance().StatusMessage(messageType, "您的用户角色没有此权限,将跳转到您的首页", new RouteValueDictionary { { "style", "width:160px" } }));
        TempData["StatusMessageType"] = null;

        refreshJS = string.Format("window.location.href='{0}';", "/");         
    }
    if (TempData["StatusMessageType"] != null)
    {
        StatusMessageType messageType = (StatusMessageType)TempData.GetInt("StatusMessageType", (int)StatusMessageType.Error);
        Response.Write(BaseHtmlHelper.Instance().StatusMessage(messageType, TempData.GetString("StatusMessageContent", string.Empty), new RouteValueDictionary { { "style", "width:160px" } }));
        TempData["StatusMessageType"] = null;
    }   
    %>
    <script type="text/javascript">
        setTimeout(" <%=refreshJS %> ", 2000);
    </script>
</body>
</html>
