# Refocus

A ruby client library for [Refocus](https://github.com/salesforce/refocus).

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

Refocus will pick up `REFOCUS_HOST` and `REFOCUS_API_TOKEN` environment vars if these are set.
You can create a client like this:

```ruby
# Using env vars. This will fail if REFOCUS_HOST and REFOCUS_API_TOKEN are unset:
refocs = Refocus.client

# Doing it yourself:
refocus = Refocus.client(url: "https://my.refocus.instance.com", token: "some-token-i-generated"
``
### Subjects

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

### Aspects

You can manage aspects like this:

```ruby
# Create an aspect:
refocus.aspects.create(name: "my-aspect", "timeout" => "5m")

# Describe an aspect:
refocus.aspects.get(name: "my-aspect")

# Delete an aspect by name:
refocus.aspects.delete(name: "my-aspect")
```

### Lenses

IN PROGRESS


## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/sheax0r/refocus.
