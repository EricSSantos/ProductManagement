using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ProductAPI.Data.Interface;
using ProductAPI.Model.DTOs;
using ProductAPI.Model.Entities;
using ProductAPI.Service.Interface;

namespace ProductAPI.Service
{
    public class ProductService : IProductService
    {
        private readonly IProductRepository _productRepository;

        public ProductService(IProductRepository productRepository)
        {
            _productRepository = productRepository;
        }

        public async Task<IEnumerable<Product>> GetAll()
        {
            return await _productRepository.GetAll();
        }

        public async Task<Product> Add(ProductDTO productDTO)
        {
            if (productDTO == null)
            {
                throw new ArgumentNullException(nameof(productDTO), "Os dados do produto não podem ser nulos.");
            }

            if (string.IsNullOrWhiteSpace(productDTO.Description))
            {
                throw new ArgumentException("Descrição é obrigatória.", nameof(productDTO.Description));
            }

            if (productDTO.Price <= 0)
            {
                throw new ArgumentException("Preço deve ser maior que zero.", nameof(productDTO.Price));
            }

            int newCode = await GenerateNextProductCode();

            var product = new Product(
                id: Guid.NewGuid(),
                code: newCode,
                description: productDTO.Description,
                price: productDTO.Price,
                amount: productDTO.Amount,
                createDate: DateTime.UtcNow,
                updateDate: null
            );

            return await _productRepository.Add(product);
        }

        public async Task Delete(Guid id)
        {
            var product = await _productRepository.GetById(id);
            if (product == null)
            {
                throw new KeyNotFoundException($"Produto não encontrado.");
            }

            await _productRepository.Delete(id);
        }

        private async Task<int> GenerateNextProductCode()
        {
            var maxCode = await _productRepository.GetMaxProductCode();
            return maxCode + 1;
        }
    }
}
