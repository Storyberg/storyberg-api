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
  
* **account_id** : string
    You can associate a user to an account by providing a unique identifier for the account such as an account ID. A user may be associated to multiple accounts by sending the same user_id with different account_ids.

* **account_name** : string
    The account's name. An account name will only be recorded if an account identifier has also been provided.
    
* **tag** : string
    Tag the user's session with a campaign name. A Tag is used to connect the users interactions with the application to a campaign allowing you to identify which campaign was most affective. Tag names will appear on your Validation Board.
    
* **last_seen** : integer
    A Unix timestamp of when the user is last seen. This key can be used to import existing users.
    
* **asud** : integer 
    A Unix timestamp of when the account was created. This key can be used to import existing accounts.
    
Example:
  
```ruby
  Storyberg.identify current_user.id, {email: current_user.email, name: current_user.full_name, sign_up_date: current_user.created_at.to_i}
```
  
### Track Events

```ruby
  Storyberg.record user_id, attributes
```
  
**user_id** is the unique identifier of a user who has previously been identified.
  
**attributes** is an optional hash that accepts the following keys:
  
* **account_id** : string
    A unique identifier of an existing account which this user has been registered to. This will connect the users activity to a specific account.
  
* **tag** : string
    Tag the event with a campaign name. If a tag is not supplied, Storyberg will search for a user session that contains a tag and automatically associate the tag with the event.
      
How to use it from Rails controllers?

Example:
```ruby
  Storyberg.record current_user.id
```
  
### Import Your Existing Data
  
Import your existing users and accounts into Storyberg by identifying them with an attribute hash that contains: ls (last seen) and asud (account sign up date) keys. By setting these values, the users membership length will be when you specify rather than the time of the import. 

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
