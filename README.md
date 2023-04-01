# README

## This is a simple URL shortener application built using Ruby on Rails.

## Deployed URL
Deployed to [https://shorten-your-url.up.railway.app/](https://shorten-your-url.up.railway.app/)

## Installation
To install and run this application on your local machine, you must have Ruby 3.0 or higher and Rails 7.0 or higher installed. You can check if you have Ruby installed by running the following command in your terminal: 
<br>
Other versions might work but have yet to be tested.

```
ruby -v
```

Check if you have Rails installed by running the following command in your terminal:

```
rails -v
```
Clone this repo into your local machine
```
git clone https://github.com/wr1159/url-shortener.git
```
Navigate into the application directory:
```
cd url-shortener
```
Install the dependencies by running:
```
bundle install
```
Run the application locally by running:
```
rails server
```

## Testing
Testing was performed with rspec.

Run the tests by running the command
```
rspec
```

## Dependencies 
* Rails 7.0
* [TailwindCSS](https://tailwindcss.com/docs/guides/ruby-on-rails)
* [PostgreSQL](https://medium.com/geekculture/ruby-on-rails-switch-from-sqlite3-to-postgres-590009645c25)
* Geocoder 
* Nokogiri

## Database creation
Run the following
```
rake db:migrate
```

## Deployment instructions
Deploy to Railway by signing up and initialise a PostgreSQL item and add your repo onto the application. Add the Environment variables from the PostgreSQL object. 

These include 
* DATABASE_URL
* PGDATABASE 
* PGPASSWORD
* PGPORT
* PGUSER

Go to config/environments/production.db 
and replace 
```
config.hosts << "shorten-your-url.up.railway.app"
```
with your own link produced in railway.
```
config.hosts << "YOUR LINK"
```
