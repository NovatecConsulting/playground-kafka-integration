#!/usr/bin/env bash

TARGET_HOST=${TARGET_HOST:-localhost}
TARGET_PORT=${TARGET_PORT:-3000}

echo -------------------------------------------------
echo - fetching a missing object
echo -------------------------------------------------
curl -i http://${TARGET_HOST}:${TARGET_PORT}/api/task/9999 
echo
echo -------------------------------------------------
echo - posting an object
echo -------------------------------------------------
curl -i -X POST http://${TARGET_HOST}:${TARGET_PORT}/api/task/1111 --header "Content-Type: application/json"  --data '{"assignees":["tom","joe"],"status":{"user":"tom","type":"CREATED"}}' 
echo
echo -------------------------------------------------
echo - posting an object
echo -------------------------------------------------
curl -i -X POST http://${TARGET_HOST}:${TARGET_PORT}/api/task/2222 --header "Content-Type: application/json"  --data '{"assignee":"bob"}' 
echo
echo -------------------------------------------------
echo - getting the posted object 1111
echo -------------------------------------------------
curl -i http://${TARGET_HOST}:${TARGET_PORT}/api/task/1111 
echo
echo -------------------------------------------------
echo - getting the posted object 2222
echo -------------------------------------------------
curl -i http://${TARGET_HOST}:${TARGET_PORT}/api/task/2222 
echo
echo -------------------------------------------------
echo - getting all posted objects
echo -------------------------------------------------
curl -i http://${TARGET_HOST}:${TARGET_PORT}/api/task 
echo
echo -------------------------------------------------
