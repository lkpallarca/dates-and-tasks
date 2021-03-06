# **[Dates and Tasks](https://dates-and-tasks.herokuapp.com/)**

[![dates-and-tasks-app.png](https://i.postimg.cc/tTt4480k/dates-and-tasks-app.png)](https://postimg.cc/wyMpWfjR)

Dates and Tasks app is an app that can be used to organize tasks categorized per day on a calendar UI. It features user login simulation using **Devise**, search models and/or sql query using **Ransack**, and performing Test Driven Development (TDD) and Behavior Driven Development (BDD) on Ruby on Rails using **RSpec**. It is deployed on Heroku and can be accessed by clicking on the title above.

-----------

## Ruby Version

Ruby 3.1.2

## System Dependencies

* Rails 6.1.6
* NodeJS 16.3.0
* Yarn 1.22.18
* PostgreSQL 14.2

## Featured Gems
* gem 'simple_calendar'
* gem 'devise'
* gem 'ransack'
* gem 'rspec-rails'

## Configuration

```
bundle install
yarn install --check-files
bundle binstubs rspec-core (creates executable for rspec)
```

## Database Initialization

```
rails db:create
  or
rails db:setup (to initiate seeds on the database)

rails db:migrate
```

## How to run the Test Suite

```
bin/rspec (courtesy of bundle binstubs rspec-core)
```

## Deployment Instructions

```
heroku login
git push heroku <branch name>
heroku run rails db:migrate
heroku run rails db:seed
```

-----------

Fair Use
