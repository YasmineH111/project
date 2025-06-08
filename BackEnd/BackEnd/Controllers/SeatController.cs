using BackEnd.DTO.Seat;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class SeatController : ControllerBase
    {
        private readonly OntheRoadDBContext _context;

        public SeatController(OntheRoadDBContext context)
        {
            _context = context;
        }

        [HttpPost("add")]
        public async Task<IActionResult> AddSeat([FromBody] SeatCreateDTO dto)
        {
            var seat = new Seat
            {
                TripId = dto.TripId,
                SeatNumber = dto.SeatNumber,
                IsAvailable = dto.IsAvailable,
                GenderPreference = dto.GenderPreference
            };

            _context.Seats.Add(seat);
            await _context.SaveChangesAsync();
            return Ok("Seat added successfully.");
        }

        [HttpGet("get/{id}")]
        public async Task<IActionResult> GetSeat(int id)
        {
            var seat = await _context.Seats
                .Include(s => s.Trip)
                .FirstOrDefaultAsync(s => s.SeatId == id);

            if (seat == null)
            {
                return NotFound("Seat not found.");
            }

            return Ok(seat);
        }

        [HttpPut("update/{id}")]
        public async Task<IActionResult> UpdateSeat(int id, [FromBody] SeatUpdateDTO dto)
        {
            var seat = await _context.Seats.FindAsync(id);
            if (seat == null)
            {
                return NotFound("Seat not found.");
            }

            seat.IsAvailable = dto.IsAvailable;
            seat.GenderPreference = dto.GenderPreference;

            await _context.SaveChangesAsync();
            return Ok("Seat updated successfully.");
        }

        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> DeleteSeat(int id)
        {
            var seat = await _context.Seats.FindAsync(id);
            if (seat == null)
            {
                return NotFound("Seat not found.");
            }

            _context.Seats.Remove(seat);
            await _context.SaveChangesAsync();
            return Ok("Seat deleted successfully.");
        }
    }

}
