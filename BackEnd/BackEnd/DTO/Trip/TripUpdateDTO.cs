using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Trip
{
    public class TripUpdateDTO
    {
        [Required]
        public double OLatitude { get; set; }

        [Required]
        public double OLongitude { get; set; }

        [Required]
        public double DLatitude { get; set; }

        [Required]

        public double DLongitude { get; set; }

        [Required]
        public DateTime Date { get; set; }

        [Required]
        public string Time { get; set; }

        [Required]
        public double Price { get; set; }

        [Required]
        public int SeatsTotal { get; set; }

        [Required]
        public int SeatsBooked { get; set; }
    }
}
