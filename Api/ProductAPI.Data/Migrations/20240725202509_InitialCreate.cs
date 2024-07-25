using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace ProductAPI.Data.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreate : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "Products",
                columns: table => new
                {
                    product_id = table.Column<Guid>(type: "uuid", nullable: false),
                    code = table.Column<int>(type: "integer", nullable: false),
                    description = table.Column<string>(type: "character varying(100)", maxLength: 100, nullable: false),
                    price = table.Column<double>(type: "double precision", nullable: false),
                    amount = table.Column<int>(type: "integer", nullable: false),
                    creation_date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true),
                    update_date = table.Column<DateTime>(type: "timestamp with time zone", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK_Products", x => x.product_id);
                });

            // Carga de tabela inicial
            migrationBuilder.InsertData(
                table: "Products",
                columns: new[] { "product_id", "code", "description", "price", "amount", "creation_date", "update_date" },
                values: new object[,]
                {
                    { Guid.NewGuid(), 1, "Cha Nestea Pet 1,5 Ml", 12.50, 150, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 2, "Sol Premium  L.N", 25.75, 100, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 3, "Bavaria Premium 350ml", 15.40, 250, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 4, "Chocolate Nestle Classic Ao Leite/Duo", 20.00, 200, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 5, "Biscoito Trakinas Chocolate 77gr", 7.90, 400, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 6, "Cigarro Malrboro Filter Plus", 22.50, 350, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 7, "Biscoito Bono Recheado", 9.99, 180, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 8, "Kinder Bueno/ White 43 Gr", 12.00, 220, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 9, "Halls Light Xs", 6.50, 500, DateTime.UtcNow, null },
                    { Guid.NewGuid(), 10, "Agua Com Gas Sao Lourenço", 5.99, 600, DateTime.UtcNow, null }
                });
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "Products");
        }
    }
}
