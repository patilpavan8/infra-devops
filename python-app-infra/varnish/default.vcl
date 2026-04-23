vcl 4.0;

backend default {
  .host = "lamp-service";
  .port = "80";
}

sub vcl_backend_response {
  if (bereq.url ~ "/api/v1/lamps") {
    set beresp.ttl = 60s;
  }
}

sub vcl_recv {
  if (req.method != "GET") {
    return (pass);
  }
}
