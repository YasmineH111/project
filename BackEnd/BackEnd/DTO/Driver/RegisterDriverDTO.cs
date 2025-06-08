using System.ComponentModel.DataAnnotations;

namespace BackEnd.DTO.Driver
{
    public class RegisterDriverDTO
    {
        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required, Phone]
        public string MobileNumber { get; set; }

        [Required]
        public string Password { get; set; }

        [Required]
        public string LicenseNumber { get; set; }
    }
}
