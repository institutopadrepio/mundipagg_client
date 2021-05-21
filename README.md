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

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and the created tag, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/[USERNAME]/mundipagg_client.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
