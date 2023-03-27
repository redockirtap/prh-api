# PRH Data fetch API
This API is used to fetch open data about companies registered in Helsinki from avoindata.prh.fi.

## Environment and Gems
1. Environment:
  * Ruby 3.1.2p20
  * Rails 7.0.4.3
  * PostgreSQL 14.7

2. Gems:
  * REST-client
  * dotenv
  * Active Model Serializers
---------
## Run and Deploy
To run the app clone the repo locally and do next steps.

1. Create and migrate the database, run the server afterwards:
```
rails db:create db:migrate
rails s
```
---------
## Using API
To get the data any REST client can be used (e.g. cURL, Postman Desktop). For instance, below are examples of using Postman Desktop.

1. Get brief information about postal codes and companies, registered at given postal codes:

  * GET request to `http://localhost:3000/` and response example:
```
[
    {
        "id": 1,
        "postal_code": "02100",
        "companies": [
            [
                "Knowway oy",
                "3353271-6"
            ],
            [
                "Otsolahden ravintolat oy",
                "3337046-2"
            ],
            [
                "Floarko Oy",
                "3333348-5"
            ],
            [
                "WHERE tech Oy",
                "3331386-3"
            ],
            [
                "AAVA Climate Oy",
                "3326607-5"
            ]
        ]
    },
    ....
]
```
---------

2. Get information about all the companies for a particular postal code:
* GET request to `http://localhost:3000/postal_codes/:postal_code/companies` and response example

```
[
    {
        "id": 1,
        "business_id": "3353271-6",
        "name": "Knowway oy",
        "registration_date": "2023-03-21T00:00:00.000Z",
        "company_form": "OY",
        "details_uri": "http://avoindata.prh.fi/opendata/bis/v1/3353271-6",
        "postal_code_id": 1,
        "created_at": "2023-03-27T19:55:06.551Z",
        "updated_at": "2023-03-27T19:55:06.551Z"
    },
    ...
]
```