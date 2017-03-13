---
layout:     post
title:      Reporting Database
date:       2014-12-10 12:31:19
summary:    Reporting Database
category:   nodejs
comments:   True
tags:       nodejs
permalink:  /reporting-database.html
---


Most EnterpriseApplications store persistent data with a database. This database supports operational updates of the application's state, and also various reports used for decision support and analysis. The operational needs and the reporting needs are, however, often quite different - with different requirements from a schema and different data access patterns. When this happens it's often a wise idea to separate the reporting needs into a reporting database, which takes a copy of the essential operational data but represents it in a different schema.



--- images ---

<img src="/images/test.jpg" alt="John Otander" class="avatar" />



<a href="https://github.com/eventsteve/eventsteve.github.io/files/36852/Microservices.Design.Patterns.for.Java.Applications.pdf"> download</a>
Such a reporting database is a completely different database to the operational database. It may be a completely different database product, using PolyglotPersistence. It should be designed around the reporting needs.

A reporting database has a number of advantages:
<a href="https://github.com/eventsteve/eventsteve.github.io/files/36852/Microservices.Design.Patterns.for.Java.Applications.pdf"> download</a>
The structure of the reporting database can be specifically designed to make it easier to write reports.
You don't need to normalize a reporting database, because it's read-only. Feel free to duplicate data as much as needed to make queries and reporting easier.
The development team can refactor the operational database without needing to change the reporting database.
Queries run against the reporting database don't add to the load on the operational database.
You can store derived data in the database, making it easier to write reports that use the derived data without having to introduce a separate set of derivation logic.
You may have multiple reporting databases for different reporting needs.
The downside to a reporting database is that its data has to be kept up to date. The easiest case is when you do something like use an overnight run to populate the reporting database. This often works quite well since many reporting needs work perfectly well with yesterday's data. If you need more timely data you can use a messaging system so that any changes to the operational database are forwarded to the reporting database. This is more complicated, but the data can be kept fresher. Often most reports can use slightly stale data and you can produce special case reports for things that really need to have this second's data [1].

A variation on this is to use views. This encapsulates the operational data and allows you to denormalize. It doesn't allow you to separate the operational load from the reporting load. More seriously you are limited to what views can derive and you can't take advantage of derivations that are written in an in-memory programming environment.

A reporting database fits well when you have a lot of domain logic in a domain model or other in-memory code. The domain logic can be used to process updates to the operational data, but also to calculate derived data which to enrich the reporting database.
