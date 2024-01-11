# Iterable App
This document provides instructions on how to set up and run RSpec for testing.

## Prerequisites
Before running RSpec, ensure that the following prerequisites are installed on your machine:

- Ruby (version 3.2.2)
- Ruby on Rails (version 7.0.8)
- Bundler (installed using `gem install bundler`)

## Installation
1. **Clone the Repository:**
    Clone the applcation and install all the required gems.

    ```sh
    git clone https://github.com/bprateek10/iterable_app.git
    cd  iterable_app
    bundle install
    ```
2. **Run Migrations**
    ```sh
    rails db:migrate
    ```
3. **Add shared master.key under config directory**
    
4. **Start Server**
    ```sh
    rails s
    ```
    The application should be runnning on localhost:3000

## Getting Started

1. You can signup with any email and play around the application.

2. To run specs, run the following command: 
    ```sh
    rspec
    ```
