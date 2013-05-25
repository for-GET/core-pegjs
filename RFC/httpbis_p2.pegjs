/*
 * HTTP P2
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics
 *
 * @append RFC/httpbis_p1
 * @append RFC/5646_language
 * @append RFC/5324_abnf
 */

/* 3.1.1.1.  Media Type */
 media_type
   = type "/" subtype (OWS ";" OWS parameter)*

type
  = token

subtype
  = token

parameter
  = attribute "=" value

attribute
  = token

value
  = word


/* 3.1.1.2.  Charset */
charset
  = token


/* 3.1.1.5.  Content-Type */
content_type
  = media_type


/* 3.1.2.1.  Content Codings */
content_coding
  = token


/* 3.1.2.2.  Content-Encoding */
content_encoding
  = ("," OWS)* content_coding (OWS "," (OWS content_coding)?)*


/* 3.1.3.1.  Language Tags */
// REFERENCE


/* 3.1.3.2.  Content-Language */
content_language
  = ("," OWS)* language_tag (OWS "," (OWS language_tag)?)*


/* 3.1.4.2.  Content-Location */
content_location
  = absolute_URI
  / partial_URI


/* 5.1.1.  Expect */
// FIXME


/* 5.1.2.  Max-Forwards */
// FIXME


/* 5.3.1.  Quality Values */
weight
  = OWS ";" OWS "q=" qvalue

qvalue
  = "0" ("." DIGIT? DIGIT? DIGIT?)?
  / "1" ("." "0"? "0"? "0"?)?


/* 5.3.2.  Accept */
// FIXME


/* 5.3.3.  Accept-Charset */
// FIXME


/* 5.3.4.  Accept-Encoding */
// FIXME


/* 5.3.5.  Accept-Language */
// FIXME


/* 5.5.1.  From */
// FIXME


/* 5.5.2.  Referer */
referer
  = absolute_URI
  / partial_URI


/* 5.5.3.  User-Agent */
user_agent
  = product (RWS (product / comment))*

product
  = token ("/" product_version)?

product_version
  = token


/* 7.1.1.1.  Date/Time Formats */
// FIXME


/* 7.1.1.2.  Date */
date
  = HTTP_date


/* 7.1.2.  Location */
location
  = URI_reference


/* 7.1.3.  Retry-After */
retry_after
  = HTTP_date
  / delta_seconds

delta_seconds
  = DIGIT+


/* 7.1.4.  Vary */
vary
  = "*"
  / ("," OWS)* field_name (OWS "," (OWS field_name)?)*


/* 7.4.1.  Allow */
allow
  = ("," OWS)* method (OWS "," (OWS method)?)*


/* 7.4.2.  Server */
server
  = product (RWS (product / comment))*
