using System.Net.Http.Json;
using CRM.DataAccess.Models; // Note: Blazor needs access to the shared model

namespace CRM.Blazor.Services
{
   /// <summary>
   /// Service to fetch data from the Countries API.
   /// </summary>
   public class CountryService
   {
      private readonly HttpClient _httpClient;

      public CountryService(HttpClient httpClient)
      {
         _httpClient = httpClient;
      }

      public async Task<List<Country>?> GetCountriesAsync()
      {
         // The base URL for the API is configured in Program.cs
         // This call will be to "http://localhost:XXXX/api/countries"
         return await _httpClient.GetFromJsonAsync<List<Country>>("api/countries");
      }
   }
}