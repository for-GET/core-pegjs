/*
 * HTTP P2
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p2-semantics
 *
 * @append RFC/httpbis_p1.pegjs
 * @append RFC/3986_uri.pegjs
 * @append RFC/5646_language.pegjs
 * @append RFC/4647_language_matching.pegjs
 * @append RFC/5322_imf.pegjs
 * @append RFC/5234_abnf.pegjs
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
Expect
  = ("," OWS)* expectation (OWS "," (OWS expectation)?)*

expectation
  = expect_name (BWS "=" BWS expect_value)?
    (OWS ";" (OWS expect_param)?)*

expect_param
  = expect_name (BWS "=" BWS expect_value)?

expect_name
  = token

expect_value
  = token
  / quoted_string


/* 5.1.2.  Max-Forwards */
Max_Forwards
  = $(DIGIT+)


/* 5.3.1.  Quality Values */
weight
  = OWS ";" OWS "q=" qvalue

qvalue
  = $( "0" ("." DIGIT? DIGIT? DIGIT?)?
     / "1" ("." "0"? "0"? "0"?)?
     )


/* 5.3.2.  Accept */
Accept
  = (("," / Accept_item) (OWS "," (OWS Accept_item)?)*)?

Accept_item =
  = media_range accept_params?

media_range
  = ( "*/*"
    / (type "/" "*")
    / (type "/" subtype)
    ) (OWS ";" OWS parameter)*

accept_params
  = weight accept_ext*

accept_ext
  = OWS ";" OWS token ("=" word)?


/* 5.3.3.  Accept-Charset */
Accept_Charset
  = ("," OWS)* Accept_Charset_item (OWS "," (OWS Accept_Charset_item)?)*

Accept_Charset_item
  = (charset / "*") weight?


/* 5.3.4.  Accept-Encoding */
Accept_Encoding
  = (("," / Accept_Encoding_item) (OWS "," (OWS Accept_Encoding_item)?)*)?

Accept_Encoding_item
  = codings weight?

codings
  = content_coding
  / "identity"
  / "*"


/* 5.3.5.  Accept-Language */
Accept_Language
  = ("," OWS)* Accept_Language_item (OWS "," (OWS Accept_Language_item)?)*

Accept_Language_item
  = language_range weight?


/* 5.5.1.  From */
From
  = mailbox


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
HTTP_date
  = IMF_fixdate
  / obs_date

IMF_fixdate
  = day_name "," SP date1 SP time_of_day SP GMT

date1
  // e.g., 02 Jun 1982
  = day SP month SP year

GMT
  = "GMT"

obs_date
  = rfc850_date
  / asctime_date

rfc850_date
  = day_name_l "," SP date2 SP time_of_day SP GMT

date2
  // e.g., 02-Jun-82
  = day "-" month "-" $(DIGIT DIGIT)

day_name_l
  = "Monday"
  / "Tuesday"
  / "Wednesday"
  / "Thursday"
  / "Friday"
  / "Saturday"
  / "Sunday"

asctime_date
  = day_name SP date3 SP time_of_day SP year

date3
  // e.g., Jun  2
  = month SP $(DIGIT DIGIT / SP DIGIT)


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
  = $(DIGIT+)


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
