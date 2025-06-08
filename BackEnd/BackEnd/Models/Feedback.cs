using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BackEnd.Models
{
    public class Feedback
    {
        [Key]
        public int FeedbackId { get; set; }

        [ForeignKey("Passenger")]
        public int PassengerId { get; set; }
        public Passenger Passenger { get; set; }

        [ForeignKey("Trip")]
        public int TripId { get; set; }
        public Trip Trip { get; set; }

        [Required]
        public int Rating { get; set; }

        public string Comment { get; set; }
    }
}
