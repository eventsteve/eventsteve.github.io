---
layout: post
title:      How-to-create-java-project-with-maven
date:       2014-07-11 12:32:00
summary:    In this tutorial, we will show you how to use create a Java project with Maven, imports it into the Eclipse IDE, and package the Java project into a jar file
category:   java
comments:   true
tags:       maven
permalink:  /how-to-create-java-project-with-maven.html
---


Tools used :

Maven 3.0.5
Eclipse 4.2
JDK 6


1. Create a Project from Maven Template


mvn archetype:generate -DgroupId={project-packaging} 
   -DartifactId={project-name} 
   -DarchetypeArtifactId=maven-archetype-quickstart 
   -DinteractiveMode=false




 2. Maven Directory Layout

 With mvn archetype:generate + maven-archetype-quickstart template, the following project directory structure is created.


 NumberGenerator
   |-src
   |---main
   |-----java
   |-------com
   |---------mkyong
   |-----------App.java
   |---test
   |-----java
   |-------com
   |---------mkyong
   |-----------AppTest.java
   |-pom.xml



   In simple, all source code puts in folder /src/main/java/, all unit test code puts in /src/test/java/.


   In additional, a standard pom.xml is generated. This POM file is like the Ant build.xml file, it describes the entire project information, everything from directory structure, project plugins, project dependencies, how to build this project and etc, read this official POM guide.




   3. Eclipse IDE


   To make this as an Eclipse project, in terminal, navigate to “NumberGenerator” project, type this command :



   mvn eclipse:eclipse



   4. Update POM

   The default pom.xml is too simple, often times you need to add the compiler plugin to tell Maven which JDK version is used to compile your project



##What is parttern ?
A parttern is a reusable solution that can be applied to commonly occurrings problems is software design. Or we can understand pattern are as templates for how you solve problems - ones which can be used in quite a few different situations.


Design patterns have three main benifits :
 1. Pattern are proven solutions :
 2. Patterns can be easily reused
 3. Patterns can be expressive

