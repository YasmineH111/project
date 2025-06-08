using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Payment
{
    public class PaymentCreateDTO
    {
        [Required]
        public int BookingId { get; set; }

        [Required]
        public string PaymentType { get; set; }

        [Required]
        public decimal Amount { get; set; }

        public string TransactionId { get; set; } // Optional for credit card

        public string MobileNumber { get; set; } // Optional for Vodafone Cash
    }
}
