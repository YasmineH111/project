using BackEnd.DTO.Payment;
using BackEnd.Models;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;

namespace BackEnd.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class PaymentController : ControllerBase
    {
        private readonly OntheRoadDBContext _context;

        public PaymentController(OntheRoadDBContext context)
        {
            _context = context;
        }

        [HttpPost("add")]
        public async Task<IActionResult> AddPayment([FromBody] PaymentCreateDTO dto)
        {
            var payment = new Payment
            {
                BookingId = dto.BookingId,
                PaymentType = dto.PaymentType,
                Amount = dto.Amount,
                TransactionId = dto.TransactionId,
                MobileNumber = dto.MobileNumber
            };

            _context.Payments.Add(payment);
            await _context.SaveChangesAsync();
            return Ok("Payment added successfully.");
        }

        [HttpGet("get/{id}")]
        public async Task<IActionResult> GetPayment(int id)
        {
            var payment = await _context.Payments
                .Include(p => p.Booking)
                .FirstOrDefaultAsync(p => p.PaymentId == id);

            if (payment == null)
            {
                return NotFound("Payment not found.");
            }

            return Ok(payment);
        }
    
}
}
