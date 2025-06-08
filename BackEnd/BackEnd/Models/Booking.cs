using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BackEnd.Models
{
    public class Booking
    {
        [Key]
        public int BookingId { get; set; }

        [ForeignKey("Passenger")]
        public int PassengerId { get; set; }
        public Passenger Passenger { get; set; }

        [ForeignKey("Trip")]
        public int TripId { get; set; }
        public Trip Trip { get; set; }

        [Required]
        public int SeatNumber { get; set; }

        [Required]
        public DateTime BookingTime { get; set; }
    }
}
