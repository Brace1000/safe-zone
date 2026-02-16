#!/bin/bash

echo "Starting SonarQube setup..."

docker-compose up -d

echo "Waiting for SonarQube to start (this may take a few minutes)..."
sleep 30

echo "SonarQube is starting up at http://localhost:9000"
echo "Default credentials: admin/admin"
echo "You will be prompted to change the password on first login"
