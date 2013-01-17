using System;
using System.Reflection;
using System.Web.Mvc;
using System.Web.Routing;

namespace Web
{
    public class GlobalApplication : System.Web.HttpApplication
    {
        protected void Application_Start(Object source, EventArgs e)
        {
            ControllerBuilder.Current.DefaultNamespaces.Add("Level3.App.Controllers");
            RegisterRoutes(RouteTable.Routes); 
        }

        protected void Application_End(Object source, EventArgs e)
        {

        }

        public static void RegisterRoutes(RouteCollection routes)
        {
          routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

          routes.MapRoute(
             "Common",
             "{controller}/{action}/{id}",
              new { controller = "App", action = "EditProfile", id = UrlParameter.Optional }
          );

        }

        protected void Application_Error(object sender, EventArgs e)
        {
            
        }
    }
}
