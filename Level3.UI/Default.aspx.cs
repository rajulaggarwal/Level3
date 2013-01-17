using System.Web;
using System.Web.Mvc;
using System.Web.UI;

namespace UI
{
    public partial class _Default : Page
    {
        protected void Page_PreInit(object sender, System.EventArgs e)
        {
            string url = "/";
            var httpContext = HttpContext.Current;

            //MVC 3 running on IIS 7+
            if (HttpRuntime.UsingIntegratedPipeline)
            {
                httpContext.Server.TransferRequest(url, true);
            }
            else
            {
                // Pre MVC 3
                httpContext.RewritePath(url, false);
                IHttpHandler httpHandler = new MvcHttpHandler();
                httpHandler.ProcessRequest(httpContext);
            }
        }
    }
}
