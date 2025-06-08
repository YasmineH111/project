using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Booking
{
    public class BookingCreateDTO
    {
        [Required]
        public int PassengerId { get; set; }  // Note: Typo corrected from "PassangerId" to "PassengerId"

        [Required]
        public int TripId { get; set; }

        public string GenderPreference { get; set; }

        [Required]
        public int SeatNumber { get; set; }

        [Required]
        public DateTime BookingTime { get; set; }
    }

    public class BookingUpdateDTO
    {
        [Required]
        public int SeatNumber { get; set; }

        [Required]
        public DateTime BookingTime { get; set; }
    }
}
