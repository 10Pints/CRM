using CRM.DataAccess.Models;
using CRM.Shared;
using Microsoft.Data.SqlClient;

using System.Data;

namespace CRM.DataAccess.Repositories;

/// <summary>
/// Handles all data access operations for Area reference data.
/// This class interacts with the SQL Server database to get a list of areas.
/// </summary>
public class AreaRepository
{
   private readonly string _connectionString;

   public AreaRepository(string connectionString)
   {
      _connectionString = connectionString;
   }

   /// <summary>
   /// Asynchronously retrieves all areas from the database by executing the sp_get_all_areas stored procedure.
   /// </summary>
   /// <returns>A list of ReferenceItem objects.</returns>
   public async Task<List<CRM.Shared.ReferenceItem>> GetAllAreasAsync()
   {
      List<ReferenceItem>? areas = new List<ReferenceItem>();
      using (var connection = new SqlConnection(_connectionString))
      {
         using (var command = new SqlCommand("sp_get_all_areas", connection))
         {
            command.CommandType = CommandType.StoredProcedure;
            try
            {
               await connection.OpenAsync();
               using (var reader = await command.ExecuteReaderAsync())
               {
                  while (await reader.ReadAsync())
                  {
                     areas.Add(new ReferenceItem
                     {
                        Id = reader.GetInt32(reader.GetOrdinal("ID")),
                        Name = reader.GetString(reader.GetOrdinal("Name"))
                     });
                  }
               }
            }
            catch (SqlException ex)
            {
               Console.WriteLine($"AreaRepository: A SQL error occurred: {ex.Message}");
               throw;
            }
         }
      }
      return areas;
   }
}
