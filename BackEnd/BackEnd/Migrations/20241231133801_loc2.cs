using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class loc2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "longitude",
                table: "Trips",
                newName: "OLongitude");

            migrationBuilder.RenameColumn(
                name: "latitude",
                table: "Trips",
                newName: "OLatitude");

            migrationBuilder.RenameColumn(
                name: "Origin",
                table: "Trips",
                newName: "DLongitude");

            migrationBuilder.RenameColumn(
                name: "Destination",
                table: "Trips",
                newName: "DLatitude");
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.RenameColumn(
                name: "OLongitude",
                table: "Trips",
                newName: "longitude");

            migrationBuilder.RenameColumn(
                name: "OLatitude",
                table: "Trips",
                newName: "latitude");

            migrationBuilder.RenameColumn(
                name: "DLongitude",
                table: "Trips",
                newName: "Origin");

            migrationBuilder.RenameColumn(
                name: "DLatitude",
                table: "Trips",
                newName: "Destination");
        }
    }
}
