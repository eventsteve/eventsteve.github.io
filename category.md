---
layout: page
title:
permalink: /category/
---

<div class="py2 post-footer">
{% for tag in site.categories %} 
  <h2 id="{{ tag[0] }}">{{ tag[0] | capitalize }}</h2>

    {% assign pages_list = tag[1] %}  

    {% for post in pages_list %}
      {% if post.title != null %}
		  
		  <li><a href="{{ site.url }}{{ post.url }}"> {{ post.title }} </a> on <time datetime="{{ post.date | date_to_xmlschema }}" itemprop="datePublished">{{ post.date | date: "%B %d, %Y" }}</time></li>

      	<!-- {% if group == null or group == post.group %}
      		<li>@LI@<a href="{{ site.url }}{{ post.url }}">{{ post.title }}<span class="entry-date"><time datetime="{{ post.date | date_to_xmlschema }}" itemprop="datePublished">{{ post.date | date: "%B %d, %Y" }}</time></a></li>
      	{% endif %} -->

      {% endif %}
    {% endfor %}
    
    {% assign pages_list = nil %}
    {% assign group = nil %}

{% endfor %}

</div>