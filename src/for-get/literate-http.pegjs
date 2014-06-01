/*
 * Literate HTTP
 *
 * Definitions:
 * - a `.litHTTP` file is a text file that uses "fenced blocks" to mark litHTTP_fenced_blocks
 * - a `.HTTP` file is a text file that contains only litHTTP_transactions
 *
 * Discrepancies from HTTP
 * - allows request_line to skip HTTP_version
 * - allows status_line to skip HTTP_version and/or reason_phrase
 * - allows for headers-body separator to be only one line ending
 * - allows for LF line endings, instead of just CRLF
 * - allows for request_target to be anything but SP and EOL, for special semantics
 *
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

litHTTP
  = (OWS EOL)* litHTTP_transactions
  / litHTTP_markdown litHTTP_fenced_blocks


/* MARKDOWN */

litHTTP_markdown
  = $(!litHTTP_ticks_start .)*

litHTTP_fenced_blocks
  = litHTTP_fenced_block+

litHTTP_fenced_block
  = litHTTP_fenced_transactions litHTTP_markdown
  / litHTTP_fenced_transactions_request litHTTP_markdown litHTTP_fenced_response_transactions litHTTP_markdown

litHTTP_fenced_transactions
  = litHTTP_ticks_start (OWS EOL)+ litHTTP_transactions litHTTP_ticks

litHTTP_fenced_transactions_request
  = litHTTP_ticks_start (OWS EOL)+ litHTTP_transactions? litHTTP_request litHTTP_ticks

litHTTP_fenced_response_transactions
  = litHTTP_ticks_start (OWS EOL)+ litHTTP_response litHTTP_transactions? litHTTP_ticks

litHTTP_ticks_start
  = litHTTP_ticks "http"? (!EOL .)*

litHTTP_ticks
  = "```"


/* TRANSACTIONS */

litHTTP_transactions
  = (litHTTP_transaction (OWS EOL)*)+

litHTTP_transaction
  = litHTTP_request
    litHTTP_response

/* REQUEST */

litHTTP_request
  = litHTTP_request_line
    litHTTP_request_headers
    litHTTP_request_body_separator?
    litHTTP_request_body?

litHTTP_request_line
  = litHTTP_request_line_mark method SP litHTTP_request_target (SP $HTTP_version)? EOL

litHTTP_request_target
  = &request_target $request_target &(SP / EOL)
  / $(!(SP / EOL) .)+

litHTTP_request_headers
  = (litHTTP_request_header EOL)*

litHTTP_request_header
  = litHTTP_request_mark header_field

litHTTP_request_body_separator
  = litHTTP_request_mark EOL

litHTTP_request_body
  = $(litHTTP_request_body_line (EOL litHTTP_request_body_line)*)

litHTTP_request_body_line
  = !litHTTP_request_body_end (!EOL OCTET)+

litHTTP_request_body_end
  = (OWS EOL)* litHTTP_status_line
  / (OWS EOL)* litHTTP_ticks


/* RESPONSE */

litHTTP_response
  = litHTTP_status_line
    litHTTP_response_headers
    litHTTP_response_body_separator?
    litHTTP_response_body?

litHTTP_status_line
  = litHTTP_response_mark ($HTTP_version SP)? status_code (SP reason_phrase)? EOL

litHTTP_response_headers
  = (litHTTP_response_header EOL)*

litHTTP_response_header
  = litHTTP_response_mark header_field

litHTTP_response_body_separator
  = litHTTP_response_mark EOL

litHTTP_response_body
  = $(litHTTP_response_body_line (EOL litHTTP_response_body_line)*)

litHTTP_response_body_line
  = !litHTTP_response_body_end (!EOL OCTET)+

litHTTP_response_body_end
  = (OWS EOL)* litHTTP_request_line
  / (OWS EOL)* litHTTP_ticks


/* MISC */

// NOTE: the empty string match is needed
litHTTP_request_line_mark
  = "" litHTTP_request_mark

litHTTP_request_mark
  = ""

litHTTP_response_mark
  = ""

EOL
  = CR? LF
