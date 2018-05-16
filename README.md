# Refocus

A ruby client library and CLI for [Refocus](https://github.com/salesforce/refocus).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'refocus'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install refocus

## Usage

### CLI
```
Usage:
    refocus [OPTIONS] SUBCOMMAND [ARG] ...

Parameters:
    SUBCOMMAND                    subcommand
    [ARG] ...                     subcommand arguments

Subcommands:
    samples:get                   Print a sample

Options:
    -h, --help                    print help
```

### Library

Refocus will pick up `REFOCUS_URL` and `REFOCUS_API_TOKEN` environment vars if these are set.
You can create a client like this in a `pry` or `irb` session, or in your ruby program:

```ruby
require "refocus"

# Using env vars. This will fail if REFOCUS_URLand REFOCUS_API_TOKEN are unset:
refocus = Refocus.client

# Doing it yourself:
refocus = Refocus.client(url: "https://my.refocus.instance.com", token: "some-token-i-generated")
```
#### Subjects

You can manage subjects like this:

```ruby
# Create a root subject (returns a hash):
refocus.subjects.create(name: "my-subject")

# Create a child subject (returns a hash):
refocus.subjects.create(parent: "my-subject", name: "child-subject")

# List all subjects (includes root subjects and children, in an array):
refocus.subjects.all

# Delete a child subject (returns a hash):
refocus.subjects.delete(name: "my-subject.child-subject")
```

#### Aspects

You can manage aspects like this:

```ruby
# Create an aspect:
refocus.aspects.create(name: "my-aspect", "timeout" => "5m")

# Describe an aspect:
refocus.aspects.get(name: "my-aspect")

# Delete an aspect by name:
refocus.aspects.delete(name: "my-aspect")
```

#### Samples

You can manage samples like this:

```ruby
# Instantiate the samples client
samples_client = refocus.samples   

# Create or update a sample:
samples_client.upsert(name: "my-subject.child-subject", aspect: "my-aspect", value: '100')

# Create or update a sample with a custom request body
request_body =  {name: "my-subject.child-subject", aspect: "my-aspect", value: '100'}
samples_client.upsert_custom_body(request_body)

# Describe a sample:
samples_client.get(subject: "my-subject", aspect: "my-aspect")

# List samples:
samples_client.list(limit: 50)

# Create or update samples in bulk:
samples_collector = samples_client.collector
samples_collector.add(name: "my-subject.child-subject", aspect: "my-aspect-1", value: '100')
samples_collector.add(name: "my-subject.child-subject", aspect: "my-aspect-2", messageCode: '100%')
samples_collector.upsert_bulk
```

#### Lenses

Lenses are not supported at this time.

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/heroku/refocus-ruby
