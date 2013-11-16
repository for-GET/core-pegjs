/*
 * HTTPbis P1
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging
 *
 * Limitations & cleanup
 * - <uri_host> element has been renamed to <hostname> as a dirty workaround for
 * element being re_defined with another meaning in RFC/3986_uri
 * - ignoring obsolete rules obs_*`
 *
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-2.6 Protocol Versioning */
HTTP_version
  = HTTP_name "/" DIGIT "." DIGIT

HTTP_name
  = "HTTP"


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-2.7 Uniform Resource Identifiers */
absolute_path
  = ("/" segment)+

partial_URI
  = relative_part ("?" query)?

http_URI
  = "http:" "//" authority path_abempty ("?" query)? ("#" fragment)?

https_URI
  = "https:" "//" authority path_abempty ("?" query)? ("#" fragment)?


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3 Message Format */
HTTP_message
  = start_line
    (header_field CRLF)*
    CRLF
    message_body?


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.1 Start Line */
start_line
  = request_line
  / status_line


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.1.1 Request Line */
request_line
  = method SP $(request_target) SP $(HTTP_version) CRLF

method
  = token


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.1.2 Status Line */
status_line
  = $(HTTP_version) SP status_code SP reason_phrase CRLF

status_code
  = $(DIGIT DIGIT DIGIT)

reason_phrase
  = $( HTAB
     / SP
     / VCHAR
     /*
     // CHANGE Ignore obsolete
     / obs_text
     */
     )*


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.2 Header Fields */
header_field
  = field_name ":" OWS field_value BWS

field_name
  = token

field_value
  = field_content
  /*
  // CHANGE Ignore obsolete
  = $( field_content
     / obs_fold
     )*
  */

field_content
  = $( HTAB
     / SP
     / VCHAR
     /*
     // CHANGE Ignore obsolete
     / obs_text
     */
     )*

/*
// CHANGE Ignore obsolete
obs_fold
  // obsolete line folding
  = $(CRLF (SP / HTAB))
*/


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.2.3 Whitespace */
OWS
  // optional whitespace
  = $( SP
     / HTAB
     )*

RWS
  // required whitespace
  = $( SP
     / HTAB
     )+

BWS
  // "bad" whitespace
  = OWS


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.2.6 Field value components */
word
  = token
  / quoted_string

token
  = $(tchar+)

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
  / "\\"
  / DQUOTE
  / "/"
  / "["
  / "]"
  / "?"
  / "="
  / "{"
  / "}"

quoted_string
  = DQUOTE $(qdtext / quoted_pair)* DQUOTE

qdtext
  = HTAB
  / SP
  / "\x21"
  / [\x23-\x5B]
  / [\x5D-\x7E]
  /*
  // CHANGE Ignore obsolete
  / obs_text
  */

/*
// CHANGE Ignore obsolete
obs_text
  = [\x80-\xFF]
*/

quoted_pair
  = "\\"
    ( HTAB
    / SP
    / VCHAR
    /*
    // CHANGE Ignore obsolete
    / obs_text
    */
    )

comment
  = "(" $(ctext / quoted_cpair / comment)* ")"

ctext
  = HTAB
  / SP
  / [\x21-\x27]
  / [\x2A-\x5B]
  / [\x5D-\x7E]
  /*
  // CHANGE Ignore obsolete
  / obs_text
  */

quoted_cpair
  = "\\"
    ( HTAB
    / SP
    / VCHAR
    /*
    // CHANGE Ignore obsolete
    / obs_text
    */
    )


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.3 Message Body */
message_body
  = $(OCTET*)


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.3.1 Transfer_Encoding */
Transfer_Encoding
  = ("," OWS)* transfer_coding (OWS "," (OWS transfer_coding)?)*


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-3.3.2 Content_Length */
content_length
  = $(DIGIT+)


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-4 Transfer Codings */
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


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-4.1 Chunked Transfer Coding */
chunked_body
  = chunk*
    last_chunk
    trailer_part
    CRLF

chunk
  = chunk_size chunk_ext? CRLF
    chunk_data CRLF

chunk_size
  = $(HEXDIG+)

last_chunk
  = "0"+ chunk_ext? CRLF

chunk_ext
  = (";" chunk_ext_name ("=" chunk_ext_val)?)*

chunk_ext_name
  = token

chunk_ext_val
  = token
  / quoted_str_nf

chunk_data
  // a sequence of chunk_size octets
  = $(OCTET+)

trailer_part
  = (header_field CRLF)*

quoted_str_nf
  // like quoted_string, but disallowing line folding
  = DQUOTE $(qdtext_nf / quoted_pair)* DQUOTE

qdtext_nf
  = HTAB
  / SP
  / "\x21"
  / [\x23-\x5B]
  / [\x5D-\x7E]
  /*
  // CHANGE Ignore obsolete
  / obs_text
  */


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-4.1.1 Trailer */
Trailer = ("," OWS)* field_name (OWS "," (OWS field_name)?)*


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-4.3 TE */
TE
  = (("," / t_codings) (OWS "," (OWS t_codings)?)*)?

t_codings
  = "trailers"
  / transfer_coding t_ranking?

t_ranking
  = OWS ";" OWS "q=" rank

rank
  = $( "0" ("." DIGIT? DIGIT? DIGIT?)?
     / "1" ("." "0"? "0"? "0"?)?
     )


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-5.3 Request Target */
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

asterisk_form
  = "*"


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-5.4 Host */
// CHANGE uri_host to hostname
Host
  = hostname (":" port)?


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-5.7.1 Via */
Via
  = ("," OWS)* Via_item_ (OWS "," (OWS Via_item_)?)*

Via_item_
  = received_protocol RWS received_by (RWS comment)?

received_protocol
  = (protocol_name "/")? protocol_version

// CHANGE uri_host to hostname
received_by
  = hostname (":" port)?
  / pseudonym

pseudonym
  = token


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-6.1 Connection */
Connection
  = ("," OWS)* connection_option (OWS "," (OWS connection_option)?)*

connection_option
  = token


/* http://tools.ietf.org/html/draft-ietf-httpbis-p1-messaging#section-6.7 Upgrade */
Upgrade
  = ("," OWS)* protocol (OWS "," (OWS protocol)?)*

protocol
  = protocol_name ("/" protocol_version)?

protocol_name
  = token

protocol_version
  = token


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
