using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Text.Json.Serialization;

namespace BackEnd.Models
{
    public class Trip
    {
        [Key]
        public int TripId { get; set; }

        [ForeignKey("Driver")]
        public int DriverId { get; set; }
        public Driver Driver { get; set; }

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
        
        public virtual ICollection<Seat> Seats { get; set; }
    }
}
