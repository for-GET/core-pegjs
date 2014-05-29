/*
 * HTTP transcript
 *
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* SCENARIO */

transcript
  = (OWS EOL)* transcript_header
    (OWS EOL)+ transcript_messages

transcript_header
  = transcript_katt_name_block (&(OWS EOL transcript_katt_description_block) OWS EOL transcript_katt_description_block)?
  / transcript_name

transcript_katt_name_block
  = "---" SP transcript_katt_name SP "---"

transcript_katt_name
  = $(!(RWS "---") .)+

transcript_katt_description_block
  = "---" EOL transcript_katt_description EOL "---"

transcript_katt_description
  = $(!(EOL "---") .)+

transcript_name
  = $(!EOL .)+

/* MESSAGES */

transcript_messages
  = (transcript_message (OWS EOL)*)+

transcript_message
  = transcript_message_description? (OWS EOL)*
    transcript_request
    transcript_response

transcript_message_description
  = !(transcript_request_mark / transcript_known_method) $(!EOL .)+

/* REQUEST */

transcript_request
  = transcript_request_line EOL
    transcript_request_headers
    (EOL transcript_body)?

transcript_request_line
  = transcript_request_mark? method SP $(request_target) (SP $(HTTP_version))?
  / transcript_known_method SP $(request_target) (SP $(HTTP_version))?

/* Assembled from RFC 2616, 5323, 5789. */
transcript_known_method
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

transcript_request_headers
  = transcript_request_header? (EOL transcript_request_header)*

transcript_request_header
  = transcript_request_mark header_field

/* RESPONSE */

transcript_response
  = transcript_response_line EOL
    transcript_response_headers
    (EOL transcript_body)?

transcript_response_line
  = transcript_response_mark ($(HTTP_version) SP)? status_code (SP reason_phrase)?

transcript_response_headers
  = transcript_response_header? (EOL transcript_response_header)*

transcript_response_header
  = transcript_response_mark header_field

/* BODY */

transcript_body
  = transcript_body_line+

transcript_body_line
  = !transcript_response_mark $(!EOL .)+ EOL
  / !((OWS EOL)* transcript_message) $(!EOL .)+ EOL

/* MISC */

transcript_request_mark
  = ">" RWS

transcript_response_mark
  = "<" RWS

EOL
  = CR? LF

/* OVERRIDE */

sub_delims
  = "!"
  / "$"
  / "&"
  / "'"
  / "("
  / ")"
  / "*"
  / "+"
  / ","
  / ";"
  / "="
  / "{"
  / "}"
