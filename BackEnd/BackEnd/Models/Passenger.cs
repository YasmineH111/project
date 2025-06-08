using Microsoft.AspNetCore.Identity;
using Microsoft.AspNetCore.Mvc.ViewEngines;
using System.ComponentModel.DataAnnotations;

namespace BackEnd.Models
{
    // Model for User
    public class Passenger
    {

        [Key]
        public int PassengerId { get; set; }

        [Required, EmailAddress]
        public string Email { get; set; }

        [Required]
        public string Name { get; set; }

        [Required, Phone]
        public string MobileNumber { get; set; }

        [Required]
        public string PasswordHash { get; set; }


    }
}
