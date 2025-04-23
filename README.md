# MongoDB cluster setup with Docker Compose

## Description
This project provides a simple way to set up a MongoDB cluster using Docker Compose. It includes configurations for replica sets and sharding, making it easy to deploy a scalable MongoDB environment for development and testing purposes.

## Features
- **Replica Set**: Set up a MongoDB replica set with three nodes for high availability.
- **Sharding**: Configure a sharded cluster with two shards, each containing a replica set.
- **Docker Compose**: Use Docker Compose to manage the deployment and scaling of MongoDB instances.

## Prerequisites
- Docker: Ensure you have Docker installed on your machine. You can download it from [Docker's official website](https://www.docker.com/get-started).
- Docker Compose: Make sure you have Docker Compose installed. You can find installation instructions [here](https://docs.docker.com/compose/install/).
- MongoDB: Familiarity with MongoDB concepts such as replica sets and sharding is recommended.
- Network Configuration: Ensure that your Docker network settings allow for communication between containers. The default bridge network should work, but you may need to adjust settings if you're using a custom network.
- Firewall Settings: If you're running Docker on a machine with a firewall, ensure that the necessary ports are open for communication between containers. The default MongoDB port is 27017, but additional ports may be required for sharding and replica sets.

## Getting Started
```bash
# run docker compose to start
docker-compose up -d
```

## Accessing MongoDB
You can access the MongoDB instances using the following connection strings:
- Replica Set: `mongodb://localhost:27017`