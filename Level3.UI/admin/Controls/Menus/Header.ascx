<%@ Control Language="C#" Inherits="Basic.Web.BaseViewUserControl" %>
<div class="topMenu">          
    <ul class="sf-menu">
        <li><a href="#" target="_blank">Help</a>
            <ul class="tn-widget tn-widget-content tn-bg-light tn-corner-all" style="visibility: hidden; display: none;left: -95px;">      
               <li><a id="openPopup" title="Help for this page" href="#">Help on this page</a></li>
               <li><a href="/resources/Test.pdf" title="Download full Manual" target="_blank">Download Full Manual</a></li>
            </ul>
        </li>
        <li><a href="<%=Url.Action("AdminLogout","AppCommon") %>" title="Logout">Logout</a></li>
        <li>
            <a href="#" class="sf-with-ul"><%=Globals.GetCurrentUser().UserName %></a>
            <ul class="tn-widget tn-widget-content tn-bg-light tn-corner-all" style="visibility: hidden; display: none;">      
               <li><a href="<%=Url.Action("EditProfile","App") %>" title="My Profile">My Profile</a></li>
            </ul>
        </li>
        <li>Current User：</li>                   
    </ul>      
</div>

<div id="popup" style="display:none;">
        <div id="editProfile">
            <h1>Edit profile help text</h1>
            <p>
                Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. 
            </p>
        </div>
         <div id="testPage">
            <h1>Test Page help text</h1>
            <p>
                It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, content here', making it look like readable English.
            </p>
         </div>
</div>


<script type="text/javascript">
    $(document).ready(function () {
        $('ul.sf-menu').superfish();
    });

    $('#openPopup').click(function () {
        var pageName = $.trim($('.tn-pagename h1').text());
        $('#popup').dialog({ modal: true, height: 500, width: 600 });
        $("span.ui-dialog-title").text(pageName);
        if (pageName == 'My Profile') {
            $('#testPage').css("display","none");
            $('#editProfile').css("display", "block");
        }
        else if (pageName == 'Test Page') {
            $('#testPage').css("display", "block");
            $('#editProfile').css("display", "none");
        }
    });
    
</script>
