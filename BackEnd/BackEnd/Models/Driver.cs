using System.ComponentModel.DataAnnotations;

namespace BackEnd.Models
{
    public class Driver
    {
        [Key]
        public int DriverId { get; set; }

        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required, Phone]
        public string MobileNumber { get; set; }

        [Required]
        public string PasswordHash { get; set; }

        [Required]
        public string LicenseNumber { get; set; }
    }


}
