using System.Net.Http.Json;
using CRM.DataAccess.Models;
using CRM.Blazor.Models;
using CRM.Shared;

namespace CRM.Blazor.Services
{
    /// <summary>
    /// Service to handle agent-related data fetching and operations.
    /// </summary>
public class AgentService
    {
        private readonly HttpClient _httpClient;

        public AgentService(HttpClient httpClient)
        {
            _httpClient = httpClient;
        }

        /// <summary>
        /// Retrieves all agents from the API.
        /// </summary>
        /// <returns>A list of all agents.</returns>
        public async Task<List<Agent>?> GetAgentsAsync()
        {
            try
            {
                return await _httpClient.GetFromJsonAsync<List<Agent>>("api/agents");
            }
            catch (HttpRequestException ex)
            {
                Console.WriteLine($"Error fetching agents: {ex.Message}");
                return null;
            }
        }

        /// <summary>
        /// Searches for agents based on the provided search criteria by making a POST request to the API.
        /// </summary>
        /// <param name="criteria">The search criteria model.</param>
        /// <returns>A filtered list of agents.</returns>
        public async Task<List<Agent>?> SearchAgentsAsync(SearchCriteria criteria)
        {
            try
            {
                var response = await _httpClient.PostAsJsonAsync("api/agents/search", criteria);
                response.EnsureSuccessStatusCode();
                return await response.Content.ReadFromJsonAsync<List<Agent>>();
            }
            catch (HttpRequestException ex)
            {
                Console.WriteLine($"Error searching for agents: {ex.Message}");
                return new List<Agent>();
            }
        }
    }
}
