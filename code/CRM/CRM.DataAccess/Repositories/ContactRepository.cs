using Microsoft.Data.SqlClient;
using System.Data;
using CRM.Shared;
using global::CRM.DataAccess.Models;

namespace CRM.DataAccess.Repositories;

/// <summary>
/// Handles all data access operations for Contact reference data.
/// This class interacts with the SQL Server database to get a list of contacts.
/// </summary>
public class ContactRepository
{
   private readonly string _connectionString;

   public ContactRepository(string connectionString)
   {
      _connectionString = connectionString;
   }

   /// <summary>
   /// Asynchronously retrieves all contacts from the database by executing the sp_get_all_contacts stored procedure.
   /// </summary>
   /// <returns>A list of ReferenceItem objects.</returns>
   public async Task<List<ReferenceItem>> GetAllContactsAsync()
   {
      var contacts = new List<ReferenceItem>();
      using (var connection = new SqlConnection(_connectionString))
      {
         using (var command = new SqlCommand("sp_get_all_contacts", connection))
         {
            command.CommandType = CommandType.StoredProcedure;
            try
            {
               await connection.OpenAsync();
               using (var reader = await command.ExecuteReaderAsync())
               {
                  while (await reader.ReadAsync())
                  {
                     contacts.Add(new ReferenceItem
                     {
                        Id = reader.GetInt32(reader.GetOrdinal("ID")),
                        Name = reader.GetString(reader.GetOrdinal("Name"))
                     });
                  }
               }
            }
            catch (SqlException ex)
            {
               Console.WriteLine($"ContactRepository: A SQL error occurred: {ex.Message}");
               throw;
            }
         }
      }

      return contacts;
   }
}

