using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.AspNetCore.Identity;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using Microsoft.OpenApi.Models;
using System.Text;
using BackEnd.Models;
using Microsoft.AspNetCore.Http.Features;
using System.Text.Json.Serialization;
using Microsoft.Extensions.FileProviders;
using System;

var builder = WebApplication.CreateBuilder(args);

// Configure database context
builder.Services.AddDbContext<OntheRoadDBContext>(options =>
    options.UseSqlServer(builder.Configuration.GetConnectionString("DefaultConnection")));
builder.Services.AddScoped<IPasswordHasher<Passenger>, PasswordHasher<Passenger>>();
builder.Services.AddScoped<IPasswordHasher<Driver>, PasswordHasher<Driver>>();

// Register services and interfaces 
builder.Services.AddCors(options =>
{
    options.AddPolicy("AllowAllOrigins", policy =>
    {
        policy.AllowAnyOrigin()
              .AllowAnyMethod()
              .AllowAnyHeader();
    });
});


// Configure JWT authentication
var jwtKey = builder.Configuration["Jwt:Key"];
var jwtIssuer = builder.Configuration["Jwt:Issuer"];
builder.Services.AddAuthentication(options =>
{
    options.DefaultAuthenticateScheme = JwtBearerDefaults.AuthenticationScheme;
    options.DefaultChallengeScheme = JwtBearerDefaults.AuthenticationScheme;
})
.AddJwtBearer(options =>
{
    options.TokenValidationParameters = new TokenValidationParameters
    {
        ValidateIssuer = true,
        ValidateAudience = true,
        ValidateLifetime = true,
        ValidateIssuerSigningKey = true,
        ValidIssuer = jwtIssuer,
        ValidAudience = jwtIssuer,
        IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(jwtKey))
    };
});

// Configure form options for large file uploads
builder.Services.Configure<FormOptions>(options =>
{
    options.MultipartBodyLengthLimit = 20 * 1024 * 1024; // Set the limit to 20MB
});


// Register controllers
builder.Services.AddControllers();


// Configure Swagger with JWT Authentication support
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo { Title = "3al Tare2 API", Version = "v1" });

    // JWT Authentication setup for Swagger
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        In = ParameterLocation.Header,
        Description = "Please insert JWT token into field",
        Name = "Authorization",
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            new string[] {}
        }
    });
});

// Build the app
var app = builder.Build();

// Seed roles on application startup
//using (var scope = app.Services.CreateScope())
//{
//    var roleManager = scope.ServiceProvider.GetRequiredService<RoleManager<IdentityRole>>();
//    await SeedRolesAsync(roleManager);
//}
app.UseCors("AllowAllOrigins");
// Configure the HTTP request pipeline
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI();
}
app.UseSwagger();
app.UseSwaggerUI();
app.UseStaticFiles();
 
app.UseRouting();
app.UseHttpsRedirection();
// Enable Authentication and Authorization middleware
app.UseAuthentication();    
app.UseAuthorization();
// Map controllers
app.MapControllers();

// Run the application
app.Run();

// Method to seed roles
async Task SeedRolesAsync(RoleManager<IdentityRole> roleManager)
{
    string[] roleNames = { "LostMan", "Admin" };

    foreach (var roleName in roleNames)
    {
        if (!await roleManager.RoleExistsAsync(roleName))
        {
            var roleResult = await roleManager.CreateAsync(new IdentityRole(roleName));

            if (!roleResult.Succeeded)
            {
                // Log or handle the error as needed
                Console.WriteLine($"Error creating role {roleName}: {string.Join(", ", roleResult.Errors.Select(e => e.Description))}");
            }
        }
    }
}
