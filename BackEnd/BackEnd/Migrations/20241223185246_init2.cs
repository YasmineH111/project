using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace BackEnd.Migrations
{
    /// <inheritdoc />
    public partial class init2 : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bookings_Passangers_PassangerId",
                table: "Bookings");

            migrationBuilder.DropForeignKey(
                name: "FK_Feedbacks_Passangers_PassangerId",
                table: "Feedbacks");

            migrationBuilder.DropTable(
                name: "Passangers");

            migrationBuilder.RenameColumn(
                name: "PassangerId",
                table: "Feedbacks",
                newName: "PassengerId");

            migrationBuilder.RenameIndex(
                name: "IX_Feedbacks_PassangerId",
                table: "Feedbacks",
                newName: "IX_Feedbacks_PassengerId");

            migrationBuilder.CreateTable(
                name: "Passengers",
                columns: table => new
                {
                    PassengerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MobileNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Passengers", x => x.PassengerId);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Bookings_Passengers_PassangerId",
                table: "Bookings",
                column: "PassangerId",
                principalTable: "Passengers",
                principalColumn: "PassengerId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Feedbacks_Passengers_PassengerId",
                table: "Feedbacks",
                column: "PassengerId",
                principalTable: "Passengers",
                principalColumn: "PassengerId",
                onDelete: ReferentialAction.Cascade);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropForeignKey(
                name: "FK_Bookings_Passengers_PassangerId",
                table: "Bookings");

            migrationBuilder.DropForeignKey(
                name: "FK_Feedbacks_Passengers_PassengerId",
                table: "Feedbacks");

            migrationBuilder.DropTable(
                name: "Passengers");

            migrationBuilder.RenameColumn(
                name: "PassengerId",
                table: "Feedbacks",
                newName: "PassangerId");

            migrationBuilder.RenameIndex(
                name: "IX_Feedbacks_PassengerId",
                table: "Feedbacks",
                newName: "IX_Feedbacks_PassangerId");

            migrationBuilder.CreateTable(
                name: "Passangers",
                columns: table => new
                {
                    PassangerId = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Email = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    MobileNumber = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(max)", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Passangers", x => x.PassangerId);
                });

            migrationBuilder.AddForeignKey(
                name: "FK_Bookings_Passangers_PassangerId",
                table: "Bookings",
                column: "PassangerId",
                principalTable: "Passangers",
                principalColumn: "PassangerId",
                onDelete: ReferentialAction.Cascade);

            migrationBuilder.AddForeignKey(
                name: "FK_Feedbacks_Passangers_PassangerId",
                table: "Feedbacks",
                column: "PassangerId",
                principalTable: "Passangers",
                principalColumn: "PassangerId",
                onDelete: ReferentialAction.Cascade);
        }
    }
}
