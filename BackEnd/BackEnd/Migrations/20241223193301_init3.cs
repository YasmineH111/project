using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class init3 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bookings_Passengers_PassangerId",
                table: "Bookings");

            migrationBuilder.RenameColumn(
                name: "PassangerId",
                table: "Bookings",
                newName: "PassengerId");

            migrationBuilder.RenameIndex(
                name: "IX_Bookings_PassangerId",
                table: "Bookings",
                newName: "IX_Bookings_PassengerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Bookings_Passengers_PassengerId",
                table: "Bookings",
                column: "PassengerId",
                principalTable: "Passengers",
                principalColumn: "PassengerId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bookings_Passengers_PassengerId",
                table: "Bookings");

            migrationBuilder.RenameColumn(
                name: "PassengerId",
                table: "Bookings",
                newName: "PassangerId");

            migrationBuilder.RenameIndex(
                name: "IX_Bookings_PassengerId",
                table: "Bookings",
                newName: "IX_Bookings_PassangerId");

            migrationBuilder.AddForeignKey(
                name: "FK_Bookings_Passengers_PassangerId",
                table: "Bookings",
                column: "PassangerId",
                principalTable: "Passengers",
                principalColumn: "PassengerId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
