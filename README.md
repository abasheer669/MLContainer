# README
# ML Containers

ML containers is a container management application. This is an admin application which gives detailed views to various features.

## Table of Contents

- [Installation](#installation)
- [Usage](#usage)
- [Features](#features)
- [Tests](#tests)
- [UI](#UI)
- [DB diagram](#DB)

## Installation

1. Clone the repository: `git clone <repository-url>`
2. Install dependencies: `bundle install`
3. Set up the database: `rails db:setup`
4. Start the server: `rails server`

## Usage
The application is rails only application. Once the rails server is up and running, Hit various endpoints with proper headers and json payloads.

## Configuration

Explain any configuration files, environment variables, or settings that need to be configured.

## Features

- User Authentication
    - Devise Gem
- token based Authorization
    - Doorkeeper Gem

- Customer CRUD
- Container CRUD
    - Create container with container details including comments and attachments
    - Show contianer. It displays container detains with corresponding activities with its items. Comments and logs are also displayed along
    - Index Container. It displays all containers details. Filtering based on activities, owner name, activity date and activity status. It has multiple tabs to view draft, admin review pending and customer approved container details. Searching of container with container number is implemented.
    - update container
- Activity CRUD



## Tests

Rspec for containers, authentication, customer, items and activityies have been implemented testing various edge cases.

## UI

https://xd.adobe.com/view/991d39b4-53f3-4e3c-940f-a5157b752d16-cc4e/?fullscreen

## DB Design

https://dbdiagram.io/d/64b7c37302bd1c4a5e565e00

