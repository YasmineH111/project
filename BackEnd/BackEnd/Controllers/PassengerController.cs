using BackEnd.DTO.Driver;
using BackEnd.DTO.Passenger;
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
    public class PassengerController : ControllerBase
    {
        private readonly OntheRoadDBContext _context;
        private readonly IPasswordHasher<Passenger> _passwordHasher;

        public PassengerController(OntheRoadDBContext context, IPasswordHasher<Passenger> passwordHasher)
        {
            _context = context;
            _passwordHasher = passwordHasher;
        }

        [HttpPost("register")]
        public async Task<IActionResult> Register([FromBody] RegisterPassengerDTO dto)
        {
            if (await _context.Passengers.AnyAsync(p => p.Email == dto.Email))
            {
                return BadRequest("Email already in use.");
            }

            var passenger = new Passenger
            {
                Email = dto.Email,
                Name = dto.Name,
                MobileNumber = dto.MobileNumber,
                
                
            };

            // Correctly using HashPassword with the new passenger instance and dto.Password
            passenger.PasswordHash = _passwordHasher.HashPassword(passenger, dto.Password);

            _context.Passengers.Add(passenger);
            await _context.SaveChangesAsync();
            return Ok(new { status = "ok" });
        }

        [HttpPost("login")]
        public async Task<IActionResult> Login([FromBody] LoginDriverDTO dto)
        {
            var passenger = await _context.Passengers
                .FirstOrDefaultAsync(d => d.Email == dto.Email);

            if (passenger == null ||
                _passwordHasher.VerifyHashedPassword(passenger, passenger.PasswordHash, dto.Password) != Microsoft.AspNetCore.Identity.PasswordVerificationResult.Success)
            {
                return Unauthorized("Invalid credentials.");
            }
            var token = GenerateJwtToken(passenger);

            // Create a response object including the token and driver details
            var response = new
            {
                token = token,
                passenger = new
                {
                    passenger.PassengerId,
                    passenger.Name,
                    passenger.Email,
                    // Include other relevant details
                }
            };


            return Ok(response);
        }
        private string GenerateJwtToken(Passenger passenger)
        {
            var tokenHandler = new System.IdentityModel.Tokens.Jwt.JwtSecurityTokenHandler();
            var keyString = "your_secret_key_here_ensure_it_is_at_least_32_chars";  // Extend this to ensure it's at least 32 characters
            var key = Encoding.ASCII.GetBytes(keyString);

            var tokenDescriptor = new SecurityTokenDescriptor
            {
                Subject = new ClaimsIdentity(new Claim[]
                {
            new Claim(ClaimTypes.NameIdentifier, passenger.PassengerId.ToString()),
            new Claim(ClaimTypes.Email, passenger.Email)
                    // Add additional claims as needed
                }),
                Expires = DateTime.UtcNow.AddDays(7), // Set token expiration as needed
                SigningCredentials = new SigningCredentials(new SymmetricSecurityKey(key), SecurityAlgorithms.HmacSha256Signature)
            };

            var token = tokenHandler.CreateToken(tokenDescriptor);
            return tokenHandler.WriteToken(token);
        }


        [HttpGet("{id}")]
        public async Task<IActionResult> GetPassenger(int id)
        {
            var passenger = await _context.Passengers.FindAsync(id);
            if (passenger == null)
            {
                return NotFound();
            }

            return Ok(passenger);
        }

        [HttpDelete("{id}")]
        public async Task<IActionResult> DeletePassenger(int id)
        {
            var passenger = await _context.Passengers.FindAsync(id);
            if (passenger == null)
            {
                return NotFound();
            }

            _context.Passengers.Remove(passenger);
            await _context.SaveChangesAsync();

            return Ok("ok");
        }
        [HttpGet]
        public async Task<IActionResult> GetAllPassengers()
        {
            var passengers = await _context.Passengers
                .Select(p => new
                {
                    p.PassengerId,
                    p.Name,
                    p.Email,
                    p.MobileNumber
                })
                .ToListAsync();

            if (passengers == null || passengers.Count == 0)
            {
                return NotFound("No passengers found.");
            }

            return Ok(passengers);
        }

        [HttpPut("{id}")]
        public async Task<IActionResult> UpdatePassengerProfile(int id, [FromBody] UpdatePassengerDTO dto)
        {
            var passenger = await _context.Passengers.FindAsync(id);
            if (passenger == null)
            {
                return NotFound("Passenger not found.");
            }

            // Update passenger details
            passenger.Name = dto.Name ?? passenger.Name;
            passenger.MobileNumber = dto.MobileNumber ?? passenger.MobileNumber;
            passenger.Email = dto.Email ?? passenger.Email;

            // Update password if provided
            if (!string.IsNullOrEmpty(dto.Password))
            {
                passenger.PasswordHash = _passwordHasher.HashPassword(passenger, dto.Password);
            }

            _context.Passengers.Update(passenger);
            await _context.SaveChangesAsync();

            return Ok(new
            {
                message = "Profile updated successfully",
                passenger = new
                {
                    passenger.PassengerId,
                    passenger.Name,
                    passenger.Email,
                    passenger.MobileNumber
                }
            });
        }
    }
}
