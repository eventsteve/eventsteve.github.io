---
layout: post
title:      Design a restful web api
date:       2012-04-12 02:32:00
summary:    Design a restful web api.
category:   nodejs
comments:   true
tags:       maven
permalink:  /design-a-restful-web-api.html
---


Introduction

Everybody provides API’s these days. Some of the most popular ones are Facebook, Twitter, Github, Stripe and the list goes on.

So you need to build an API for your website, maybe you need to provide data to a mobile app you’re working on, or maybe you just want to put the data from your website in a format that other developers can easily use to build cool things.

But what is an API exactly? An API is just a fancy term for describing a way for programs (or websites) to exchange data in a format that is easily interpreted by a machine. This is in contrast to regular websites, which are exchanging data in a format that is easily interpreted by a human. For a website, we might use HTML and CSS, but for an API we would use JSON or XML.

In this article I will be focusing on designing an API using the RESTful paradigm. REST is basically a list of design rules that makes sure that an API is predictable and easy to understand and use.

Some of these rules include:

Stateless design: Data will never be stored in a session (each request includes all information needed by the server and client).
Self-descriptive messages: Ideally you should be able to understand requests and responses after spending minimal time reading the documentation.
Semantics, semantics, semantics: The API should use existing features of the HTTP protocol to improve the semanticness of input and output (e.g. HTTP Verbs, HTTP Status Codes and HTTP Authentication)
One of the most difficult decisions to make when designing a RESTful API is to find the fine line between making your API simple enough that it can be tested directly in the browser for most use cases yet still adhere to the design guidelines as closely as possible.

Now that we have laid the ground rules, let’s dive right into some examples of how to implement these rules.

Output formats

First, let’s talk about output formats. The most important thing to look at when determining what format your API should output data in is what users of your API would be using the data for and with.

Maybe you need to support legacy systems where JSON parsing is not feasible and XML is more desirable, or maybe it makes more sense for you to output data in the CSV format for easy import into spreadsheet applications. Whichever you choose, it’s important to think about your users and their use cases.

You can also consider adding support for multiple output formats. The best way to handle this is to look for the Accept header in the request and serve up a response based on the mime-type requested by the user. This approach is great because it’s very semantic and uses built-in features from the HTTP protocol. Here’s an example:

GET /v1/geocode HTTP/1.1
Host: api.geocod.io
Accept: application/json  GET /v1/geocode HTTP/1.1
Host: api.geocod.io
Accept: application/xml
Should return a JSON response Should return an XML response
 

Supporting multiple formats, however, is rarely necessary. If you’re in doubt which format you should pick, I would recommend going with JSON as it is concise and can be easier to read as well. Always remember to pick a default response type if the Accept header is not set or it’s set to an unsupported type.

Versioning

This is a very important aspect that is often overlooked. As an API provider, one of your most important tasks is to make sure that breaking changes will never occur in your API. Making breaking changes will make life difficult for the developers who depend on your service and can easily start causing frustration when things start to break.

But don’t worry! This is where versioning comes in handy. There are a lot of options for versioning your API. For example, WePay uses an Api-Version header, and Twilio uses a similar approach putting the version date in the URL.

My favorite approach is a simple vX URL prefix, which is used by Github and many others. This allows you to easily deploy a new version of the API, e.g. /v2, and also access different versions of the API directly in the browser (no header changes or other fancy things here).

Here’s an example:

GET /v1/geocode HTTP/1.1
Host: api.geocod.io GET /v2/geocode HTTP/1.1
Host: api.geocod.io
Should return the geocode endpoint from version 1.0 of the API  Should return the geocode endpoint from version 2.0 of the API
URL Structure

The URL structure is one of the most important pieces of the puzzle. Spending some time to define the right endpoint names can make your API much easier to understand and also help making the API more predictable.

URLs should be short and descriptive and utilize the natural hierarchy of the path structure. It’s also important to be consistent with pluralization.

If you are working with objects, keep the object id in the URL and leave everything else to the query string.

Let’s take a store locator API as an example. Here are some possible endpoints:

/v1/stores/1234 – Return the store that has id 1234
/v1/stores/1234/report – Report an error for the store with id 1234
/v1/stores – Return all stores
/v1/stores/near?lat=12.34&lon=-12.34 – Find stores near a given location
/v1/categories – Return a list of store categories
If you allow modification of objects, HTTP verbs are you friend. By applying those to your existing URLs, you will end up with a semantic solution to perform CRUD operations. Here is a list of verbs and their meaning:

HTTP Verb Description
GET This is the most common verb, and is used to retrieve data, e.g. GET /v1/stores/1234
PUT PUT requests are commonly used to update/replace an object, e.g. PUT /v1/stores/1234
POST  This is used to create a new instance of an object, e.g. POST /v1/stores
DELETE  As the name suggests, this will delete the object, e.g. DELETE /v1/stores/1234
Authentication

There are many ways to handle authentication, here are three ideas.

If your API has user-based authentication, OAuth is really the way to go. It might look terribly confusing at first glance, but give it a chance. It’s the only widely-used, proven, and secure solution out there it’s being used by all major API providers and is very well tested.

If you just need to password protect your API, HTTP Basic Authentication is a nice and semantic way to go.

The only issue is if you want to provide an API key or other sorts of single-string authentication. Some people suggest using HTTP Basic Authentication with the API Key as both username and password or just leave the password blank, but really that’s a messy way of doing it if you ask me.

In that case I would recommend simply appending the API key to the query string, e.g. api.geocod.io/v1/geocode?q=42370 Bob Hope Drive, Rancho Mirage CA&api_key=YOUR_API_KEY

Don’t bother adding the API Key as a header or another fancy solution like that. By adding it as a query string parameter, the user will be able to test your API directly in a regular browser without any bells and whistles.

Timestamps

One of the common pitfalls of API design is to make sure you get timestamps right from the beginning. Don’t use Unix Timestamps as they don’t have timezone support and are not human readable (among a lot of other reasons) — Facebook learned this the hard way.

A widely-accepted standard for timestamps is ISO-8601. It is easy to read, easy to parse and it has great timezone support.

Error handling

The last thing on our list is error handling. There’s a lot of different kinds of errors you need to handle in your API, including permission errors (You are not allowed to delete this store), validation errors (Please specify a name for the store), not found errors, or even internal server errors.

You should always return a semantic HTTP status code with your requests. So for example, no errors would be a 200 OK, permission errors could be 403 Forbidden, and validation errors could be 422 Unprocessable Entity (http://httpstatus.es has a great human-readable list of available status codes).

In addition to the status code you, should always return an error message if necessary with a more detailed description of what happened. My favorite way of doing this is simply to respond with an “errors” key that has the error message as the value.

Example:

{
    error: "Invalid API key"
}
Conclusion

You can go in a lot of directions when it comes to API design, and ultimately it’s really up to personal preference. I’ve designed a lot of different APIs for a variety of purposes throughout the years and these are merely some of my favorite best practices. Take the bits you like and throw away the ones you don’t.