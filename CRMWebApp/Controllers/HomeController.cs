using CRM.DataAccess.Models;
using CRM.DataAccess.Repositories;
using CRM.Shared.Models;

using Microsoft.AspNetCore.Mvc;

namespace CRM.Api.Controllers
{
   [ApiController]
   [Route("api/[controller]")]
   public class ContactsController : ControllerBase
   {
      private readonly ContactRepository _contactRepository;

      public ContactsController(ContactRepository contactRepository)
      {
         _contactRepository = contactRepository;
      }

      /// <summary>
      /// GET endpoint to retrieve all contacts for the search filter.
      /// </summary>
      /// <returns>An ActionResult containing a list of ReferenceItem objects.</returns>
      [HttpGet]
      public async Task<ActionResult<List<ReferenceItem>>> Get()
      {
         try
         {
            var contacts = await _contactRepository.GetAllContactsAsync();
            return Ok(contacts);
         }
         catch (Exception ex)
         {
            return StatusCode(StatusCodes.Status500InternalServerError, $"Error retrieving data from the database: {ex.Message}");
         }
      }
   }
}
