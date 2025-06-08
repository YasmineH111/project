using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BackEnd.Models
{
    public class Seat
    {
        [Key]
        public int SeatId { get; set; }

        [ForeignKey("Trip")]
        public int TripId { get; set; }
        public Trip Trip { get; set; }

        [Required]
        public int SeatNumber { get; set; }

        [Required]
        public bool IsAvailable { get; set; }

        public string GenderPreference { get; set; } // Consider using Enum here
    }

}
