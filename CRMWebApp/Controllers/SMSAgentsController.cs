using CRM.DataAccess.Models;
//using CRM.Shared.Models;
using Microsoft.AspNetCore.Mvc;

namespace CRM.API.Controllers
{
   [ApiController]
   [Route("api/[controller]")]
   public class AgentsController : ControllerBase
   {
      [HttpGet]
      public IEnumerable<Agent> GetAgents()
      {
         // For now, we return mock data.
         return new List<Agent>
            {
                new Agent { AgentId = 1, FirstName = "Juan", LastName = "Dela Cruz", PhoneNumber = "639171234567", Email = "juan.delacruz@example.com" },
                new Agent { AgentId = 2, FirstName = "Maria", LastName = "Santos", PhoneNumber = "639207654321", Email = "maria.santos@example.com" },
                new Agent { AgentId = 3, FirstName = "Jose", LastName = "Rizal", PhoneNumber = "639151122334", Email = "jose.rizal@example.com" }
            };
      }
   }
}

