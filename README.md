# Quake Log Parser
This application processes Quake game logs and provides insights such as total kills, players involved, and more.

## Prerequisites
- Docker
- Docker Compose

## Setup & Running
1. **Build the Docker Containers**:

```
docker-compose build
```

2. **Run the Application**:
To process the logs using the CLI:

```
docker-compose run cli
```

3. **Run Tests**:
To execute the RSpec tests:
```
docker-compose run rspec
```

## Structure
- **app.rb**: This is the main application file where the log processing happens.
- **spec/**: This directory contains all the RSpec tests for the application.
- **docker-compose.yml**: Docker Compose file that orchestrates the building and running of all required services, such as the Ruby CLI app, PostgreSQL and RSpec.
- **Dockerfile**: Docker configuration for the application.
- **Gemfile**: Application dependencies.
- **Gemfile.lock**: Application dependencies versions.
