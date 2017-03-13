---
layout: post
title:      How-to-create-a-web-application-project-with-maven
date:       2012-07-12 12:32:00
summary:    In this tutorial, we will show you how to create a Java web project (Spring MVC) with Maven..
category:   java
comments:   true
tags:       maven
permalink:  /how-to-create-a-web-application-project-with-maven.html
---


Technologies used :

Maven 3.1.1
Eclipse 4.2
JDK 7
Spring 4.1.1.RELEASED
Tomcat 7
Logback 1.0.13


1. Create Web Project from Maven Template

You can create a quick start Java web application project by using the Maven maven-archetype-webapp template. In a terminal (*uix or Mac) or command prompt (Windows), navigate to the folder you want to create the project.

Type this command :

$ mvn archetype:generate -DgroupId={project-packaging} 
	-DartifactId={project-name} 
	-DarchetypeArtifactId=maven-archetype-webapp 
	-DinteractiveMode=false

//for example 
$ mvn archetype:generate -DgroupId=com.mkyong 
	-DartifactId=CounterWebApp 
	-DarchetypeArtifactId=maven-archetype-webapp 
	-DinteractiveMode=false



2. Project Directory Layout

Review the generated project layout :

.
|____CounterWebApp
| |____pom.xml
| |____src
| | |____main
| | | |____resources
| | | |____webapp
| | | | |____index.jsp
| | | | |____WEB-INF
| | | | | |____web.xml
Maven generated some folders, a deployment descriptor web.xml, pom.xml and index.jsp.



3. Eclipse IDE Support
To import this project into Eclipse, you need to generate some Eclipse project configuration files :

3.1 In terminal, navigate to “CounterWebApp” folder, type this command :

mvn eclipse:eclipse -Dwtpversion=2.0
Note
This option -Dwtpversion=2.0 tells Maven to convert the project into an Eclipse web project (WAR), not the default Java project (JAR). For convenience, later we will show you how to configure this WTP option in pom.xml.

