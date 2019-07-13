# Neptune

## Setup

### Run Docker containers

``` bash
docker-compose up -d
```

### Install dependencies
``` bash
bundle install
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
