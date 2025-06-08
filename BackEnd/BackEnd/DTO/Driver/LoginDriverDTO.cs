using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Driver
{

    public class LoginDriverDTO
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Password { get; set; }
    }
}
