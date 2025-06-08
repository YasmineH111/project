using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Passenger
{
    public class RegisterPassengerDTO
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required, Phone]
        public string MobileNumber { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
