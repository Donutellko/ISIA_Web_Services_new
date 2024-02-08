Take a look at the `Dockerfile`.
You can put any .war file to `./target` or `./docker` folder and it will be used by Tomcat. 

To build a docker image:
```sh
docker build -t mywebapp .
mkdir tomcat_volume
```

You can use `tomcat_volume` folder to pass files to and from tomcat.  

Run the service.
```shell
docker run --rm --name tomcat -v ./tomcat_volume:/usr/local/tomcat/webapps/volume/ -p 8080:8080 -p 5005:5005 mytomcat
```

You can now access the app:

http://localhost:8080/ISIA_servicios_web_new/serviciosweb?wsdl

You can upload war files without rebuilding and restarting the image/container using this link: 
http://localhost:8080/manager/html/.

# To create a client model

Using java 8:
```sh 
wsimport -s . -p org.isia.client http://localhost:8080/ISIA_servicios_web/serviciosweb\?wsdl
```

```sh
wsimport -keep -p org.isia.client http://localhost:8080/ISIA_servicios_web/serviciosweb\?wsdl
```

