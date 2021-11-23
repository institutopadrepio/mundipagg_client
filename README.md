# MundipaggClient

Welcome to your new gem! In this directory, you'll find the files you need to be able to package up your Ruby library into a gem. Put your Ruby code in the file `lib/mundipagg_client`. To experiment with that code, run `bin/console` for an interactive prompt.

TODO: Delete this and the text above, and describe your gem

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'mundipagg_client'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install mundipagg_client

## Operations

Attributes and methods can be accessed like this:

```ruby
# Valid?
operation.valid?

# Result
operation.result
```

### Customers

Create, retrieve or update customers.

#### Create

```ruby
operation = MundipaggClient::Operations::Customers::Create.run(
    params: {
        name: "Anchieta Junior",
        email: "anchieta@junior.com",
        document: "036.899.945-95"
    }
)
```

#### Retrieve

```ruby
operation = MundipaggClient::Operations::Customers::Retrieve.run(
    customer_id: "cus_jahsdjhs"
)
```

#### Update

```ruby
operation = MundipaggClient::Operations::Customers::Update.run(
    customer_id: "cus_jahsdjhs",
    params: {
        name: "Anchieta Junior",
        email: "anchieta@junior.com",
        document: "036.899.945-95"
    }
)
```

### Credit Cards

Create, retrieve, update or delete credit cards.

```
Quick note: If you don't pass the payment_type parameter, automatically the client will set it to credit card.
```

#### Create

```ruby
operation = MundipaggClient::Operations::CreditCards::Create.run(
    params: {
        number: "4000 0000 0000 0010",
        exp_month: "10",
        exp_year: "30",
        cvv: "123",
        holder_name: "Anchieta S Junior",
        holder_document: "355.587.570-19"
    }
)
```

#### Retrieve

```ruby
operation = MundipaggClient::Operations::CreditCards::Retrieve.run(
    customer_id: "card_blRaGElCr5uQzD4N"
)
```

#### Update

```ruby
operation = MundipaggClient::Operations::CreditCards::Update.run(
    customer_id: "card_blRaGElCr5uQzD4N",
    params: {
      exp_month: "10",
      exp_year: "30",
      holder_name: "Anchieta S Junior",
      holder_document: "355.587.570-19"
    }
)
```

#### Delete

```ruby
operation = MundipaggClient::Operations::CreditCards::Delete.run(
    customer_id: "card_blRaGElCr5uQzD4N"
)
```

### Charges

Create or delete (refund) charges.

#### Create a charge with a new credit card

```ruby
operation = MundipaggClient::Operations::Charges::Create.run(
    params: {
        amount: 10000,
        customer_id: "cus_rXZgoqjFwtj5GODx",
        statement_descriptor: "Padre Paulo Ricardo",
        card_number: "4000000000000010",
        card_exp_month: "10",
        card_exp_year: "30",
        card_cvv: "123",
        card_holder_name: "Anchieta S Junior",
        card_holder_document: "355.587.570-19"
    }
)
```

#### Create a charge with an existing credit card

```ruby
operation = MundipaggClient::Operations::Charges::Create.run(
    params: {
        amount: 1000,
        customer_id: "card_ZeL9P5mUp1CBPWB1",
        statement_descriptor: "Padre Paulo Ricardo",
        installments: 1,
        card_id: "card_ZeL9P5mUp1CBPWB1"
    }
)
```

#### Delete

```ruby
operation = MundipaggClient::Operations::Charges::Delete.run(
    charge_id: "ch_blRaGElCr5uQzD4N"
)
```

### Pix

Create transactions using Pix

#### Create

```ruby
operation = MundipaggClient::Operations::Charges::Create.run(
    params: {
        amount: 120_00,
        customer_id: "cus_oJAX6a4sZs7v2O75",
        payment_type: "pix",
        aditional_information: %w[Label Context]
    }
)
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mundipagg_client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
