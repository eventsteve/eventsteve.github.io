
https://github.com/cer/event-sourcing-examples/wiki/WhyEventSourcing

For slides and videos about building microservices using event sourcing and CQRS please see Building and deploying microservices with event sourcing, CQRS and Docker.

About event sourcing
As described earlier, event sourcing simplifies the development of event-driven applications. The key idea in event sourcing is that rather than persist the current state of a business entity, a service persists the entity’s state changing events. For example, the state-changing events for a bank account include AccountOpened, AccountDebited, and AccountCredited. When a service recreates an entity’s current state it simply replays the events.



About the event store

The application persists events in an event store. The event store behaves like both an database and a message broker. It's like a database since the application persists and retrieves events for an entity by primary key. The event store also behaves like a message broker since it publishes newly persisted events to interested consumers.

Benefits of event sourcing

Event sourcing has several benefits. It’s a great way to implement an event-driven system because when a service persists a new event in the event store, that event is simultaneously published. You don’t need to implement a mechanism to atomically update state and publish an event. Another benefit of event sourcing is that the events published by a system are an accurate audit log of all user updates. You no longer need to sprinkle error-prone auditing logging code throughout your business logic. Event sourcing also eliminates the O/R mapping problem since events are trivial to persist.

About Command Query Responsibility Separation (CQRS)
Event sourcing is great but for most applications it’s insufficient. That’s because an event store only supports the retrieval of events by an entity’s primary key. In order to implement more complex queries that do joins, such as those typically required by the UI, you need to use another pattern called Command-Query-Responsibility-Separation (CQRS). CQRS separates query processing from command processing, which updates entities using business logic that's implemented using event sourcing. The follow diagram shows the structure of a system that uses CQRS:



The query side consumes the events published by the command side when it updates aggregates and updates views. The views are designed specifically to support queries and often implemented using NoSQL databases. For example, one service might use a Neo4J –based view to handle queries about a social graph and another service might implement text search using ElasticSearch.

In addition to addressing the limitations of event sourcing, CQRS has other benefits. The separation of concerns means that you no longer implement a single model that handles both updates and queries. Instead, you have two narrowly focused models, one for updates and another for queries. In addition, CQRS let’s you scale the command side separately from the query side. This is especially relevant since many applications are very read intensive. This pattern also improves performance and scalability because the query side can use (denormalized) views that optimized for specific queries.

