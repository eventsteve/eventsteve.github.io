---
layout:     post
title:      How to deloy NodeJS application to heroku
date:       2014-12-10 12:31:19
summary:    How to deloy NodeJS application to heroku
category:   nodejs
comments:   true
tags:       github-pages
permalink:  /how-to-deploy-a-node-js-app-to-heroku.html
---

When creating a new Node project, one of the very first things you’ll do is select your dependencies and devDependencies for your project. When declaring Node dependency version numbers, there are many different ways to specify the version number you want. That’s because Node uses semantic versioning when declaring modules.

Let’s say we’re bringing

expressJS into our project. You can declare that dependency version many ways. Here are a few examples.

4.8.5
>4.8.5
>=4.8.5
~4.8.5
You may have read through some tutorials where they will declare dependencies with some characters and a version number and wonder what exactly does that mean?

<iframe width="480" height="360" src="http://www.youtube.com/embed/WO82PoAczTc" frameborder="0"> </iframe>


| Method | Chrome | Internet Explorer | Firefox | Safari | Opera |
|--------|--------|:-----------------:|---------|--------|-------|
| btoa() | Yes    |        10.0       | 1.0     | Yes    | Yes   |



 our cookbook, each recipe will have a name. So we can begin by
creating a table of recipe names.  Our `recipes` table will be:

| recipe_id |    recipe_name |
| --------- | -------------- |
|         0 |          Tacos |
|         1 |    Tomato Soup |
|         2 | Grilled Cheese |

We associate a unique ID with each recipe so that we can connect
rows in this table to rows in other tables (more on this soon).

Next, we need a table listing all the ingredients.
To make later examples more interesting,
we will also also assume that each ingredient
has a price. Our `ingredients` table is:

| ingredient_id | ingredient_name | ingredient_price |
| ------------- | --------------- | ---------------- |
|             0 |            Beef |                5 |
|             1 |         Lettuce |                1 |
|             2 |        Tomatoes |                2 |
|             3 |      Taco Shell |                2 |
|             4 |          Cheese |                3 |
|             5 |            Milk |                1 |
|             6 |           Bread |                2 |


Name | Lunch order | Spicy      | Owes
------- | ---------------- | ---------- | ---------:
Joan  | saag paneer | medium | $11
Sally  | vindaloo        | mild       | $14
Erin   | lamb madras | HOT      | $5

### Internet Explorer 10 and above

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
