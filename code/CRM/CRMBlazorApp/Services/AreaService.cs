using CRM.Shared;
namespace CRM.Blazor.Services;

/// <summary>
/// Service to fetch area reference data from the API.
/// This service will be used to populate the multi-select combo box for areas.
/// </summary>
public class AreaService
{
   private readonly HttpClient _httpClient;

   public AreaService(HttpClient httpClient)
   {
      _httpClient = httpClient;
   }

   /// <summary>
   /// Asynchronously retrieves all areas from the Areas API endpoint.
   /// </summary>
   /// <returns>A list of ReferenceItem objects.</returns>
   public async Task<List<ReferenceItem>?> GetAreasAsync()
   {
      return await _httpClient.GetFromJsonAsync<List<ReferenceItem>>("api/areas");
   }
}