// Initial Program.cs content
using CRM.DataAccess.Repositories;
using Microsoft.Data.SqlClient;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();

// Step 1: Add a reference to CRM.DataAccess from the CRM.Api project.
// In Visual Studio, right-click CRM.Api -> Add -> Project Reference, then select CRM.DataAccess.

// Step 2: Read the connection string from appsettings.json.
string connectionString = builder.Configuration.GetConnectionString("DefaultConnection") ?? "";

// Step 3: Register the CountryRepository as a scoped service.
// This ensures a new instance is created for each request.
// We are passing the connection string to its constructor.
builder.Services.AddScoped(s => new CountryRepository(connectionString));

// New: Register the ContactRepository and AreaRepository
builder.Services.AddScoped(s => new ContactRepository(connectionString));
builder.Services.AddScoped(s => new AreaRepository(connectionString));

// Add controllers support for the API.
builder.Services.AddControllers();

// Step 4: Add CORS policy to allow the Blazor app to make requests.
// Adjust the policy to match your Blazor app's URL in a production environment.
builder.Services.AddCors(options =>
{
   options.AddPolicy("BlazorAppPolicy", policy =>
   {
      // For development, allow all origins. In production, specify a concrete origin like "http://localhost:5001"
      policy.AllowAnyOrigin()
            .AllowAnyHeader()
            .AllowAnyMethod();
   });
});

var app = builder.Build();

// Configure the HTTP request pipeline.
if (app.Environment.IsDevelopment())
{
   app.UseSwagger();
   app.UseSwaggerUI();
}

app.UseHttpsRedirection();

// Use the CORS policy.
app.UseCors("BlazorAppPolicy");

app.UseAuthorization();

// Map controllers for the API.
app.MapControllers();

app.Run();
