using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ProductAPI.Model.DTOs;
using ProductAPI.Model.Entities;

namespace ProductAPI.Service.Interface
{
    public interface IProductService
    {
        Task<IEnumerable<Product>> GetAll();
        Task<Product> Add(ProductDTO productDTO);
        Task Delete(Guid id);
    }
}
