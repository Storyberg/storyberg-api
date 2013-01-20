## Storyberg

Storyberg is a project management tool that helps business owners make better decisions.

http://storyberg.com

## What does this Gem do?

- Identify accounts and users with attributes.
- Track events with attributes.

## Install

```ruby
  gem install storyberg
```

## Usage

### Initialize Storyberg

```ruby
  Storyberg::init YOUR_STORYBERG_API_TOKEN
```
  **YOUR_STORYBERG_API_TOKEN** is generated on your "Project settings" page.

### Identify Users Directly

```ruby
  Storyberg.identify user_id, attributes
```

**user_id** : string
  A unique identifier for the user.

** attributes** is an optional hash that accepts the following keys:

* **n** : string
  The user's full name.

* **e** : string
  The user's email address.

* **sud** : integer
  A Unix timestamp of the sign-up date.

* **a** : string
  You can associate a user to an account by providing a unique identifier for the account such as an account ID. A user may be associated to multiple accounts by sending the same user_id with different account_ids.

* **an** : string
  The account's name. An account name will only be recorded if an account identifier has also been provided. 

* **sbt** : string
  Tag the user's session with a campaign name. A Tag is used to connect the users interactions with the application to a campaign allowing you to identify which campaign was most affective. Tag names will appear on your Validation Board.

* **ls** : integer
  A Unix timestamp of when the user is last seen. This key can be used to import existing users.

* **asud** : integer 
  A Unix timestamp of when the account was created. This key can be used to import existing accounts.

Example:

```ruby
  Storyberg.identify current_user.id, {e: current_user.email, n: current_user.display_name, sud: current_user.created_at.to_i, a: current_user.organization.id, an: current_user.organization.name}
```
### Track Events

```ruby
  Storyberg.record user_id, attributes
```

**user_id** is the unique identifier of a user who has previously been identified.

**attributes** is an optional hash that accepts the following keys:

* **a** : string
  A unique identifier of an existing account which this user has been registered to. This will connect the users activity to a specific account.

* **sbt** : string
  Tag the event with a campaign name. If a tag is not supplied, Storyberg will search for a user session that contains a tag and automatically associate the tag with the event.
  
Example:
```ruby
  Storyberg.record current_user.id, {a: current_user.organization.id}
```

### Import Your Existing Data

Import your existing users and accounts into Storyberg by identifying them with an attribute hash that contains: ls (last seen) and asud (account sign up date) keys. By setting these values, the users membership length will be when you specify rather than the time of the import. 

Example:

```ruby
Storyberg.init YOUR_STORYBERG_API_KEY
@organizations = Organization.all
@organizations.each do |organization|
  organization.users.each do |user|
    puts "Identifying #{user.display_name}@#{organization.name}"
    Storyberg.identify user.id, {e: user.email, n: user.display_name, sud: user.created_at.to_i, a: organization.id, an: organization.name, ls: user.created_at.to_i, asud: organization.created_at.to_i}
  end
end
```

## Supported Ruby Platforms

- 1.9.3
