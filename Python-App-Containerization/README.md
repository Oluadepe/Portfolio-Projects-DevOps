# Python Flask Application

## Overview
This project contain a simple python application with two routes: the root path '/' and the Contact-Us router '/contact-us'. The application is containerize using Docker. When the root and the Contact-Us path is visited on the browser, they will display 'Hello, World!' and 'Contact Page', respectively.

The Flask application can be run on development server using app.run(host="0.0.0.0", port=5000) to serve the application on all available network interfaces at port 5000
```    http://127.0.0.1:5000/ for 'Hello, World!' ```
```    http://127.0.0.1:5000/Contact-Us for 'Contact Page' ```

## Prerequisite
   The application require the following to run correctly:
   - Python
   - Docker

   You can install Python from the official python <a href="https://www.python.org/downloads/">website</a> then choose according to your opertaing system
   You can install Docker from the official docker <a href="https://docs.docker.com/get-docker/">website</a>  then choose according to your opertaing system

## Project Structure
   The project contain 4 files:
   Dockerfile : Contains a step by step instructions to containerize the application
   main.py : Contains the code for the application routes
   README.md : Contains the information about setting up and running the application
   requirement.txt : Contains the dependencies that the application needs to run

## Building the Docker Image
   To build an image of the flask application, follow the steps below:
   - cd into the project folder 
    ``` cd <project folder>```
   - Run the "docker build" command with "-t" flag to tag the image with a name and "." to tell docker use the current directory to build the image. In this instance I tag the image as "flask-app" and ":1.0" as version of the app. Some use "latest" but its better to use number so you can identify the current version you have. 
     docker build -t flask-app:1.0 .

## Running the Docker Container
   Once the image is successfully build with the tag, you can run the image as a container using the command below
   - docker run -p 8080:5000 flask-app:1.0 "-p" stand for port "8080:5000" means using port 8080 on your system to connect to port 5000 on the container.
     docker run-p 8080:5000 flask-app:1.0
## Addional information
   If you want to push your image to docker hub, you will first need to create a user account on docker hub. re-tag you image to include you dockehub username, then push the image to dockerhub or any other private repository.
    
   Follow the steps below:
   - command  to retag image 
   replace "oluadepe" with your dockerhub username
    docker tag flask-app:1.0 oluadepe/flask-app:1.0

   - command to login to dockerhub from terminal 
    replace "oluadepe" with your dockerhub username
      
      docker login -u oluadepe
   
   - command to push image to dockerhub
    replace "oluadepe" with your dockerhub username
     
      docker push oluadepe/flask-app

## Testing 
 
     docker push oluadepe/flask-app