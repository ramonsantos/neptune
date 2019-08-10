# Neptune

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Build Status](https://travis-ci.org/ramonsantos/neptune.svg?branch=master)](https://travis-ci.org/ramonsantos/neptune)


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
