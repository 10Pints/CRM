namespace CRM.Blazor.Models
{
   /// <summary>
   /// Represents the search criteria for agents.
   /// </summary>
   public class SearchCriteria
   {
      public List<int> SelectedContactIds { get; set; } = new List<int>();
      public List<int> SelectedAreaIds { get; set; } = new List<int>();
   }
}