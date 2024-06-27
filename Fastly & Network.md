- Fastly it is fork from the Varnish
- Fastly it is a proxy servers (can be in few continents) between client and original server. It cached CDN. Forward to origin server only if page or some content not yet cached.
- Fastly cashed only GET and HEAD requests
- Fastly, Varnish grace period (header "state_while_revalidate") - time that F will return old content (TTL is end up) and meanwhile get new version. New content will retuns ASAP but less than grace period.
- VLC - procedural program language for cash manipulating

- Mac address (id) - is unique on whole world - your PC (network card) has unique id
- IP address - unique id of network node (~1000 PCs)
- TCP protocol - has port - unique ID of service (or program) for whom this request. It assured that request will be access by client. Uses in web. 
- UDP -protocol similar to TCP but not assured reception. Uses for streemings and other content where needs to be fast but not accurate.
- - 127.0.0.1:3386 - TCP?IP address
- UDS - similar to TCP - unix protocol - use file for communication. Can be use in configurations or CLI. Like 'uds=\var\run\varnish.sock' 

- Fiddler - software setup automatically configured in Ubuntu proxy local server. And you can manipulate all browser`s request and response. Set delays, change headers. For example set "host" as staging and you will get response as for staging (Nosto or other app that required remote host)
- By Fiddler you can set your own request from API that not ready yet for development
- Fiddler can intercept curl and Postman requests (needs additional settings)
