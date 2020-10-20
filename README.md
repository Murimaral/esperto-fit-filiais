# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## API

### Consulta de filiais

#### GET /api/v1/subsidiaries

**HTTP status:** 200

```json
[
  {
    "id": 3,
    "name": "Lorem1",
    "address": "R. Lorem Ipsum, XXX, Lorem, Ipsum",
    "created_at": "2020-10-13T20:28:59.920Z",
    "updated_at": "2020-10-13T20:28:59.920Z",
    "cnpj": "58.520.759/8766-09",
    "token": "X2VBDD"
  },
  {
    "id": 4,
    "name": "Lorem10",
    "address": "R. Lorem Ipsum, XXX, Lorem, Ipsum",
    "created_at": "2020-10-14T19:47:08.649Z",
    "updated_at": "2020-10-14T19:47:08.649Z",
    "cnpj": "02.124.357/9633-63",
    "token": "PUXCOX"
  }
]
```

#### GET /api/v1/subsidiaries/:id

**HTTP status:** 200

```json
{
  "id": 3,
  "name": "Lorem1",
  "address": "R. Lorem Ipsum, XXX, Lorem, Ipsum",
  "cnpj": "58.520.759/8766-09",
  "token": "X2VBDD",
  "subsidiary_plans": [
    {
      "name": "Plano1",
      "price": "9.99",
      "permanency": "12 months"
    }
  ]
}
```


**HTTP status:** 404 - Não encontrado

```json
Filial não encontrada
```

### Criação de matrícula

#### POST /api/v1/enrollments

#### Parâmetros (todos obrigatórios):

```json
{
  "enrollment": { 
    "customer_name": "Lorem",
    "customer_cpf": "924.737.808-70",
    "subsidiary_plan_id": 1,
    "email": "user@mail.com",
    "price": 99.90 
  }
}
```

**HTTP status:** 201

```json
{
  "id": 1,
  "token": "4G4INJ",
  "customer_name": "Lorem",
  "customer_cpf": "924.737.808-70",
  "email": "user@mail.com",
  "price": "99.9",
  "status": "active",
  "valid_thru": "2021-10-10",
  "subsidiary_plan_id": 1,
  "created_at": "2020-10-10T19:33:24.907Z",
  "updated_at": "2020-10-10T19:33:24.907Z"
}
```

**HTTP status:** 412 - Parâmetro inválido

```json
Parâmetros inválidos
```

**HTTP status:** 422 - Parâmetros com valores inválidos

```json
[
  "Plano é obrigatório(a)",
  "Preço deve ser maior que 0",
  "Nome do cliente não pode ficar em branco",
  "Email não é válido",
  "CPF do cliente não é válido"
]
```