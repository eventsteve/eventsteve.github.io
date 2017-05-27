---
layout:     post
title:      Why Cassandra
date:       2016-05-04 12:31:19
summary:    Why Cassandra
category:   nodejs
comments:   True
tags:       nodejs
permalink:  /why-cassandra.html
---

On Tuesday, I had the opportunity of attending Cassandra Day in DC, a one-day conference put on by Datastax.

As an application developer and designer, my role is building applications on top of search technologies like Elasticsearch and Solr. Going into the day my impression was that the big data space which Cassandra inhabits is pretty saturated with competitors that all use nearly identical buzzwords and claims. Being relatively unfamiliar with Cassandra, my main objective was to leave with an answer to the question “What makes Cassandra unique?”

In case you are in the same boat, I wanted to share a few of my takeaways from the talks that I attended.

SO WHAT MAKES CASSANDRA DIFFERENT?

Cassandra is a distributed datastore, with a built-in coordinator. This means that requests are intelligently forwarded to the correct node.

It is generally very fast, and especially shines with write heavy workflows.

It scales linearly. If you double the nodes, you’ll double your throughput.

Embraces eventual consistency.

You can manage the speed versus stability trade offs by setting the consistency levels of your data. Two popular strategies are:

One - The transaction is acknowledged as written when it is added to the commit log and one replica.

Quorum - The data must be written to a quorum (51%) of the replicas before it is acknowledged.

In general, Cassandra uses a last-in wins strategy when there conflicts between two nodes try to write to the same row.

Masterless replication across data centers means that your data is always accessible.

A FEW USE CASES FOR CASSANDRA:

Transactional data such as user data

Fraud detection

Recommendation data

Log data

If you want to add analytics to your data you can either augment the data or use Cassandra as your source of truth for another system, such as Solr or Elasticsearch.

By adding Spark to your stack you add batch and streaming processing to the data in Cassandra

Solr is available as part of DSE. Data is replicated from your Cassandra cluster into a Lucene index. This may be queried directly via HTTP or through Cassandra’s CQL language.

Another point that came up is that while Cassandra is usually touted in relation to big data, it is just as equally qualified to be used with smaller data sets. The distributed nature and great write speeds are just as important when you are dealing with gigabytes of data as they are with petabytes of data. Chris Bradford has demonstrated this on an almost cartoonish scale by building a fully functional Cassandra cluster on a pair of Intel Edisons. Your data needs are probably somewhere in between that and Netflix, but the point still applies.

Overall, the event was a good opportunity to connect with people in the data community and learn about Cassandra. If you’re interested in learning more you might want to check out Planet Cassandra or attend one of the free webinars from Datastax.

I am looking forward to leveraging Cassandra on one of my future projects.

