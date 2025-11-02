using System.Net.Http.Json;
namespace CRM.Blazor.Services;
using global::CRM.DataAccess.Models;
using CRM.Shared;

   /// <summary>
   /// Service to fetch contact reference data from the API.
   /// This service will be used to populate the multi-select combo box for names.
   /// </summary>
   public class ContactService
   {
      private readonly HttpClient _httpClient;

      public ContactService(HttpClient httpClient)
      {
         _httpClient = httpClient;
      }

      /// <summary>
      /// Asynchronously retrieves all contacts from the Contacts API endpoint.
      /// </summary>
      /// <returns>A list of ReferenceItem objects.</returns>
      public async Task<List<ReferenceItem>?> GetContactsAsync()
      {
         return await _httpClient.GetFromJsonAsync<List<ReferenceItem>>("api/contacts");
      }
   }

