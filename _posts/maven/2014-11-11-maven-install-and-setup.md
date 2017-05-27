---
layout:     post
title:      Maven install and setup
date:       2015-12-11 12:11:19
summary:    To guide to setup Apache Maven in your Windows or Unix based environment(Linux, Solaris and Mac OS X)
category:   maven
comments:   True
tags:       maven
permalink:  /maven-install-and-setup.html
---



## Table of Contents
  * [Database](#1)
  * [Database2222222](#2)
  * [Database3333](#3)
  * [Database44444](#4)
  * [Database4444455555555](#5)

___



###Database<a id="1"></a>


###Database2<a id="2"></a>




1. Download Apache Maven & Extract it

Download latest Maven version from Apache Maven site for your environment. Unzip or Untar it on your preferred location in your machine.

On Unix based system (Linux, Solaris and Mac OS X), users can use tar command to do the same

$>tar zxvf apache-maven-3.1.1.tar.gz 
On Windows, users can use tools like 7zip/winzip to unzip apache-maven-3.1.1-bin.zip.

A directory named apache-maven-3.1.1 will be created as result.

2. Set M2_HOME & PATH

Create an environment variable named M2_HOME which refers to directory where maven was untarred/ unzipped. and then add this variable to PATH environment variable.

On Unix based system (Linux, Solaris and Mac OS X)

Add an environment variable named M2_HOME

$>export M2_HOME=/usr/local/apache-maven/apache-maven-3.1.1
Then add this M2_HOME variable to PATH

$>export PATH=$M2_HOME/bin:$PATH.
On Windows

Right click Computer->Properties->Advanced System Settings->’Advanced’ tab-> ‘Environment Variables’

then Add a new ‘User Variable’ named M2_HOME in user variables section


Click OK, then Edit the ‘Path’ user variable to add M2_HOME\bin folder in it.


Click OK.

3. Verify JDK installation & JAVA_HOME

Make sure that JAVA_HOME environment variable is set to the location of your JDK installation, and $JAVA_HOME/bin is in your PATH environment variable.

On Unix based system (Linux, Solaris and Mac OS X)

$>export JAVA_HOME=/usr/java/jdk1.6.0_45
$>export PATH=$JAVA_HOME/bin:$PATH.
On Windows





It’s done.

4. Verify Maven setup

Execute command mvn --version to verify maven installation (same command for both windows and Unix).

E:\>mvn --version
Apache Maven 3.1.1 (0728685237757ffbf44136acec0402957f723d9a; 2013-09-17 17:22:2
2+0200)
Maven home: E:\Tools\Build tools\apache-maven-3.1.1
Java version: 1.6.0_45, vendor: Sun Microsystems Inc.
Java home: C:\Program Files\Java\jdk1.6.0_45\jre
Default locale: en_US, platform encoding: Cp1252
OS name: "windows 7", version: "6.1", arch: "amd64", family: "windows"
Above output shows that Apache Maven is installed successfully.