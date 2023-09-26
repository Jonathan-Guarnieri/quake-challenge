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

## Important considerations
- Players who did not kill or die are not considered
- On line 97 of the `file-qgames-log` file, we have an abrupt break in the log without the game ending record ("ShutdownGame" message). Because of this, this game is disregarded in this application.
