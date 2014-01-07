# Search for the masses

Search is the touchstone of the Internet; without it, the Internet wouldn’t be all that useful. But search hasn’t always been that easy nor affordable to implement. That's where Elasticsearch shines. Elasticsearch adds not only a simple API for adding and searching content, but does it in a distributed manner. With infinitesimal arm grease, you can set up a search cluster that smears your data and resultant queries across a series of nodes. Not only is this resultant architecture fast, but it’s easy to set up and extremely affordable as search nodes can run on commodity hardware. 

Using this repository, I'll show you how to get up and running with Elasticsearch. You'll learn how to create a cluster, how to index and search documents via its RESTful API and how to use a few handy client libraries. You'll be bringing search to the masses in no time!

## So what's the big idea?

When I was in high school, google was just a noun representing an incredibly large number. Today, we sometimes use google as a verb synonymous with online browsing and searching, and we also use it to refer to the eponymous company. It is common to invoke Google as an answer for almost any question: "Just google it!" It follows that application users expect to be able to search the data (files, logs, articles, images, and so on) that an application stores. For software developers, the challenge is to enable search functionality quickly and easily, without losing too much sleep, or cash, to do it.

User queries are becoming more complex and personalized over time, and much of the data required to deliver an appropriate response is inherently unstructured. Where once an `SQL LIKE` clause was good enough, today's usage sometimes calls for sophisticated algorithms. Fortunately, a number of open source and commercial platforms address the need for pluggable search technology, including Lucene, Sphinx, Solr, Amazon's CloudSearch, and Xapian. 

## Enter Elasticsearch

"ElasticSearch is a distributed, RESTful, free/open source search server based on Apache Lucene."


[Elasticsearch](http://www.elasticsearch.org/) is one of a number of open source search platforms. Its service is to offer an additional component (a searchable repository) to an application that already has a database and web front-end. Elasticsearch provides the search algorithms and related infrastructure for your application. You simply upload application data into the Elasticsearch datastore and interact with it via RESTful URLs. You can do this either directly or indirectly via a library like cURL or a client library, like Jest for Java.

The architecture of Elasticsearch is distinctly different from its predecessors in that it is expressly built with horizontal scaling in mind. Unlike some other search platforms, Elasticsearch is designed to be distributed. This feature dovetails quite nicely with the rise of cloud and big data technologies. Elasticsearch is built on top of one of the more stable open source search engines, Lucene, and it works similarly to a schema-less JSON document datastore. Its singular purpose is to enable text-based searching.

> "ElasticSearch is a distributed, RESTful, free/open source search server based on Apache Lucene."

Finally, Elasticsearch is written in Java so it requires you have a JVM, healthy memory and enough space to index documents. Basically think of it as you would a database where I/O is fundamentally important. 

For more information, see:

  * [The Democratization of Search](http://thediscoblog.com/blog/2013/05/14/the-democratization-of-search/)
  * [Java development 2.0: Scalable searching with ElasticSearch](http://www.ibm.com/developerworks/java/library/j-javadev2-24/index.html?ca=drs-)

### Installing Elasticsearch

Elasticsearch is easy to install. And you have a few options ranging from installing the Elasticsearch binary locally on your computer to [running Elasticsearch in AWS](http://thediscoblog.com/blog/2013/05/17/elasticsearch-on-ec2-in-less-than-60-seconds/) to firing up a [Vagrant box already running Elasticsearch](http://thediscoblog.com/blog/2013/11/25/elasticsearch-in-a-box/). 

The simplest installation, which assumes you have access to a terminal (i.e. you are on a Linux or OSX machine), is to download the binary, unzip it, change directories into the install directory and type:

``` 
> bin/elasticsearch -f
```

Boom, you are done!

#### Elasticsearch-in-a-box

Running Elasticsearch locally is easy, but I like to keep my local machine slim and instead rely on VMs. Accordingly, if you are familiar with Vagrant, then you can download [Elasticsearch-in-a-box](https://github.com/aglover/coffer), which is a freely available Vagrant base box. Here are the required steps:

First, add the Elasticsearch-in-a-box box definition:

```
> vagrant box add esinabox https://s3.amazonaws.com/coffers/esinabox.box
```

Then initialize it (you can provide any name you'd like):

```
> vagrant init 'esinabox'
```

Finally, fire it up!

```
> vagrant up
```

Now Elasticsearch is up and running!

For more information, see:

  * [ElasticSearch on EC2 in Less Than 60 Seconds](http://thediscoblog.com/blog/2013/05/17/elasticsearch-on-ec2-in-less-than-60-seconds/)
  * [Elasticsearch in a Box](http://thediscoblog.com/blog/2013/11/25/elasticsearch-in-a-box/)

### Clustering out-of-the-box

[ElasticSearch supports clustering](http://thediscoblog.com/blog/2013/09/03/effortless-elasticsearch-clustering/); that is, you can have a series of distinct ElasticSearch instances work in a coordinated manner without much administrative intervention at all. Clustering ElasticSearch instances (or nodes) provides data redundancy as well as data availability.

Best of all, clustering in ElasticSearch, by default, doesn't require any configuration -- nodes discover each other. To see this in action, it's easiest to run multiple Elasticsearch instances locally. For instance, take the Elasticsearch binary from [elasticsearch.com](http://www.elasticsearch.org/) and copy it into 3 different directories; for example, I've called my directories `node-1`, `node-2`, and `node-3`. 

Open up three terminal windows and start the first one, `node-1`, using the command:

``` 
> bin/elasticsearch -f
```

You should see some output in the terminal window regarding `cluster.service` stating that this instance is the new master. 

Next, fire up the other two nodes (`node-2` & `node-3`) one by one using the same `elasticsearch` command. You should see the two new nodes discover `node-1` in log statements labeled as `detected_master`. 

In fact, to verify your cluster is working correctly, open up a 4th terminal window and type the following command:

```
curl -XGET 'http://localhost:9200/_cluster/nodes?pretty=true'
```

You should see a JSON response listing 3 Elasticsearch nodes in your cluster. 

Just for fun, Ctrl+C one of your nodes (`node-1` is a fun one!) and watch the log outputs -- you should see the cluster notice one node missing and if you happened to kill the master, you'll see a new master elected! Not bad, eh?

For more information, see:

  * [Effortless ElasticSearch Clustering](http://thediscoblog.com/blog/2013/09/03/effortless-elasticsearch-clustering/)

### Elasticsearch terminology

Before I get to the Elasticsearch API, it's helpful to understand a few concepts related to search technology. 

An _index_ is basically a database or schema. A _type_ is essentially a database table. And finally, the process of _indexing_ is inserting documents into an index. In that way, you can think of Elasticsearch as a database; what's more, layer on top of that analogy RESTful concepts and you can quickly see the following relationships: 

  * Indexing (or inserting) documents is done via an HTTP PUT
  * Searching (or selecting) documents is done via an HTTP GET
  * Updating indexes or types or documents is done via HTTP PUT
  * Deleting is done via HTTP DELETE

In that way, you can interact with Elasticsearch via HTTP with tools like cURL and in fact, this is how I recommend you first become familiar with Elasticsearch. All client libraries use Elasticsearch's HTTP API under the covers so understanding the base API is rather important.


## Helpful Resources

  * [The Disco Blog](http://thediscoblog.com/)
    * [All Elasticsearch articles](http://thediscoblog.com/blog/categories/elasticsearch/)
  * [Java development 2.0: Scalable searching with ElasticSearch](http://www.ibm.com/developerworks/java/library/j-javadev2-24/index.html?ca=drs-)
  * [elasticsearch.org](http://www.elasticsearch.org/)


## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.    
