using CRM.Blazor.Services;

using CRMBlazorApp.Data;

using Microsoft.AspNetCore.Components;
using Microsoft.AspNetCore.Components.Web;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.
builder.Services.AddRazorPages();
builder.Services.AddServerSideBlazor();

// Register the CountryService for dependency injection
builder.Services.AddScoped<CountryService>();

// Register the AgentService for dependency injection
builder.Services.AddScoped<AgentService>();

// Register the HttpClient for dependency injection
builder.Services.AddScoped(sp => new HttpClient { BaseAddress = new Uri("https://localhost:7064/") });

var app = builder.Build();

// Configure the HTTP request pipeline.
if (!app.Environment.IsDevelopment())
{
   app.UseExceptionHandler("/Error");
   // The default HSTS value is 30 days. You may want to change this for production scenarios, see https://aka.ms/aspnetcore-hsts.
   app.UseHsts();
}

app.UseHttpsRedirection();

app.UseStaticFiles();

app.UseRouting();

app.MapBlazorHub();
app.MapFallbackToPage("/_Host");

app.Run();