# Search for the masses

Search is the touchstone of the Internet; without it, the Internet wouldn’t be all that useful. But search hasn’t always been that easy nor affordable to implement. That's where Elasticsearch shines. Elasticsearch adds not only a simple API for adding and searching content, but does it in a distributed manner. With infinitesimal arm grease, you can set up a search cluster that smears your data and resultant queries across a series of nodes. Not only is this resultant architecture fast, but it’s easy to set up and extremely affordable as search nodes can run on commodity hardware. 

Using this repository, I'll show you how to get up and running with Elasticsearch. You'll learn how to create a cluster, how to index and search documents via its RESTful API and how to use a few handy client libraries. You'll be bringing search to the masses in no time!

## So what's the big idea?

When I was in high school, google was just a noun representing an incredibly large number. Today, we sometimes use google as a verb synonymous with online browsing and searching, and we also use it to refer to the eponymous company. It is common to invoke Google as an answer for almost any question: "Just google it!" It follows that application users expect to be able to search the data (files, logs, articles, images, and so on) that an application stores. For software developers, the challenge is to enable search functionality quickly and easily, without losing too much sleep, or cash, to do it.

User queries are becoming more complex and personalized over time, and much of the data required to deliver an appropriate response is inherently unstructured. Where once an `SQL LIKE` clause was good enough, today's usage sometimes calls for sophisticated algorithms. Fortunately, a number of open source and commercial platforms address the need for pluggable search technology, including Lucene, Sphinx, Solr, Amazon's CloudSearch, and Xapian. 

### Enter Elasticsearch

Elasticsearch is one of a number of open source search platforms. Its service is to offer an additional component (a searchable repository) to an application that already has a database and web front-end. Elasticsearch provides the search algorithms and related infrastructure for your application. You simply upload application data into the Elasticsearch datastore and interact with it via RESTful URLs. You can do this either directly or indirectly via a library like cURL or a client library, like Jest for Java.

The architecture of Elasticsearch is distinctly different from its predecessors in that it is expressly built with horizontal scaling in mind. Unlike some other search platforms, Elasticsearch is designed to be distributed. This feature dovetails quite nicely with the rise of cloud and big data technologies. Elasticsearch is built on top of one of the more stable open source search engines, Lucene, and it works similarly to a schema-less JSON document datastore. Its singular purpose is to enable text-based searching.



### Installing Elasticsearch

Elasticsearch is easy to install.

## Helpful Resources

  * [The Disco Blog](http://thediscoblog.com/)
    * [Javascript](http://thediscoblog.com/blog/categories/javascript/)
    * [Node](http://thediscoblog.com/blog/categories/node/)
    * [Mobile](http://thediscoblog.com/blog/categories/mobile/)
    * [HTML5](http://thediscoblog.com/blog/categories/html5/)
    * [CoffeeScript](http://thediscoblog.com/blog/categories/coffeescript/)
    * [jQuery Mobile](http://thediscoblog.com/blog/categories/jquery-mobile/)


## License

<a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US"><img alt="Creative Commons License" style="border-width:0" src="http://i.creativecommons.org/l/by-sa/3.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/3.0/deed.en_US">Creative Commons Attribution-ShareAlike 3.0 Unported License</a>.    
