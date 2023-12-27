### Basic
_-- help_ for any comm, get all available options, for example `docker --help`

`docker ps -a` - all containers

`docker run...` - creates new container (attached by default)

`docker start containerId` - start existing container (de-attached by def)

Attached container - you will see output on console
-d - option for de-attach (run), -a for attach (start)

`docker attach containerId` or `docker logs containerId` - show logs (outputs)

Another way to attach - interactive mode - you can input -> '-i' options, 
also in run command you can ask for terminal -t (-it)

### Managing images and containers
`docker rm containerId1 containerId2` remove stopped container by id

`docker container prune` - remove all stopped containers at once

`docker rmi imgId1 imgId2`

`docker image prune -a` - remove all images that don`t have containers

`docker run --rm ...` - container will be removed when it stops

Container builds up on an image. It extra run layer. 
So it takes much less space and totally depends on it. 
Container can`t be exist without an image.

`docker image inspect`

`docker cp pathToLocalFileOrFolder containerId:/pathDestination` - copy to or from container

You can set a name for run container. Also you can named buid image by "repo:tag" mask name.
tag is optional (vendors use it for versions)
`docker build -t myapp:latest .`

`docker run -p 8080:80 my-node-app:latest` available on http://localhost:8080/

`docker logs containerId` - can show issues during the docker run

You can run container by your local or shared (global) image. Searched by name.
`docker run node` - run global image (download it firstly)

`docker pull imgName` - always pull the last version if it diff with your local version. When run cmd will use local image if it exist

### Volumes
1. Anonymous - in docker file - VOLUME["Path in container"] (or in run -v pathInContainer), managed by docker, removed when you remove container
2. Named - in docker run command -v name:pathInContainer - will survive the container removing, but can`t be edit. As anonymous it manages by a docker, we dont know where it placed  
3. Bind mounts - in docker run command -v absolutePathOnYorMashine:pathInContainer. $(pwd) - shortcut for abs path for current dir, totally connect your folder with container folder. You can change the code and will appear on container
`docker volume ls` - list of all volumes
`docker volume rm VOL_NAME`, `docker volume prune`
   -v absolutePathOnYorMashine:pathInContainer:ro - mark to readonly mount volume

### Variables and Arguments
1. Env variables use during container run. Specify specific args for an app. Define by ENV and uses in dockerfile by $. Set such a variables can from run by --env, or specific file like .env (but with reference in run command --env-file)
2. Build args use during an image build. Define by ARG and uses in dockerfile by $. Set such a variables can from build by --build-arg

### Network
1. You can reach any www outside API inside your container without any settings
2. For connection with your localhost inside container needs to use special phraze - host.docker.internal
3. For connection between containers needs to create share network (`docker network create net-name`) and then use it in run command. Inside a container you can reach another container by it name 

### Docker compose
Manage few containers in one network by default. All services (containers) define in docker-compose.yaml file (that contains all build and run arguments). All these containers will build and start by one command
`docker-compose up`
To stop and remove all containers:
`docker-compose down`