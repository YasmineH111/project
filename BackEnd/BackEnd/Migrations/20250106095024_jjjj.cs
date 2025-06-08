using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class jjjj : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropColumn(
                name: "Driver",
                table: "Trips");

            migrationBuilder.CreateIndex(
                name: "IX_Trips_DriverId",
                table: "Trips",
                column: "DriverId");

            migrationBuilder.AddForeignKey(
                name: "FK_Trips_Drivers_DriverId",
                table: "Trips",
                column: "DriverId",
                principalTable: "Drivers",
                principalColumn: "DriverId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Trips_Drivers_DriverId",
                table: "Trips");

            migrationBuilder.DropIndex(
                name: "IX_Trips_DriverId",
                table: "Trips");

            migrationBuilder.AddColumn<string>(
                name: "Driver",
                table: "Trips",
                type: "nvarchar(max)",
                nullable: false,
                defaultValue: "");
        }
    }
}
