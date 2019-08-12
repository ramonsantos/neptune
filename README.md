# Neptune

[![Build Status](https://travis-ci.org/ramonsantos/neptune.svg?branch=master)](https://travis-ci.org/ramonsantos/neptune)
[![Maintainability](https://api.codeclimate.com/v1/badges/d4321e831abefbca3c04/maintainability)](https://codeclimate.com/github/ramonsantos/neptune/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/d4321e831abefbca3c04/test_coverage)](https://codeclimate.com/github/ramonsantos/neptune/test_coverage)
[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)


## Setup

### Run Docker containers

``` bash
docker-compose up -d
```

### Install dependencies
``` bash
bundle install
```

``` bash
yarn install
```

### Create and migrate database
``` bash
rake db:create db:migrate
```

### Run application
``` bash
rails server
```

### Run tests
``` bash
rspec
```
