using CRM.DataAccess.Models;
using CRM.DataAccess.Repositories;
using Microsoft.AspNetCore.Mvc;

namespace CRM.Api.Controllers;

[ApiController]
[Route("api/[controller]")]
public class AreasController : ControllerBase
{
   private readonly AreaRepository _areaRepository;

   public AreasController(AreaRepository areaRepository)
   {
      _areaRepository = areaRepository;
   }

   /// <summary>
   /// GET endpoint to retrieve all areas for the search filter.
   /// </summary>
   /// <returns>An ActionResult containing a list of ReferenceItem objects.</returns>
   [HttpGet]
   public async Task<ActionResult<List<ReferenceItem>>> Get()
   {
      try
      {
         var areas = await _areaRepository.GetAllAreasAsync();
         return Ok(areas);
      }
      catch (Exception ex)
      {
         return StatusCode(StatusCodes.Status500InternalServerError, $"Error retrieving data from the database: {ex.Message}");
      }
   }
}
