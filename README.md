# Bodeguita
![rails-badge](https://img.shields.io/badge/Rails-6.1.0-informational?style=flat-square) ![ruby-badge](https://img.shields.io/badge/Ruby-2.5.3-informational?style=flat-square) ![GitHub closed pull requests](https://img.shields.io/github/issues-pr-closed/AngelaGuardia/bodeguita)


This GraphQL on Rails API serves queries and mutations to Bodeguita, an application that allows users to buy and sell images.

At Bodeguita, **photographers** can manage their image sales by:
- Setting image prices through the `updateImage` mutation
- Creating discounts, through the `createDiscount` mutation, that apply when a minimum quantity of one of that photographer's images is purchased
- Checking their total revenue through the `revenue` query

Likewise, image buyers can purchase images by
- Creating orders through the `createOrder` mutation. This mutation checks if an order is fulfillable, applies discounts and creates `orderImages` (receipt-like records that join images to orders and record the final price and quantity of each purchased image).

## Readme Content
- [Local Setup](#local-setup)
- [Test Suite](#test-suite)
- [GraphQL Schema](#graphql-schema)
- [Database Schema](#database-schema)
- [Project Board](#project-board)

## Local Setup
- Versions
  - Rails 6.1.0
  - Ruby 2.5.3
- Fork and clone this repository
- `cd` in your local repo version and run the following commands
  - To install gems:
    -  `bundle` (if this fails, try to `bundle update` and then retry)
  - To setup database:
    - `rails db:create`
    - `rails db:migrate`
    - `rails db:seed`
- Run your own development server:
  - `rails s`
  - You should be able to access the GraphQL interface and see available queries and mutations via the docs on [http://localhost:3000/graphiql](http://localhost:3000/graphiql)

## Test Suite
- Run with `bundle exec rspec`
- All tests should be passing

## GraphQL Schema
- Queries available:
  - Get revenue by photographer: <details>
    ```
      query {
        revenue(userId: #{id})
          }
    ```
    </details>

- Mutations available:
  - Create Order: <details>
    ```
      mutation {
        createOrder(input:{
            userId: #{buyer.id}
            billingAddress: #{buyer.address}
            city: #{buyer.city}
            state: #{buyer.state}
            zip: #{buyer.zip}
            ccNumber: #{buyer.zip}
            ccName: "#{@buyer.first_name} #{@buyer.last_name}"
            status: "Approved"
            cart: #{cart}
            }) {
              id
              userId
              billingAddress
              city
              state
              zip
              ccNumber
              ccName
              status
            }
          }
    ```
    </details>
  - Update User: <details>
    ```
    mutation {
      updateImage(input:{
          id: #{image.id}
          name: #{new_image_name}
          description: #{new_image_desc}
          price: #{new_image_price}
          url: #{new_image_url}
          inventory: #{new_image_inv}
          }) {
            id
            userId
            name
            description
            price
            url
            inventory
          }
        }
    ```
    </details>
  - Create Discount: <details>
    ```
    mutation {
      createDiscount(input:{
          userId: #{id}
          name: #{name}
          minimumQuantity: #{quantity}
          percentage: #{percentage}
          }) {
            id
            userId
            name
            minimumQuantity
            percentage
          }
        }
    ```
    </details>

## Database Schema
<img width="1270" alt="Screen Shot 2021-01-17 at 4 28 14 PM" src="https://user-images.githubusercontent.com/47278429/104860714-53198780-58e1-11eb-8b74-8d68f9308323.png">

- Description of tables:

  - Users: holds all user information. Users have a role - buyer or photographer
  
  - Images: holds all image info including full price and inventory
  
  - Discounts: holds all discount information related to a photographer
  
  - Orders: hold all purchase information
  
  - OrderImages: joins images and orders, holds the final price and quantity purchased for each image

## Project Board
- I used this [GitHub project](https://github.com/AngelaGuardia/bodeguita) to keep my work organized and [well documented](https://github.com/AngelaGuardia/bodeguita/pull/13)
- I used version control through branches and PRs
- Next steps:
  - User authentication and authorization - to only allow photographers to manage the price and inventory for their images
  - Discount CRUD actions - allow photographers to update, delete and get discounts
  - Create Stores so that photographers can separate themselves from their businesses (use different addresses etc.)
  - Improve security by encrypting sensitive information like credit card numbers

## Author
- Angela Guardia |  [Github](https://github.com/AngelaGuardia)  |  [LinkedIn](https://www.linkedin.com/in/angela-guardia/)
