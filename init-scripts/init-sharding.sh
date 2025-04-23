#!/bin/bash
echo "Waiting for MongoDB services to start..."
sleep 30

# Initialize Config Server Replica Set
echo "Configuring Config Server Replica Set..."
mongosh --host cfgsvr1 --port 27017 <<EOF
rs.initiate({
  _id: "cfgrs",
  configsvr: true,
  members: [
    { _id: 0, host: "cfgsvr1:27017" },
    { _id: 1, host: "cfgsvr2:27017" },
    { _id: 2, host: "cfgsvr3:27017" }
  ]
})
EOF

# Initialize Shard 1 Replica Set
echo "Configuring Shard 1 Replica Set..."
mongosh --host shard1svr1 --port 27017 <<EOF
rs.initiate({
  _id: "shard1rs",
  members: [
    { _id: 0, host: "shard1svr1:27017" },
    { _id: 1, host: "shard1svr2:27017" },
    { _id: 2, host: "shard1svr3:27017" }
  ]
})
EOF

# Initialize Shard 2 Replica Set
echo "Configuring Shard 2 Replica Set..."
mongosh --host shard2svr1 --port 27017 <<EOF
rs.initiate({
  _id: "shard2rs",
  members: [
    { _id: 0, host: "shard2svr1:27017" },
    { _id: 1, host: "shard2svr2:27017" },
    { _id: 2, host: "shard2svr3:27017" }
  ]
})
EOF

# Wait for replica sets to initialize
echo "Waiting for replica sets to initialize..."
sleep 30

# Add shards to the cluster
echo "Adding shards to the cluster..."
mongosh --host mongos --port 27017 <<EOF
sh.addShard("shard1rs/shard1svr1:27017,shard1svr2:27017,shard1svr3:27017")
sh.addShard("shard2rs/shard2svr1:27017,shard2svr2:27017,shard2svr3:27017")

// Enable sharding for a database
sh.enableSharding("testdb")

// Create a collection with a shard key
db.adminCommand({
  createCollection: "testdb.testcollection"
})

// Shard the collection
sh.shardCollection("testdb.testcollection", { "_id": "hashed" })

// Show sharding status
sh.status()
EOF

echo "MongoDB sharded cluster setup completed!"