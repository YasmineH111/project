using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Seat
{
    public class SeatCreateDTO
    {
        [Required]
        public int TripId { get; set; }

        [Required]
        public int SeatNumber { get; set; }

        [Required]
        public bool IsAvailable { get; set; }

        public string GenderPreference { get; set; }  // Optional
    }
}
