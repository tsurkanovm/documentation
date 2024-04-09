The Caddy webserver as nginx. has simple json format config. Generates SSL certificates out the box by default
FrankenPHP - analog fastcgi (phpfpm is PHP implementation of it) (Web server interface that solves the performance problems, scripts init)
All PHP scripts die after invoking, all optimizations are work with parallelism, opcache or similar ideas.
FrankenPHP can use workers - that can put general scripts (core functionality. that will use in almost all requests) into a memory. Next request not load and initiate an index.php - works with memory
FrankenPHP can compress all source code into one binary file and it will work as normal site. For small projects with big requests or for many requests. Lavarel and Symfony have impementation.