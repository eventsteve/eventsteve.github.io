---
layout:     post
title:      whats-the-practical-difference-between-canvas-connected-apps in Salesforce
date:       2016-06-11 15:31:19
summary:    Node and npm Version Numbering
category:   salesforce
comments:   True
tags:       salesforce
permalink:  /whats-the-difference-between-canvas-connected-apps-in-salesforce.html
---


Question

What's the point of canvas vs. connected apps, and what should I be thinking about when choosing between them?

Background

We're in the process of building out a couple tools that will be integrated with our Salesforce instance and I'm weighing the pros and cons of canvas vs. connected apps (as well as Visualforce, but that's another question), and for the life of me I can't figure out what differences there are between the two that would matter from an architect perspective.

So far it seems that, both provide a way to get an access token, can be run on any servers, can use any development language. So what's the deal?




http://salesforce.stackexchange.com/questions/15494/whats-the-practical-difference-between-canvas-connected-apps

Canvas App

Canvas apps are designed to the part of the user interface. Either the app is designed to appear to be native to salesforce.com, like a Visualforce page, or is intended to be accessed through salesforce.com, such as legacy cloud apps. Authentication for a canvas app is server-initiated and controlled by profiles and permission settings. The app cannot be accessed outside salesforce.com unless it provides an alternative login mechanism. The session lifespan is only as long as the user is logged in to the user interface. The app has full access to the user's data, just as any normal API-style application. The app must be cloud-based. Access is automatically granted.

Connected App

Connected apps are designed to be run independently of the user interface. Either the app is hosted on an external website that interfaces with salesforce.com, or is a desktop or mobile app that runs on a client. Authenication for a connected app is client-initiated and must be done per-client. Connected apps are usually accessed outside salesforce.com, although this is not a stringent requirement. The session lifespan may be indefinite until revoked by the user or an administrator. the app has limited access to the user's data (referred to as the scope), which may be as minimal as identity confirmation only up to full access. The app may be run on a server or client. Access must be manually granted.

Examples

Canvas apps excel at providing services that are accessed through the user interface of salesforce.com. For example, a service that provides salesforce.com users the ability to send mass emails could be implemented as a canvas app. The app doesn't need to be run when the user is not log in, and doesn't have any meaningful context outside salesforce.com. The app doesn't request a username, password, or security token, because the authentication is initiated by the server. From the user's perspective, the integration is seamless, and they may not even be aware that they are running an application on a third-party server. This design model is identical to API-enabled programs that are accessed through a web tab by providing a session ID; this mechanism is meant to replace that model of logging in. It has better security because the administrator can control access per-profile, while the old model only permitted either all-or-none access to any API via the "API Enabled" permission. Note that the API must still be enabled, but even when enabled, if a user doesn't have access to the app, they won't be able to access it.

Connected apps, on the other hand, are intended to be accessed outside of salesforce.com. While there are still profile- and permission set-level controls, an initial authorization still has to occur. Depending on the app, the user may need to provide a username, password, and security token, although the "web flow" can still be used to obtain a token. Unlike a canvas app, this app now has access to the system for as long as the access token remains valid. This could be days, weeks, months, years, forever. Each individual client has its own authorization token, and this token can be revoked as necessary. For example, an instant messaging system that leverages salesforce.com's Chatter would be a connected app. If the device is lost or stolen, the authentication token can be revoked, removing that client's ability to use the system. Since the username, password, and token are not stored by the client, there is no way the device could access salesforce.com data once the authenication token is revoked. Login is not seamless, though, so one wouldn't ordinarily want to simply place a connected app in a web tab, since the user would have to grant access.

Questions

Generally speaking, there are a few pertinent questions that will decide which mode of access you want to use:

Should the app appear in the UI? (yes: canvas, no: connnected)
Does the app need long-lived access to the system? (yes: connected, no: canvas)
Does the app run on a client? (yes: connected, no: connected/canvas)
Should the apps access be limited by scope? (yes: connected, no: connected/canvas)
Can the app be lost or otherwise physically compromised? (yes: connected, no: canvas)
Does the app provide functionality outside salesforce? (yes: connected, no: canvas)
Common Examples

These examples are just like other popular APIs out there, such as Facebook or so-called "social APIs".

A news website that lets you Chatter about articles: connected
A mass emailer app that lets you email from a variety of mailing lists: connected
A website that lets you log in to your account through salesforce.com: connected
A desktop data loader application: connected
A blog that Chatters about new articles and comments: connected
A custom calendar that appears in salesforce.com and pulls data from other sources: canvas
A mass emailer that can only be used with salesforce.com: canvas
A legacy application an enterprise uses that needs to be exposed through salesforce.com's UI: canvas
A data cleansing tool that runs inside salesforce.com: canvas
A bug tracker app that appears inside the salesforce.com UI: canvas
Synonyms

A canvas app is an "embedded app," similar to older applications that accepted a session ID in order to use, classically like a S-Control tab, but with better permission control.

A connected app is an "API app," similar to older applications that used a username and password to obtain a session ID in order to use, but can be revoked from the system, have a longer session lifespan than a session ID, and have fine-tuned controls to limit access as necessary.



Summary: canvas apps run inside a salesforce.com context as a tab, connected apps run outside salesforce.com but use salesforce.com as the authentication mechanism or data source (depending on what permissions are requested/granted)

Question

What's the point of canvas vs. connected apps, and what should I be thinking about when choosing between them?

Background

We're in the process of building out a couple tools that will be integrated with our Salesforce instance and I'm weighing the pros and cons of canvas vs. connected apps (as well as Visualforce, but that's another question), and for the life of me I can't figure out what differences there are between the two that would matter from an architect perspective.

So far it seems that, both provide a way to get an access token, can be run on any servers, can use any development language. So what's the deal?




Installing an SSL certificate has always been a headache, so today we do this step by step tutorial to configure an SSL certificate on a Nginx server.

My server (VPS) runs Debian, but this tutorial should work on all Linux distributions.

For this example I will use a ‘PositiveSSL” certificate from Comodo and a Nginx Server


Note: The certificate can be purchased anywhere, particularly what I bought in NameCheap, but the steps to register and install are the same.

In this tutorial we assume you have access as “sudo” and also have an SSH connection.

  * Install Nginx:sudo apt-get updatesudo apt-get install nginx
  * Generate our private key (.key)openssl genrsa -des3 -out .key 2048
On put the IP domain or site for which generate the SSL Certificate

This generated a private key file by doing so we asked for a password.

Important: Use a strong password and do not forget!!!!

Create a version of the key, without password.openssl rsa -in .key -out
** Important **: If you do not create a version without password every time you reboot nginx service, we will write the certificate password and this can become very annoying.

Generate our Certificate Signing Request (.csr)openssl req -new -key .key.nopass -out .csr
** Important **: To make this .csr file we have to use the .key that has no password.

After a couple of hours to buy the Possitive SSL certificate, we got an email with a zip file that contains the following files:



{% highlight javascript %}
{
  
Root CA Certificate - AddTrustExternalCARoot.crt
Intermediate CA Certificate - PositiveSSLCA2.crt
Your PositiveSSL Certificate - .crt
}
{% endhighlight %}




Download them or Copy them to your server, I recommend you put them in the folder /etc/nginx/ssl/ if not, you can create the folder.


Merge files into one.
To merge files, you need to run this command, this will create a single file with the contents of the 3 files that have reached us by email

cat .crt PositiveSSLCA2.crt AddTrustExternalCARoot.crt >> ssl-all.crt
** Important **: Replace with the name of your domain and / or file name.

Configure Nginx
Once you have created the file ssl-all.crt we have to configure nginx:


{% highlight javascript %}
{
server {
    listen  443 ssl;
    ssl on;
    ssl_certificate /etc/nginx/ssl/yourdomain.com.pem;
    ssl_certificate_key /etc/nginx/ssl/yourdomain.com.key.nopass;
}
}
{% endhighlight %}

** Important **: Check that the path to the folder is correct.

Restart Nginx, and start browsing your site using HTTPSsudo service nginx restart
Try your site:
To test it we have to enter our domain, but putting “https” ahead:

https://yourdomain.com
This is the whole process to configure the certificate, as you can see is not difficult but it is the first or second time they do may seem a bit complicated.



When declaring the dependencies in `package.json` files in Node project, we need to pay attention to version numbers - there are many different ways to specify the version number for dependencies which you want to use.

Here are a few examples.

* 4.8.5
* >4.8.5
* >=4.8.5
* ~4.8.5

You may have read through some tutorials where they will declare dependencies with some characters and a version number and wonder what exactly does that mean?

Colons can be used to align columns.

| Tables        | Are           | Cool111  |
| ------------- |:-------------:| -----:|
| col 3 is      | right-aligned | $1600 |
| col 2 is      | centered      |   $12 |
| zebra stripes | are neat      |    $1 |

There must be at least 3 dashes separating each header cell.
The outer pipes (|) are optional, and you don't need to make the 
raw Markdown line up prettily. You can also use inline Markdown.


|-----------------+------------+-----------------+----------------|
| Default aligned |Left aligned| Center aligned  | Right aligned  |
|-----------------|:-----------|:---------------:|---------------:|
| First body part |Second cell | Third cell      | fourth cell    |
| Second line     |foo         | **strong**      | baz            |
| Third line      |quux        | baz             | bar            |
|-----------------+------------+-----------------+----------------|
| Second body     |            |                 |                |
| 2 line          |            |                 |                |
|=================+============+=================+================|
| Footer row      |            |                 |                |
|-----------------+------------+-----------------+----------------|

### Code, with syntax highlighting

Code blocks use the [solarized](http://ethanschoonover.com/solarized) theme. Both the light and
dark versions are included, so you can swap them out easily. _Solarized Dark_ is the default.

{% highlight javascript %}
{
  "name": "awesome-sauce",
  "main": "server.js",
  "dependencies": {
    "express": "^4.0.x" <-- what in the world is that?!
  }
}
{% endhighlight %}

# Headings!

They're responsive, and well-proportioned (in `padding`, `line-height`, `margin`, and `font-size`).
They also heavily rely on the awesome utility, [BASSCSS](http://www.basscss.com/).

##### They draw the perfect amount of attention

This allows your content to have the proper informational and contextual hierarchy. Yay.

### There are lists, too

  * Apples
  * Oranges
  * Potatoes
  * Milk

  1. Mow the lawn
  2. Feed the dog
  3. Dance

### Images look great, too

![desk](https://cloud.githubusercontent.com/assets/1424573/3378137/abac6d7c-fbe6-11e3-8e09-55745b6a8176.png)


### There are also pretty colors

Also the result of [BASSCSS](http://www.basscss.com/), you can <span class="bg-dark-gray white">highlight</span> certain components
of a <span class="red">post</span> <span class="mid-gray">with</span> <span class="green">CSS</span> <span class="orange">classes</span>.

I don't recommend using blue, though. It looks like a <span class="blue">link</span>.

### Stylish blockquotes included

You can use the markdown quote syntax, `>` for simple quotes.

> Lorem ipsum dolor sit amet, consectetur adipiscing elit. Suspendisse quis porta mauris.

However, you need to inject html if you'd like a citation footer. I will be working on a way to
hopefully sidestep this inconvenience.

<blockquote>
  <p>
    Perfection is achieved, not when there is nothing more to add, but when there is nothing left to take away.
  </p>
  <footer><cite title="Antoine de Saint-Exupéry">Antoine de Saint-Exupéry</cite></footer>
</blockquote>

### There's more being added all the time

Checkout the [Github repository](https://github.com/johnotander/pixyll) to request,
or add, features.

Happy writing.
