using CRM.DataAccess.Models;
using System.Net.Http;
using System.Net.Http.Json;
using System.Threading.Tasks;
using System.Collections.Generic;

namespace CRM.Blazor.Services;
public class AgentService
{
   private readonly HttpClient _httpClient;

   public AgentService(HttpClient httpClient)
   {
      _httpClient = httpClient;
   }

   public async Task<List<Agent>?> GetAgentsAsync()
   {
      return await _httpClient.GetFromJsonAsync<List<Agent>>("api/agents");
   }
}
