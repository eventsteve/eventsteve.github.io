---
layout:     post
title:      How to install a ssl certificate on nginx server
date:       2016-05-04 12:31:19
summary:    Node and npm Version Numbering
category:   nodejs
comments:   True
tags:       nodejs
permalink:  /how-to-install-a-ssl-certificate-on-nginx-server.html
---


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
