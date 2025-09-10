using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CRM.DataAccess.Models;

/// <summary>
/// A generic model for any type of reference data (e.g., Contacts, Areas, Status).
/// </summary>
public class ReferenceItem
{
   public int Id { get; set; }
   public string Name { get; set; } = string.Empty;
}
