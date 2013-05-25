/*
 * HTTPbis P1
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging
 *
 * @append RFC/3986_uri
 * @append RFC/5324_abnf
 */

/* 2.6.  Protocol Versioning */
HTTP_version
  = HTTP_name "/" major:[0-9] "." minor:[0-9]
  { return {
    major: major,
    minor: minor
  } }

HTTP_name
  = \x48 \x54 \x54 \x50


/* 2.7.  Uniform Resource Identifiers */
// FIXME

http_URI
  = "http:" "//" authority path_abempty ("?" query)?

https_URI
  = "https:" "//" authority path_abempty ("?" query)?


/* 3.  Message Format */
HTTP-message
  = start_line
    (header_field CRLF)*
    CRLF
    message_body?


/* 3.1.  Start Line */
start_line
  = request_line
  / status_line


/* 3.1.1.  Request Line */
request_line
  = method:method SP request_target:request_target SP HTTP_version:HTTP_version CRLF
  { return {
    method: method,
    request_target: request_target,
    HTTP_version: HTTP_version
  } }

method
  = token


/* 3.1.2.  Status Line */
status_line
  = HTTP_version:HTTP_version SP status_code:status_code SP reason_phrase:reason_phrase CRLF
  { return {
    HTTP_version: HTTP_version,
    status_code: status_code,
    reason_phrase: reason_phrase
  } }

status_code
  = status_code:(DIGIT DIGIT DIGIT)
  { return status_code.join(""); }

reason_phrase
  = reason_phrase:( HTAB
    / SP
    / VCHAR
    / obs_text
    )*
  { return reason_phrase.join(""); }


/* 3.2.  Header Fields */
header_field
  = field_name ":" OWS field_value BWS

field_name
  = token

field_value
  = (field_content / obs_fold)*

field_content
  = ( HTAB
    / SP
    / VCHAR
    / obs_text
    )*

obs_fold
  // obsolete line folding
  = CRLF (SP / HTAB)


/* 3.2.3.  Whitespace */
OWS
  // optional whitespace
  = ( SP
    / HTAB
    )*

RWS
  // required whitespace
  = ( SP
    / HTAB
    )+

BWS
  // "bad" whitespace
  = OWS


/* 3.2.6.  Field value components */
word
  = token
  / quoted_string

token
  = tchar+

tchar
  // any VCHAR, except special
  = "!"
  / "#"
  / "$"
  / "%"
  / "&"
  / "'"
  / "*"
  / "+"
  / "-"
  / "."
  / "^"
  / "_"
  / "`"
  / "|"
  / "~"
  / DIGIT
  / ALPHA

special
  = "("
  / ")"
  / "<"
  / ">"
  / "@"
  / ","
  / ";"
  / ":"
  / "\"
  / DQUOTE
  / "/"
  / "["
  / "]"
  / "?"
  / "="
  / "{"
  / "}"

quoted_string
  = DQUOTE (qdtext /quoted_pair)* DQUOTE

qdtext
  = HTAB
  / SP
  / \x21
  / [\x23-\x5B]
  / [\x5D-\x7E]
  / obs-text

obs_text
  = [\x80-\xFF]

quoted_pair
  = "\" (HTAB / SP / VCHAR / obs-text)

comment
  = "(" (ctext / quoted_cpair / comment)* ")"

ctext
  = HTAB
  / SP
  / [\x21-\x27]
  / [\x2A-\x5B]
  / [\x5D-\x7E]
  / obs_text

quoted_cpair
  = "\" (HTAB / SP / VCHAR / obs_text)


/* 3.3.  Message Body */
message_body
  = OCTET*


/* 3.3.1.  Transfer-Encoding */
transfer_encoding
  = ("," OWS)* transfer_coding (OWS "," (OWS transfer_coding)?)*


/* 3.3.2.  Content-Length */
content_length
  = DIGIT+


/* 4.  Transfer Codings */
transfer_coding
  = "chunked"i
  / "compress"i
  / "deflate"i
  / "gzip"i
  / transfer_extension

transfer_extension
  = token (OWS ";" OWS transfer_parameter)*

transfer_parameter
  = attribute BWS "=" BWS value

attribute
  = token

value
  = word


/* 4.1.  Chunked Transfer Coding */
// FIXME


/* 4.1.1.  Trailer */
// FIXME


/* 4.2.  Compression Codings */
// FIXME


/* 4.3.  TE */
// FIXME


/* 5.3.  Request Target */
request_target
  = origin_form
  / absolute_form
  / authority_form
  / asterisk_form

origin_form
  = absolute_path ("?" query)?

absolute_form
  = absolute_URI

authority_form
  = authority

asterisk-form
  = "*"


/* 5.4.  Host */
host
  = uri_host (":" port)?


/* 5.7.1.  Via */
// FIXME


/* 6.1.  Connection */
// FIXME


/* 6.7.  Upgrade */
// FIXME


/* Appendix B.  ABNF list extension: #rule */
/*
In ABNF
1#element => element *( OWS "," OWS element )
#element => [ 1#element ]
<n>#<m>element => element <n-1>*<m-1>( OWS "," OWS element )

Accept empty elements
#element => [ ( "," / element ) *( OWS "," [ OWS element ] ) ]
1#element => *( "," OWS ) element *( OWS "," [ OWS element ] )

In PEGjs
#element => (("," / element) (OWS "," (OWS element)?)*)?
1#element => ("," OWS)* element (OWS "," (OWS element)?)*
*/
