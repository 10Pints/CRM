using Microsoft.AspNetCore.Mvc;

using CRM.DataAccess.Models;
using CRM.DataAccess.Repositories;

namespace CRM.Api.Controllers
{
   [ApiController]
   [Route("api/[controller]")]
   public class CountriesController : ControllerBase
   {
      private readonly CountryRepository _countryRepository;

      /// <summary>
      /// The constructor receives the CountryRepository instance via dependency injection.
      /// </summary>
      /// <param name="countryRepository">The injected repository instance.</param>
      public CountriesController(CountryRepository countryRepository)
      {
         _countryRepository = countryRepository;
      }

      /// <summary>
      /// GET endpoint to retrieve all countries.
      /// </summary>
      /// <returns>An ActionResult containing a list of Country objects.</returns>
      [HttpGet]
      public async Task<ActionResult<List<Country>>> Get()
      {
         try
         {
            var countries = await _countryRepository.GetAllCountriesAsync();
            return Ok(countries);
         }
         catch (Exception ex)
         {
            // Return a 500 Internal Server Error for any unhandled exceptions
            return StatusCode(StatusCodes.Status500InternalServerError, $"Error retrieving data from the database: {ex.Message}");
         }
      }
   }
}
