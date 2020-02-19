# Dockerized ELK instance for dtra-534 demo (2019 June) 

`docker-compose.yml` file provides ELK + dtriac-webapp instance as orchestrated containers using `docker-compose`. 

## Running 
Run `docker-compose -f <yml_file_name> up`. Notice the order of arguments for specifying the compose file.
```
docker-compose -f docker-compose-2001demo.yml up
```
