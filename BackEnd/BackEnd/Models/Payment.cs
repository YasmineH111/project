using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace BackEnd.Models
{
    public class Payment
    {
        [Key]
        public int PaymentId { get; set; }

        [ForeignKey("Booking")]
        public int BookingId { get; set; }
        public Booking Booking { get; set; }

        [Required]
        public string PaymentType { get; set; } // Consider using Enum here

        [Required]
        public decimal Amount { get; set; }

        public string TransactionId { get; set; } // Optional for credit card

        public string MobileNumber { get; set; } // Optional for Vodafone Cash
    }
}
