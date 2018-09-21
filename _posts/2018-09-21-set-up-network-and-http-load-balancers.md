---
title: "GCP: Set Up Network and HTTP Load Balancers"
tags:
  - table of contents
toc: true
toc_sticky: true
---

"Stick" table of contents to the top of a page by adding `toc_sticky: true` to its YAML Front Matter.

```yaml
---
toc: true
toc_sticky: true
---
```

## Overview

In this hands-on lab, you'll learn the differences between a network load balancer and a HTTP load balancer, and how to set them up for your applications running on Google Compute Engine virtual machines.

There are two types of <a href="https://cloud.google.com/compute/docs/load-balancing-and-autoscaling#network_load_balancing">load balancers in Google Cloud Platform</a>:

      L3 <a href="https://cloud.google.com/compute/docs/load-balancing-and-autoscaling#network_load_balancing">load balancers in Google Cloud Platform</a>
     *  <a href="https://cloud.google.com/load-balancing/docs/https">L7 HTTP(s) Load Balancer</a>
This labs will take you through the steps to setup both types of load balancers.

We encourage students to type the commands themselves, to help encourage learning of the core concepts. Many labs will include a code block that contains the required commands. You can easily copy and paste the commands from the code block into the appropriate places during the lab.

**What you'll do**

Setup a network load balancer.

Setup a HTTP(s) load balancer

Get hands-on experience learning the differences between network load balancers and HTTP load balancers.

## Create multiple web server instances

To simulate serving from a cluster of machines, we'll create a simple cluster of Nginx web servers that will serve static content using Instance Templates and Managed Instance Groups. Instance Templates lets you to define what every virtual machine in the cluster will look like (disk, CPUs, memory, etc), and a Managed Instance Group instantiates a number of virtual machine instances for you using the Instance Template.

First, create a startup script that will be used by every virtual machine instance to setup Nginx server upon startup:


```bash
cat << EOF > startup.sh
#! /bin/bash
apt-get update
apt-get install -y nginx
service nginx start
sed -i -- 's/nginx/Google Cloud Platform - '"\$HOSTNAME"'/' /var/www/html/index.nginx-debian.html
EOF
```

Second, create an instance template that will use the startup script:

```bash
gcloud compute instance-templates create nginx-template \
         --metadata-from-file startup-script=startup.sh
```
(Output)

```bash
Created [...].
NAME           MACHINE_TYPE  PREEMPTIBLE CREATION_TIMESTAMP
nginx-template n1-standard-1             2015-11-09T08:44:59.007-08:00
```

Lorem ipsum dolor sit amet, test link adipiscing elit. **This is strong**. Nullam dignissim convallis est. Quisque aliquam.

![Smithsonian Image]({{ site.url }}{{ site.baseurl }}/assets/images/3953273590_704e3899d5_m.jpg)
{: .image-right}

*This is emphasized*. Donec faucibus. Nunc iaculis suscipit dui. 53 = 125. Water is H2O. Nam sit amet sem. Aliquam libero nisi, imperdiet at, tincidunt nec, gravida vehicula, nisl. The New York Times (That’s a citation). Underline.Maecenas ornare tortor. Donec sed tellus eget sapien fringilla nonummy. Mauris a ante. Suspendisse quam sem, consequat at, commodo vitae, feugiat in, nunc. Morbi imperdiet augue quis tellus.

HTML and CSS are our tools. Mauris a ante. Suspendisse quam sem, consequat at, commodo vitae, feugiat in, nunc. Morbi imperdiet augue quis tellus. Praesent mattis, massa quis luctus fermentum, turpis mi volutpat justo, eu volutpat enim diam eget metus.

### Blockquotes

> Lorem ipsum dolor sit amet, test link adipiscing elit. Nullam dignissim convallis est. Quisque aliquam.

## List Types

### Ordered Lists

1. Item one
   1. sub item one
   2. sub item two
   3. sub item three
2. Item two

### Unordered Lists

* Item one
* Item two
* Item three

## Tables

| Header1 | Header2 | Header3 |
|:--------|:-------:|--------:|
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|----
| cell1   | cell2   | cell3   |
| cell4   | cell5   | cell6   |
|=====
| Foot1   | Foot2   | Foot3
{: rules="groups"}

## Code Snippets

```css
#container {
  float: left;
  margin: 0 -240px 0 0;
  width: 100%;
}
```

## Buttons

Make any link standout more when applying the `.btn` class.

```html
<a href="#" class="btn btn--success">Success Button</a>
```

<div markdown="0"><a href="#" class="btn">Primary Button</a></div>
<div markdown="0"><a href="#" class="btn btn--success">Success Button</a></div>
<div markdown="0"><a href="#" class="btn btn--warning">Warning Button</a></div>
<div markdown="0"><a href="#" class="btn btn--danger">Danger Button</a></div>
<div markdown="0"><a href="#" class="btn btn--info">Info Button</a></div>

## Notices

**Watch out!** You can also add notices by appending `{: .notice}` to a paragraph.
{: .notice}