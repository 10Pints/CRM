using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRM.DataAccess.Models
{
   /// <summary>
   /// Represents a Country entity from the database.
   /// This model is a Plain Old C# Object (POCO) used to transfer data.
   /// </summary>
   public class Country
   {
      public int Id { get; set; }
      public string Name { get; set; } = string.Empty;
   }
}
