using Accounting.Controllers;
using NUnit.Framework;

namespace Accounting.Tests.Controllers
{
    [TestFixture]
    public class HomeControllerTest
    {
        [TestCase]
        public void Index()
        {
            var controller = new HomeController();
            var view = controller.Index();
            Assert.NotNull(view);
        }
    }
}