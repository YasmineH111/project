using BackEnd.DTO.Booking;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class BookingController : ControllerBase
    {
        private readonly OntheRoadDBContext _context;

        public BookingController(OntheRoadDBContext context)
        {
            _context = context;
        }
        [HttpPost("BookASeat")]
        public async Task<IActionResult> AddBooking([FromBody] BookingCreateDTO dto)
        {
            var booking = new Booking
            {
                PassengerId = dto.PassengerId,
                TripId = dto.TripId,
                SeatNumber = dto.SeatNumber,
                BookingTime = dto.BookingTime
            };

            var trip = await _context.Trips.SingleOrDefaultAsync(s => s.TripId == dto.TripId);
            if (trip == null)
            { 
                return NotFound(new { response = "Trip not found." });
            }

            trip.SeatsBooked += 1;

            var seat = await _context.Seats.SingleOrDefaultAsync(s => s.TripId == dto.TripId && s.SeatNumber == dto.SeatNumber);
            if (seat == null)
            {
                return NotFound(new {response= "Seat not found." });
            }

            seat.IsAvailable = false;
            seat.GenderPreference = dto.GenderPreference;

            _context.Bookings.Add(booking);
            await _context.SaveChangesAsync();

            return Ok(new {BookingId=booking.BookingId,booking.BookingTime,booking.SeatNumber});
        }

        //[HttpPost("BookASeat")]
        //public async Task<IActionResult> AddBooking([FromBody] BookingCreateDTO dto)
        //{
        //    var booking = new Booking
        //    {
        //        PassengerId = dto.PassengerId,
        //        TripId = dto.TripId,
        //        SeatNumber = dto.SeatNumber,
        //        BookingTime = dto.BookingTime
        //    };
        //    var trip = await _context.Trips.SingleOrDefaultAsync(s => s.TripId == dto.TripId);
        //    if (trip == null)
        //    {
        //        return NotFound("trip not found.");
        //    }
        //    trip.SeatsBooked += trip.SeatsBooked + 1;
        //    var seat = await _context.Seats.SingleOrDefaultAsync(s=>s.TripId==dto.TripId&&s.SeatNumber==dto.SeatNumber);
        //    if (seat == null)
        //    {
        //        return NotFound("Seat not found.");
        //    }

        //    seat.IsAvailable = false;
        //    seat.GenderPreference = dto.GenderPreference;
        //    _context.Bookings.Add(booking);
        //    await _context.SaveChangesAsync();
        //    return Ok("Booking added successfully.");
        //}

        [HttpGet("get/{id}")]
        public async Task<IActionResult> GetBooking(int id)
        {
            var booking = await _context.Bookings
                .Include(b => b.Passenger)
                .Include(b => b.Trip)
                .FirstOrDefaultAsync(b => b.BookingId == id);

            if (booking == null)
            {
                return NotFound("Booking not found.");
            }

            return Ok(booking);
        }

        [HttpPut("update/{id}")]
        public async Task<IActionResult> UpdateBooking(int id, [FromBody] BookingUpdateDTO dto)
        {
            var booking = await _context.Bookings.FindAsync(id);
            if (booking == null)
            {
                return NotFound("Booking not found.");
            }

            booking.SeatNumber = dto.SeatNumber;
            booking.BookingTime = dto.BookingTime;

            await _context.SaveChangesAsync();
            return Ok("Booking updated successfully.");
        }
        [HttpGet("getByPassenger/{passengerId}")]
        public async Task<IActionResult> GetAllBookingsByPassengerId(int passengerId)
        {
            var bookings = await _context.Bookings
                .Include(b => b.Passenger)
                .Include(b => b.Trip)
                .Where(b => b.PassengerId == passengerId)
                .ToListAsync();

            if (bookings == null || !bookings.Any())
            {
                return NotFound("No bookings found for the specified passenger.");
            }

            return Ok(bookings);
        }

        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> DeleteBooking(int id)
        {
            var booking = await _context.Bookings.FindAsync(id);
            if (booking == null)
            {
                return NotFound("Booking not found.");
            }

            _context.Bookings.Remove(booking);
            await _context.SaveChangesAsync();
            return Ok("Booking deleted successfully.");
        }
    }
}
