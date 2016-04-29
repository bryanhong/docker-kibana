docker-kibana
==

Kibana in a container

>Kibana is an open source analytics and visualization platform designed to work with Elasticsearch. You use Kibana to search, view, and interact with data stored in Elasticsearch indices. You can easily perform advanced data analysis and visualize your data in a variety of charts, tables, and maps. [elastic.co](https://www.elastic.co/products/kibana)

Quickstart
--

The following command will run kibana, if you want to customize or build the container locally, skip to [Building the Container](#building-the-container) below

```
docker run                                                 \
  --detach=true                                            \
  --log-driver=syslog                                      \
  --name="kibana"                                          \
  --restart=always                                         \
  --publish 5601:5601                                      \
  --env ELASTICSEARCH_URL="http://node1.example.com:9200"  \
  bryanhong/kibana:latest
```

### Runtime flags explained

```
--detach=true
```  
run the container in the background  
```
--log-driver=syslog
```  
send logs to syslog on the Docker host  (requires Docker 1.6 or higher)  
```
--name="kibana"
```  
name of the container  
```
--restart=always
```  
automatically start the container when the Docker daemon starts  
```
--publish 5601:5601
```  
Docker host port : mapped port in the container (Kibana WebUI)  
```
--env ELASTICSEARCH_URL="http://node1.example.com:9200"
```
URL to Elasticsearch API endpoint 


Getting Started
--
Once your Kibana container is up and running you should be able to point a web browser to port 5601 of your Docker host and access the WebUI. A good reference for getting started can be found [here](https://www.elastic.co/guide/en/kibana/current/getting-started.html)

Building the container
--

If you want to make modifications to the image or simply see how things work, check out this repository:

```
git clone https://github.com/bryanhong/docker-kibana.git
```

### Commands and variables

* ```vars```: Variables for Docker registry and the application
* ```build.sh```: Build the Docker image locally
* ```run.sh```: Starts the Docker container, if the image hasn't been built locally, it is fetched from the repository set in vars
* ```push.sh```: Pushes the latest locally built image to the repository set in vars
* ```shell.sh```: get a shell within the container

### How this image/container works

**Data**  
Kibana saves state (dashboards, visualizations, settings...) information within Elasticsearch in an index named .kibana. The Kibana container can be treated as ephemeral. If you want to move your dashboards to another Elasticsearch cluster, you can export state in Settings > Objects > Export Everything, assuming the same index and schema exist on the destination cluster.

**Networking**  
By default (in vars), Docker will map port 5601 on the Docker host to port 5601 within the container where Kibana listens by default. You can change the external listening port in vars to map to any port you like.

**Security**  
* **WebUI (port 5601)**  
Kibana does not support authentication or authorization nor does it support the concept of a user. It'll be up to you to devise a way to grant/prevent access to the WebUI if necessary in your deployment.

### Usage

#### Configure the container

1. Configure application specific variables in ```vars```

#### Build the image

1. Run ```./build.sh```

#### Start the container

1. Run ```./run.sh```
 
#### Pushing your image to the registry

If you're happy with your container and ready to share with others, push your image up to a [Docker registry](https://docs.docker.com/docker-hub/) and save any other changes you've made so the image can be easily changed or rebuilt in the future.

1. Authenticate to the Docker Registry ```docker login```
2. Run ```./push.sh```
3. Log into your Docker hub account and add a description, etc.

> NOTE: If your image will be used FROM other containers you might want to use ```./push.sh flatten``` to consolidate the AUFS layers into a single layer. Keep in mind, you may lose Dockerfile attributes when your image is flattened.
