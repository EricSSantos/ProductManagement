using System;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;

namespace ProductAPI.Model.Entities
{
    [Table("Products")]
    public class Product
    {
        [Key]
        [Column("product_id")]
        public Guid Id { get; private set; }

        [Column("code")]
        public int Code { get; private set; }

        [Required(ErrorMessage = "Descrição é obrigatória.")]
        [MaxLength(100, ErrorMessage = "Descrição não pode exceder 100 caracteres.")]
        [Column("description")]
        public string Description { get; private set; }

        [Required(ErrorMessage = "Preço é obrigatório.")]
        [Column("price")]
        public double Price { get; private set; }

        [Column("amount")]
        public int Amount { get; private set; }

        [Column("creation_date")]
        public DateTime? CreateDate { get; private set; }

        [Column("update_date")]
        public DateTime? UpdateDate { get; private set; }

        public Product(Guid id, int code, string description, double price, int amount, DateTime? createDate, DateTime? updateDate)
        {
            Id = id;
            Code = code;
            Description = description;
            Price = price;
            Amount = amount;
            CreateDate = createDate;
            UpdateDate = updateDate;
        }

        private Product() { }
    }
}
