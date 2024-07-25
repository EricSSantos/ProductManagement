using System;
using System.Collections.Generic;
using System.Threading.Tasks;
using ProductAPI.Model.Entities;

namespace ProductAPI.Data.Interface
{
    public interface IProductRepository
    {
        Task<IEnumerable<Product>> GetAll();
        Task<Product> GetById(Guid id);
        Task<Product> Add(Product product);
        Task<Product> Update(Product product);
        Task Delete(Guid id);
        Task<int> GetMaxProductCode();
    }
}
