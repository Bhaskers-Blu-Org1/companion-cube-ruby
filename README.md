[![Build Status](https://travis.ibm.com/bdu/companion-cube-ruby.svg?token=CCLjK5gsaLWyxhCwwcrs&branch=master)](https://travis.ibm.com/bdu/companion-cube-ruby)

# Companion Cube

Ruby client for [Companion Cube](https://github.ibm.com/bdu/companion-cube).

## Installation

Add this line to your application's `Gemfile`:

```ruby
gem "companion_cube"
```

And then execute:

```sh
bundle install
```

Or install it yourself as:

```sh
gem install companion_cube
```

## Usage

```ruby
# To start, create a client
cc = CompanionCube::Client.new(url: "https://cc.example.com")

# Retrieve all existing courses
courses = cc.courses

# Create a new course
params = {
  run:          "...",
  archive_file: File.new("...")
}
new_course = cc.create_course(params)

# Retrieve an existing course
course = cc.course(new_course["id"])

# Update a course
params = {
  archive_file: File.new("...")
}
updated_course = cc.update_course(course["id"], params)
```

## Development

To run the tests, run:

```sh
docker-compose run --rm cc rake spec
```

You can also run the following command for an interactive prompt that will
allow you to experiment.

```sh
docker-compose run --rm cc bin/console
```

For added flexibility, you can use Bash.

```sh
docker-compose run --rm cc bash
```

## Build

Add the gem repo to your configuration:

```sh
# replace @ with %40 in your username
gem source -a \
  https://<USERNAME>:<PASSWORD>@na.artifactory.swg-devops.com/artifactory/api/gems/apset-ruby/
  
# keep @ AS IS
curl -u<USERNAME>:<PASSWORD> \
  https://na.artifactory.swg-devops.com/artifactory/api/gems/apset-ruby/api/v1/api_key.yaml \
  > ~/.gem/credentials
```

Build the gem:

```sh
gem build companion_cube.gemspec
```

Install the gem locally: (optional)

```sh
gem install companion_cube-*.gem
```

Push the gem:

```sh
gem push companion_cube-*.gem
rm companion_cube-*.gem
```

## License

Please refer to [LICENSE](LICENSE).

## Authors

*   Partner Ecosystem Team, IBM Digital Business Group <mailto:imcloud@ca.ibm.com>
