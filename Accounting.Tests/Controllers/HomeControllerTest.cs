using Accounting.Controllers;
using NUnit.Framework;

namespace Accounting.Tests.Controllers
{
    [TestFixture]
    public class HomeControllerTest
    {
        [Test]
        public void Index()
        {
            var controller = new HomeController();
            var view = controller.Index();
            Assert.NotNull(view);
        }
    }
}