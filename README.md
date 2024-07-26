# Product Management

## API Backend

ProductAPI é uma aplicação desenvolvida em .NET 8 utilizando EFCore como ORM e PostgreSQL como banco de dados. Esta API oferece funcionalidades para o gerenciamento de produtos, incluindo cadastro, exclusão e listagem.

<details>
<summary><strong>Estrutura do Projeto</strong></summary>

### ProductAPI

Este projeto contém as controllers e as configurações da API.

#### Controllers

- **ProductController**: Responsável por gerenciar as requisições HTTP relacionadas aos produtos. As principais ações incluem:
  - **GetAll**: Retorna todos os produtos cadastrados.
  - **Add**: Adiciona um novo produto.
  - **Delete**: Exclui um produto existente.
- As controllers interagem com os serviços para realizar operações de negócio e manipular os dados dos produtos.

#### Configuração da Porta da API

- A porta da API pode ser alterada no arquivo `launchSettings.json`. Atualmente, a API está configurada para rodar na porta 5000.

### ProductAPI.Data

Este projeto contém toda a lógica relacionada ao banco de dados e ao acesso aos dados.

#### Camada de Repository e Interface

- **Repository**: Implementa a lógica de acesso aos dados, encapsulando a interação com o banco de dados. Responsável por operações CRUD (Create, Read, Update, Delete) para as entidades da aplicação.
- **Interface**: Define os contratos para os repositórios, permitindo a implementação de diferentes estratégias de acesso a dados e facilitando a substituição por mocks ou stubs durante os testes.

#### Contexto

- **Context**: Gerencia a conexão com o banco de dados e a interação com as entidades. Configura as tabelas e as relações entre elas. Gerencia o ciclo de vida das entidades e fornece uma interface para consultas e manipulação dos dados.

#### Migrations

- Utilizadas para criar e atualizar o esquema do banco de dados. Permitem versionar as alterações no esquema do banco e aplicar essas alterações de maneira incremental. Responsáveis por carregar dados iniciais no banco de dados, se necessário.

### ProductAPI.Model

Este projeto contém as entidades do banco de dados.

#### Entidade Product

- **Product**: Representa um produto com propriedades como Id, Code, Description, Price, Amount, CreateDate e UpdateDate.

#### DTO

- **ProductDTO**: Data Transfer Object utilizado para transferir dados do produto entre a API e a camada de serviço.

### ProductAPI.Service

Este projeto contém os serviços e interfaces responsáveis pela lógica de negócio da API.

#### Serviço ProductService

- **ProductService**: Implementa a lógica de negócio relacionada aos produtos. As principais funcionalidades incluem:
  - **GetAll**: Retorna todos os produtos.
  - **Add**: Adiciona um novo produto, validando os dados recebidos e gerando um novo código para o produto.
  - **Delete**: Exclui um produto existente, verificando se o produto existe antes de tentar deletá-lo.
</details>

<details>
<summary><strong>Configuração do Banco de Dados</strong></summary>

1. **Instalação do PostgreSQL**:
   - Certifique-se de que o PostgreSQL está instalado e em execução no seu ambiente.

2. **Configuração da Conexão**:
   - O arquivo de configuração (`appsettings.json`) inclui as credenciais e informações necessárias para conectar-se ao banco de dados PostgreSQL.

3. **Aplicar Migrations**:
   - Execute o comando para aplicar as migrations e criar o banco de dados:
     ```
     dotnet tool install --global dotnet-ef
     dotnet ef database update --project ProductAPI.Data --startup-project ProductAPI
     ```
   - Para executar o projeto no Visual Studio, utilize o atalho `CTRL + '` para abrir o terminal integrado e execute os comandos de instalação das ferramentas e atualização do banco de dados conforme descrito na seção anterior.
</details>
