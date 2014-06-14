/*
 * Literate HTTP (Apiary blueprint)
 *
 * Parse output of Apiary's original blueprint format
 *
 * @append for-get/literate-http.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* OVERRIDE */

litHTTP
  =  ((OWS EOL)* "---" !litHTTP_apib_request_line .)* litHTTP_transactions
  / litHTTP_markdown litHTTP_fenced_blocks

litHTTP_ticks_start
  = litHTTP_ticks "apib"? (!EOL .)*

litHTTP_request_body_separator
  = ""

litHTTP_response_body_separator
  = ""

litHTTP_response_body_end
  = EOL EOL
  / (OWS EOL)* litHTTP_ticks

litHTTP_request_line_mark
  = ""

litHTTP_request_mark
  = ">" OWS

litHTTP_response_mark
  = "<" OWS

litHTTP_apib_request_line
  = litHTTP_request_line_mark litHTTP_apib_method SP litHTTP_request_target (SP HTTP_version)? EOL

litHTTP_apib_method
  = "GET"
  / "POST"
  / "PUT"
  / "DELETE"
  / "OPTIONS"
  / "PATCH"
  / "PROPPATCH"
  / "LOCK"
  / "UNLOCK"
  / "COPY"
  / "MOVE"
  / "MKCOL"
  / "HEAD"

