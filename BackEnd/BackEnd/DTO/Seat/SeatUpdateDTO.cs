using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Seat
{
    public class SeatUpdateDTO
    {
        [Required]
        public bool IsAvailable { get; set; }

        public string GenderPreference { get; set; }  // Optional
    }
}
