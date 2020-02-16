# Dockerized ELK instance for dtra-534 demo (2019 June) 

`docker-compose.yml` file provides ELK + dtriac-webapp instance as orchestrated containers using `docker-compose`. 

## Running 
Run `docker-compose up`. Notice the order of arguments for specifying the compose file.
```
docker-compose -f docker-compose.yml up
```

Running this will create three docker volumes at current directory (`esdata{1,2,3}`) that can be copied to other machines for migration. 
