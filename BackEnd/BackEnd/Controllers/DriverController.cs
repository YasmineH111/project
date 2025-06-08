using BackEnd.DTO.Driver;
using BackEnd.Models;
using Microsoft.AspNet.Identity;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.IdentityModel.Tokens;
using System.Security.Claims;
using System.Text;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class DriverController : ControllerBase
    {

        private readonly OntheRoadDBContext _context;
        private readonly IPasswordHasher<Driver> _passwordHasher;

        public DriverController(OntheRoadDBContext context, IPasswordHasher<Driver> passwordHasher)
        {
            _context = context;
            _passwordHasher = passwordHasher;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterDriverDTO dto)
        {
            if (await _context.Drivers.AnyAsync(d => d.Email == dto.Email))
            {
                return BadRequest(new { status = "error", message = "Email already in use." });
            }

            var driver = new Driver
            {
                Email = dto.Email,
                Name = dto.Name,
                MobileNumber = dto.MobileNumber,
                LicenseNumber = dto.LicenseNumber,
            };

            driver.PasswordHash = _passwordHasher.HashPassword(driver, dto.Password);
            _context.Drivers.Add(driver);
            await _context.SaveChangesAsync();

            // Return an object with the desired format
            return Ok(new { status = "ok" });
        }


        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDriverDTO dto)
        {
            var driver = await _context.Drivers
                .FirstOrDefaultAsync(d => d.Email == dto.Email);

            if (driver == null ||
                _passwordHasher.VerifyHashedPassword(driver, driver.PasswordHash, dto.Password) != Microsoft.AspNetCore.Identity.PasswordVerificationResult.Success)
            {
                return Unauthorized("Invalid credentials.");
            }
            var token = GenerateJwtToken(driver);

            // Create a response object including the token and driver details
            var response = new
            {
                token = token,
                driver = new
                {
                    driver.DriverId,
                    driver.Name,
                    driver.Email,
                    // Include other relevant details
                }
            };


            return Ok(response);
        }
        private string GenerateJwtToken(Driver driver)
        {
            var tokenHandler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var keyString = "your_secret_key_here_ensure_it_is_at_least_32_chars";  // Extend this to ensure it's at least 32 characters
            var key = Encoding.ASCII.GetBytes(keyString);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
            new Claim(ClaimTypes.NameIdentifier, driver.DriverId.ToString()),
            new Claim(ClaimTypes.Email, driver.Email)
                    // Add additional claims as needed
                }),
                Expires = DateTime.UtcNow.AddDays(7), // Set token expiration as needed
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetDriver(int id)
        {
            var driver = await _context.Drivers.FindAsync(id);
            if (driver == null)
            {
                return NotFound();
            }

            return Ok(driver);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeleteDriver(int id)
        {
            var driver = await _context.Drivers.FindAsync(id);
            if (driver == null)
            {
                return NotFound();
            }

            _context.Drivers.Remove(driver);
            await _context.SaveChangesAsync();

            return Ok("Driver deleted successfully.");
        }
    }
}
