# Dockerized ELK instances for DTRIAC smart archive project

## dtriac-534 demo (2019 June) 

`docker-compose-1906demo.yml` file provides ELK + dtriac-webapp instance as orchestrated containers using `docker-compose`. 

### Running 
Run `docker-compose -f <yml_file_name> up`. Notice the order of arguments for specifying the compose file.
```
docker-compose -f docker-compose-2001demo.yml up
```

(Running this will create three docker volumes at current directory (`esdata{1,2,3}`) that can be copied to other machines for migration)

## dtriac-19d demo (2020 January)

`docker-compose-2001demo.yml` file provides ELK instance (three ES nodes + Kibana + monitoring app). Again, use `docker-compose` for running it. 

### Running 
This compose needs [a project name](https://docs.docker.com/compose/reference/overview/#use--p-to-specify-a-project-name) to run. In tarski, which we used for the demo, it was running under a project name `dtra` and all associated docker configs (networks, volumes) are tied to the name. 
```
docker-compose -f docker-compose-2001demo.yml -p dtra up
```
Unlike 1906demo, this will not create "local" docker volumes in current directory (will use global docker disc space for volumes). 
