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
    "id":1,
    "name":"Lorem1",
    "address":"R. Lorem Ipsum, XXX, Lorem, Ipsum",
    "created_at":"2020-10-07T15:38:01.558Z",
    "updated_at":"2020-10-07T15:38:01.558Z",
    "cnpj":"73.590.707/9101-24",
    "token":"9F7IYV"
  },
  {
    "id":2,
    "name":"Lorem2",
    "address":"R. Lorem Ipsum, XXX, Lorem, Ipsum",
    "created_at":"2020-10-07T15:38:01.563Z",
    "updated_at":"2020-10-07T15:38:01.563Z",
    "cnpj":"86.837.657/2840-59",
    "token":"CK4XEB"
  }
]
```
