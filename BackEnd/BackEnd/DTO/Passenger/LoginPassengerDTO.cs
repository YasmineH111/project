using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Passenger
{
    public class LoginPassengerDTO
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
