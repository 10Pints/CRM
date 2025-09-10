using CRM.DataAccess.Models;
using Microsoft.Data.SqlClient;
using System.Data;

namespace CRM.DataAccess.Repositories
{
   /// <summary>
   /// Handles all data access operations for the Country entity.
   /// This class directly interacts with the SQL Server database.
   /// </summary>
   public class CountryRepository
   {
      private readonly string _connectionString;

      public CountryRepository(string connectionString)
      {
         _connectionString = connectionString;
      }

      /// <summary>
      /// Asynchronously retrieves all countries from the database by executing a stored procedure.
      /// </summary>
      /// <returns>A list of Country objects.</returns>
      public async Task<List<Country>> GetAllCountriesAsync()
      {
         var countries = new List<Country>();

         // The 'using' statement ensures the connection is properly closed and disposed of.
         using (var connection = new SqlConnection(_connectionString))
         {
            // The 'using' statement also ensures the command is disposed of.
            using (var command = new SqlCommand("dbo.sp_get_all_countries", connection))
            {
               command.CommandType = CommandType.StoredProcedure;

               try
               {
                  await connection.OpenAsync();

                  using (var reader = await command.ExecuteReaderAsync())
                  {
                     while (await reader.ReadAsync())
                     {
                        countries.Add(new Country
                        {
                           // Use GetOrdinal for better performance and to prevent issues
                           // if column order changes in the stored procedure.
                           Id = reader.GetInt32(reader.GetOrdinal("ID")),
                           Name = reader.GetString(reader.GetOrdinal("name"))
                        });
                     }
                  }
               }
               catch (SqlException ex)
               {
                  // Log or handle the exception appropriately
                  Console.WriteLine($"A SQL error occurred: {ex.Message}");
                  // Optionally re-throw or return an empty list
                  throw;
               }
            }
         }

         return countries;
      }
   }
}
