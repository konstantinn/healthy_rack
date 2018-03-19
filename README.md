# HealthyRack

A simple Rack middleware/application for checking health state.

### Disclaimer

This gem was made to fulfill personal needs and for fun. Hasn't been tested in production (yet?).

### Installation

Add this line to your application's Gemfile:

```ruby
gem 'healthy_rack'
```

### Configuration

*HealthyRack* comes with several built in checks available:

```ruby
HealthyRack::Checks::Redis
HealthyRack::Checks::ActiveRecord
HealthyRack::Checks::Sequel
HealthyRack::Checks::Sidekiq
```

By default all of them are disabled.

Also you can easily add custom check. Just provide a subclass of `HealthyRack::Check` or any object with similar interface.

**Example configuration:**

```ruby
HealthyRack.configure do |config|
  config.add_checks(
    HealthyRack::Checks::ActiveRecord.new,
    HealthyRack::Checks::Redis.new('redis://redis:7379/0')
  )
end
```

### Usage as middleware

Just add `HealthyRack.middleware` to middleware stack of your rack application:

```ruby
use HealthyRack.middleware, path: '/health'
```

where `/health` is desired path.

### Mounting as rack application

Mount`HealthyRack.app` at your router:

```ruby
Rack::URLMap.new('/health' => HealthyRack.app)
```

### Similar projects
You may be interested in other projects such as:

* [Pinglish](https://github.com/jbarnette/pinglish)
* [OK Computer](https://github.com/sportngin/okcomputer)
* [Healthcheck](https://github.com/packethost/healthcheck-rb)

Thanks for their authors for the inspiration :)
