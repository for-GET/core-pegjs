/*
 * Literate HTTP (curl --trace)
 *
 * Parse output of
 * curl -s --trace - ... 2>&1
 *
 * @append for-get/literate-http.pegjs
 * @append curl/curl-trace.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* OVERRIDE */

litHTTP_fenced_block
  = litHTTP_fenced_transactions litHTTP_markdown

litHTTP_ticks_start
  = litHTTP_ticks "curl-trace"? (!EOL .)*

litHTTP_transaction
  = CURL_TRACE
