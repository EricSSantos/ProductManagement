using Microsoft.AspNetCore.Mvc;
using ProductAPI.Model.DTOs;
using ProductAPI.Model.Entities;
using ProductAPI.Service.Interface;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace ProductAPI.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class ProductController : ControllerBase
    {
        private readonly IProductService _productService;

        public ProductController(IProductService productService)
        {
            _productService = productService;
        }

        [HttpGet("GetAll")]
        public async Task<IActionResult> GetAll()
        {
            try
            {
                var products = await _productService.GetAll();

                if (products == null || !products.Any())
                {
                    return NotFound(new { message = "Nenhum produto encontrado." });
                }

                return Ok(products);
            }
            catch (Exception ex)
            {
                return HandleException(ex, "Ocorreu um erro ao tentar obter todos os produtos.");
            }
        }

        [HttpPost("Add")]
        public async Task<IActionResult> Add([FromBody] ProductDTO productDTO)
        {
            if (productDTO == null)
            {
                return BadRequest(new { message = "Dados do produto não podem ser nulos." });
            }

            try
            {
                var createdProduct = await _productService.Add(productDTO);
                return CreatedAtAction(nameof(GetAll), new { id = createdProduct.Id }, createdProduct);
            }
            catch (ArgumentException ex)
            {
                return BadRequest(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return HandleException(ex, "Ocorreu um erro ao tentar adicionar o produto.");
            }
        }

        [HttpDelete("Delete/{id}")]
        public async Task<IActionResult> Delete(Guid id)
        {
            try
            {
                await _productService.Delete(id);
                return Ok(new { message = "Produto deletado com sucesso!" });
            }
            catch (KeyNotFoundException ex)
            {
                return NotFound(new { message = ex.Message });
            }
            catch (Exception ex)
            {
                return HandleException(ex, "Ocorreu um erro ao tentar deletar o produto.");
            }
        }

        private IActionResult HandleException(Exception ex, string message)
        {
            return StatusCode(500, new { message, details = ex.Message });
        }
    }
}
