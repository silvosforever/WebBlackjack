# Week 3 Quiz

1. What is HTML? What is CSS? What is Javascript?

  HTML is Hyper-Text Markup Language. It's the "stuff" that makes up web pages. CSS is Cascading Style Sheets. It's a way of styling HTML in an external file instead of inline. Javascript is a language that's used to create interactive effects in web browsers (we didn't use it for this example).

2. What are the major parts of an HTTP request?

  The main parts of an HTTP request are: Method (such as GET or POST), URI (a web address, or some other resource location), Header Fields, Body (the payload).

3. What are the major parts of an HTTP response?

  The main parts of an HTTP response are: Status Code (such as 404 file not found), Response Headers, Body.

4. How do you submit an HTTP POST request, with a "username" attribute set to "bob"? What if we wanted a GET request instead?

  For a POST request, parameters are sent in the request body (as key-value pairs), in the format the content type specifies.

  For a GET request, parameters are sent as a query string. For example, the URL would look like: http://example.com/page?username=bob

5. Why is it important for us, as web developers, to understand that HTTP is a "stateless" protocol?

  It is important because instance variables are wiped out between requests. This means that we have to create clever ways of maintaining state information beyond the HTTP protocol. This can be accomplished by storing items in the session (as cookies) or to databases (and other permanent storage).

6. If the internet is just HTTP requests/responses, why do we only use browsers to interface with web applications? Are there any other options?

  There are other options. Servers can communicate directly to each other without any user-interface at all, for example. You can issue HTTP requests via command line in some enviornments. There are also utility apps and extentions (such as POSTMAN) that let you send requests directly. Browsers are used by people because they do a good job at making the web pages presentable (instead of a jumbled mess of markup).

7. What is MVC, and why is it important?

  Marvel vs. Capcom.......kidding! Here it means Model-View-Controller and it is the software pattern Rails uses for implementing user interfaces for web-based software. It is important because it lets us separate the internal representations of information from the way we present or accept that information from a user.

## Questions about Sinatra

1. At a high level, how are requests processed?

  Sinatra listens to HTTP requests on a port, and then maps those incoming requests to a route method in a ruby file. At that point the ruby code has control of execution and can store things in the session, perform calculations, display views, or redirect to other routes.

2. In the controller/action, what's the difference between rendering and redirecting?

  Rendering displays a view right there. You can customize that view using instance variables or parameters. The URL remains the same. Redirecting actually calls to a different route method, which can then do more processing or render a view itself. Redirects are GET requests, and the URL will be updated to the new route.

3. In the ERB view template, how do you show dynamic content?

  You can use <% %> and <%= %> tags to execute ruby code inside of HTML. This code has access to instance variables and session items, which are the sources for dynamic content.

4. Given what you know about ERB templates, when do you suppose the ERB template is turned into HTML?

  My guess is that the erb method of Sinatra returns the rendered HTML of a particular partial (with dynamic data possible). And that rendered HTML in our example is inside of another HTML template (layout.erb).

5. What's the role of instance variables in Sinatra?

  Instance variables are pieces of information that are accessible by helper methods and views (which can also access helper methods). They help to deliver dynamic data that we don't want to keep around in the session or a database.
