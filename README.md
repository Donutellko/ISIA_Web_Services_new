
## 
Please familiarize yourself with the `Dockerfile`.

You can put any .war file to `./target` or `./docker` folder and it will be used by Tomcat. 
So you can put there the .war file from the CV and access it using the default [link]
(http://localhost:8080/ISIA_servicios_web/serviciosweb?wsdl). 

## Build Maven project

If you only want to deploy your war, you can skip this step.   

Use Maven to build the project and generate a `./target/*.war` file.
Do it before building an image or before deploying the file manually using the Tomcat Manager (link below):
```shell
mvn clean package
```

## Build Docker image

To build a docker image:
```sh
docker build -t mytomcat .
```

## Run Docker container

Firstly, you need to start Docker Desktop or any other engine (podman, ...).

Run the service:
```shell
docker run --rm --name tomcat \
      -v ./tomcat_volume:/usr/local/tomcat/webapps/volume/ \
      -p 8080:8080 -p 5005:5005 \
      mytomcat
```

## Accessing the app

You can now access the app:

http://localhost:8080/ISIA_servicios_web_new/serviciosweb?wsdl

As well as any `.war` you put to the `./docker` directory.

## WAR deployment

You can upload war files without rebuilding and restarting the image/container using this link: 
[Tomcat Manager](http://localhost:8080/manager/html/). Use credentials from `docker/tomcat-users.xml`.

Also, you can use `tomcat_volume` folder to pass files to and from tomcat.

To connect to the Docker container:
```shell
docker exec -it $(docker ps | grep "tomcat" | awk '{print $1}')  bash
```


## Debugging the app

You can also use Remote debug on port `:5005`.

## Create a client

Now you can generate the client using Java 8 
```sh
wsimport -keep -p org.isia.client http://localhost:8080/ISIA_servicios_web_new/serviciosweb\?wsdl
```

For newer Java versions you can use [jaxws-maven-plugin](https://www.baeldung.com/maven-wsdl-stubs).
