using BackEnd.Models;
using Microsoft.AspNetCore.Identity.EntityFrameworkCore;
using Microsoft.EntityFrameworkCore;
using System.Collections.Generic;
using System.Reflection.Emit;

namespace BackEnd.Models
{
    public class OntheRoadDBContext : DbContext
    {
        public OntheRoadDBContext(DbContextOptions<OntheRoadDBContext> options) : base(options)
        {
        }

        // DbSet properties for each entity
        public DbSet<Passenger> Passengers { get; set; }
        public DbSet<Driver> Drivers { get; set; }
        public DbSet<Booking> Bookings { get; set; }
        public DbSet<Payment> Payments { get; set; }
        public DbSet<Seat> Seats { get; set; }
        public DbSet<Trip> Trips { get; set; }
        public DbSet<Feedback> Feedbacks { get; set; }




    }
}
