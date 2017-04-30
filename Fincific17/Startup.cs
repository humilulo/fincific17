using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Fincific17.Startup))]
namespace Fincific17
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
        }
    }
}
