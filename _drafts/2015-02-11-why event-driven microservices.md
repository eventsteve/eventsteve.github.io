Why event-driven microservices?
Cloud native applications typically have a microservices architecture that decomposes the application into a collection of services, each with their own SQL or NoSQL database. Functionally decomposing the database infrastructure creates distributed data management challenges, which are best addressed by using an event-driven architecture. However, implementing an event-driven architecture has its own set of challenges, for which event sourcing is a great solution. Read on to understand the problems that an event-driven solves and why event sourcing can help.

Traditional applications vs cloud native applications
Traditional web applications typically have a monolithic architecture consisting of, for example a single WAR file, and use a single relational database. Monolithic applications are simple to develop, test and deploy. However, this architecture does not scale to deal with application complexity, high transaction and data volumes, and large team sizes. You are also usually locked into the technology choices that you made at the start of the project.

In contrast, a modern cloud native application has a very different architecture. It has the microservices architecture and consists of multiple, collaborating services. Each service has its own database and different services might use a different kind of database, one that is best suited for its deal. For example, a database dealing with social data could use a graph database, where as a service storing complex data structures might use a document database. The so called polyglot persistence approach.

Distributed data management challenges
Developing a cloud native application that uses multiple databases will typically require you to tackle various distributed data management challenges. You need to implement business transactions that update entities that are now in different databases. You also need to synchronize replicas of different databases. In a traditional application you could use two phase-commit (2PC) but that is no longer an option for modern, cloud-native applications.

Event-driven architecture
A good way to solve these distributed data management challenges is by using an event-driven architecture. In an event-driven application services publish and consume events. A service publishes an event whenever it changes the state of an entity. Another service can subscribe to that event and update its own entities and possibly publish other events. You can implement a business transaction that updates multiple entities as a series of steps, each of which updates one entity and publishes an event that triggers the next step. Also, a service can maintain the consistency of a replica by subscribing to the events that are published when the master copy is updated.

EDA implementation challenges
One essential requirement in an EDA is the ability to atomically update state and publish events. In a traditional application the database storing the state and the message broker could participate in a distributed transactions. But the lack of 2PC in a cloud native world makes this a challenging problem to solve. And that’s where event sourcing comes in.
