## Storyberg

Storyberg is a project management tool that helps business owners make better decisions.

http://storyberg.com

## What does this gem do?

- Identify accounts and users with attributes.
- Track events with attributes.

## Install

```ruby
  gem install storyberg
```
### Install in Rails
If you plan to use Storyberg with a Rails application, add `gem 'storyberg'` to your gemfile and run `bundle install` to install the storyberg gem.

## Usage

### Initialize Storyberg

  Before calling any of the common methods you must call Storyberg::init with a valid API key (found on your project settings page.)

```ruby
  Storyberg::init YOUR_STORYBERG_API_TOKEN
```
### Initialize in Rails
You can initalize Storyberg in Rails by calling `Storyberg::init` in an initalizer `config/initializers/storyberg.rb`

### Identify Users Directly

```ruby
  Storyberg.identify user_id, attributes
```

**user_id** : string
    A unique identifier for the user.

** attributes** is an optional hash that accepts the following keys:

* **name** : string
    The user's full name.

* **email** : string
    The user's email address.
    
* **sign_up_date** : integer
    A Unix timestamp of the sign-up date.
  
* **sb_tag** : string
    Tag the user's session with a campaign name. A Tag is used to connect the users interactions with the application to a campaign allowing you to identify which campaign was most affective. Tags need to be one word with no spaces.
* **last_seen** : integer
    A Unix timestamp of when the user is last seen. This key can be used to import existing users.
    
Example:
  
```ruby
  Storyberg.identify current_user.id, {email: current_user.email, name: current_user.full_name, sign_up_date: current_user.created_at.to_i}
```
  
### Track Events

  Track any events your users have performed.

```ruby
  Storyberg.event event_name, user_id
```
**event_name** is the the name of the event. Set the event_name to be 'key' when tracking your key activity you want your users to perform.
  
**user_id** is the unique identifier of a user who has previously been identified.
  
How to use it from Rails controllers?

Example:
```ruby
  Storyberg.event 'watched video', current_user.id
```
### Tracking The Key Activity 

  Record is a quick way to track your key activity. It is the same as calling Storyberg.event('key', user_id)

```ruby
  Storyberg.record user_id
```
**user_id** is the unique identifier of a user who has previously been identified.

Example:
```ruby
  Storyberg.record current_user.id
```


### Track Payments 

  Paid is a quick way to track when your user has made a payment. It is the same as calling Storyberg.event('paid', user_id)

```ruby
  Storyberg.paid user_id, attributes
```
  
**user_id** is the unique identifier of a user who has previously been identified.
  
How to use it from Rails controllers?

Example:
```ruby
  Storyberg.paid current_user.id
```
  
### Import Your Existing Data
  
Import your existing users and accounts into Storyberg by identifying them with an attribute hash that contains: last_seen and account_sign_up_date keys. By setting these values, the users membership length will be when you specify rather than the time of the import. 

This can be done using a Rake task.
  
Example:

`lib/tasks/import_users.rb`
  
```ruby
namespace :db do
  task :import_users => :environment do
    Storyberg.init YOUR_STORYBERG_API_KEY
    @users = User.all
      users.each do |user|
        puts "Identifying #{user.display_name}"
        Storyberg.identify user.id, {email: user.email, name: user.full_name, sign_up_date: user.created_at.to_i, last_seen: user.created_at.to_i}
      end
    end
end
```

Run `rake db:import_users` to start the Rake task.
  
## Supported Ruby Platforms
  
- 1.9.3
