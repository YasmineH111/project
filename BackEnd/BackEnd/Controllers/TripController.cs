using BackEnd.DTO.Trip;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TripController : ControllerBase
    {
        private readonly OntheRoadDBContext _context;

        public TripController(OntheRoadDBContext context)
        {
            _context = context;
        }

        [HttpPost("CreateTrip")]
        public async Task<IActionResult> CreateTrip([FromBody] TripCreateDTO dto)
        {
            // Create a new Trip object
            var trip = new Trip
            {
                DriverId = dto.DriverId,
                OLatitude = dto.OLatitude,
                OLongitude = dto.OLongitude,
                DLatitude = dto.DLatitude,
                DLongitude = dto.DLongitude,
                Date = dto.Date,
                Time = dto.Time,
                Price = dto.Price,
                SeatsTotal = 15,
                SeatsBooked = 0 // Initial booking is always 0 when creating a new trip
            };

            // Add the Trip to the database
            _context.Trips.Add(trip);
            await _context.SaveChangesAsync(); // Save the trip to generate the TripId

            // Create seats for the trip
            var seats = new List<Seat>();
            for (int i = 1; i <= 15; i++)
            {
                var seat = new Seat
                {
                    TripId = trip.TripId, // Use the generated TripId
                    SeatNumber = i,
                    IsAvailable = true,
                    GenderPreference = "None" // Assuming no preference as default
                };
                seats.Add(seat);
            }

            // Add the seats to the database
            _context.Seats.AddRange(seats);
            await _context.SaveChangesAsync(); // Save all seats at once

            // Return the trip object along with its seats


      return      Ok(new { status = "Trip Added Successfully" });
        }
        [HttpGet("GetAllTrips")]
        public async Task<IActionResult> GetAllTrips()
        {
            var trips = await _context.Trips
                .Include(t => t.Seats)
                .Select(t => new
                {
                    t.TripId,
                    t.DriverId,
                    t.Driver,
                    t.OLatitude,
                    t.OLongitude,
                    t.DLatitude,
                    t.DLongitude,
                    t.Date,
                    t.Time,
                    t.Price,
                    t.SeatsTotal,
                    t.SeatsBooked,
                    Seats = t.Seats.Select(s => new
                    {
                        s.SeatId,
                        s.TripId,
                        s.SeatNumber,
                        s.IsAvailable,
                        s.GenderPreference
                    }).ToList()
                })
                .ToListAsync();

            if (trips == null || !trips.Any())
            {
                return NotFound("No trips found.");
            }

            return Ok(trips);
        }

        [HttpGet("GetTripsByDriverId/{driverId}")]
        public async Task<IActionResult> GetTripsByDriverId(int driverId)
        {
            var trips = await _context.Trips
                .Include(t => t.Seats)
                .Select(t => new
                {
                    t.TripId,
                    t.DriverId,
                    t.Driver,
                    t.OLatitude,
                    t.OLongitude,
                    t.DLatitude,
                    t.DLongitude,
                    t.Date,
                    t.Time,
                    t.Price,
                    t.SeatsTotal,
                    t.SeatsBooked,
                    Seats = t.Seats.Select(s => new
                    {
                        s.SeatId,
                        s.TripId,
                        s.SeatNumber,
                        s.IsAvailable,
                        s.GenderPreference
                    }).ToList()
                })
                .Where(x=>x.DriverId==driverId).ToListAsync();

            if (trips == null || !trips.Any())
            {
                return NotFound("No trips found.");
            }

            return Ok(trips);
        }
        [HttpGet("GetAllTripsInLocation/{olong}/{olat}/{dlong}/{dlat}")]
        public async Task<IActionResult> GetAllTripsInLocation(double olong, double olat, double dlong, double dlat)
        {
            // Define a fixed range (in degrees). For example, 0.01 degrees ~ 1.11 km.
            const double range = 0.2;

            var trips = await _context.Trips
                .Include(t => t.Seats)
               .Where(t =>
        (Math.Abs(Math.Round(t.OLongitude, 6) - Math.Round(olong, 6)) <= range &&
         Math.Abs(Math.Round(t.OLatitude, 6) - Math.Round(olat, 6)) <= range &&
         Math.Abs(Math.Round(t.DLongitude, 6) - Math.Round(dlong, 6)) <= range &&
         Math.Abs(Math.Round(t.DLatitude, 6) - Math.Round(dlat, 6)) <= range))
    .Select(t => new
    {
                    t.TripId,
                    t.DriverId,
                    t.Driver,
                    t.OLatitude,
                    t.OLongitude,
                    t.DLatitude,
                    t.DLongitude,
                    t.Date,
                    t.Time,
                    t.Price,
                    t.SeatsTotal,
                    t.SeatsBooked,
                    Seats = t.Seats.Select(s => new
                    {
                        s.SeatId,
                        s.TripId,
                        s.SeatNumber,
                        s.IsAvailable,
                        s.GenderPreference
                    }).ToList()
                })
                .ToListAsync();

            if (trips == null || !trips.Any())
            {
                return NotFound("No trips found in the specified location.");
            }

            return Ok(trips);
        }

        [HttpGet("get/{id}")]
        public async Task<IActionResult> GetTrip(int id)
        {
            var trip = await _context.Trips
                .Include(t => t.Driver)
                .FirstOrDefaultAsync(t => t.TripId == id);

            if (trip == null)
            {
                return NotFound("Trip not found.");
            }

            return Ok(trip);
        }

        [HttpPut("update/{id}")]
        public async Task<IActionResult> UpdateTrip(int id, [FromBody] TripUpdateDTO dto)
        {
            var trip = await _context.Trips.FindAsync(id);
            if (trip == null)
            {
                return NotFound("Trip not found.");
            }

            trip.OLatitude = dto.OLatitude;
            trip.OLongitude = dto.OLongitude;

            trip.DLatitude = dto.DLatitude;
            trip.DLongitude = dto.DLongitude;
            trip.Date = dto.Date;
            trip.Time = dto.Time;
        
            trip.Price = dto.Price;
            trip.SeatsTotal = dto.SeatsTotal;
            trip.SeatsBooked = dto.SeatsBooked;

            await _context.SaveChangesAsync();
            return Ok("Trip updated successfully.");
        }

        [HttpDelete("delete/{id}")]
        public async Task<IActionResult> DeleteTrip(int id)
        {
            var trip = await _context.Trips.FindAsync(id);
            if (trip == null)
            {
                return NotFound("Trip not found.");
            }

            _context.Trips.Remove(trip);
            await _context.SaveChangesAsync();
            return Ok("Trip deleted successfully.");
        }
    }
}

