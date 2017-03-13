The short answer is yes. However, before you start hyperventilating about the cost of all those extra Oracle licenses, lets first explore why it is essential to do this and then discuss what is meant by the term ‘database’.

The main benefit of the microservice architecture is that it dramatically improves agility and velocity. That’s because when you  correctly decompose a system into microservices, you can develop and deploy each microservice independently and in parallel with the other services. In order to be able to independently develop microservices , they must be loosely coupled. Each microservice’s persistent data must be private to that service and only accessible via it’s API . If two or more microservices were to share persistent data then you need to carefully coordinate changes to the data’s schema, which would slow down development.

There are a few different ways to keep a service’s persistent data private. You do not need to provision a database server for each service. For example,  if you are using a relational database then the options are:

Private-tables-per-service – each service owns a set of tables that must only be accessed by that service
Schema-per-service – each service has a database schema that’s private to that service
Database-server-per-service – each service has it’s own database server.
Private-tables-per-service and schema-per-service have the lowest overhead.  Using a schema per service is appealing since it makes ownership clearer. For some applications, it might make sense for database intensive services to have their own database server.

It is a good idea to create barriers that enforce this modularity. You could, for example, assign a different database user id to each service and use a database access control mechanism such as grants. Without some kind of barrier to enforce encapsulation, developers will always be tempted to bypass a service’s API and access it’s data directly.

It might also make sense to have a polyglot persistence architecture. For each service you choose the type of database that is best suited to that service’s requirements. For example, a service that does text searches could use ElasticSearch. A service that manipulates a social graph could use Neo4j. It might not make sense to use a relational database for every service.

There are some downsides to keeping a service’s persistent data private. Most notably, it can be challenging to implement business transactions that update data owned by multiple services. Rather than using distributed transaction, you typically must use an eventually consistent, event-driven approach to maintain database consistency.

Another problem, is that it is difficult to implement some queries because you can’t do database joins across the data owned by multiple services. Sometimes, you can join the data within a service. In other situations, you will need to use Command Query Responsibility Segregation (CQRS) and maintain denormalizes views.

Another challenge is that  services sometimes need to share data. For example, let’s imagine that several services need access to user profile data. One option is to encapsulate the user profile data with a service, that’s then called by other services. Another option is to use an event-driven mechanism to replicate data to each service that needs it.

In summary,  it is important that each service’s persistent data is private. There are, however,  a few different ways to accomplish this such as a schema-per-service. Some applications benefit from a polyglot persistence architecture that uses a mixture of database types.  A downside of not sharing databases is that maintaining data consistency and implementing queries is more challenging.