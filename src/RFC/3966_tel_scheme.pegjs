/*
 * The tel URI for Telephone Numbers
 *
 * http://tools.ietf.org/html/rfc3966
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append RFC/3986_uri.pegjs
 * @append RFC/5234_core_abnf.pegjs
 */

/* 3.  URI Syntax */
telephone_uri
  = "tel:" telephone_subscriber

telephone_subscriber
  = global_number
  / local_number

global_number
  = global_number_digits $(par*)

local_number
  = local_number_digits $(par*) context $(par*)

par
  = parameter
  / extension
  / isdn_subaddress

isdn_subaddress
  = ";isub=" $(paramchar+)

extension
  = ";ext=" $(phonedigit+)

context
  = ";phone_context=" descriptor

descriptor
  = domainname
  / global_number_digits

global_number_digits
  = "+" $(phonedigit*) DIGIT $(phonedigit*)

local_number_digits
  = $(phonedigit_hex*) $(HEXDIG / "*" / "#")* phonedigit_hex

domainname
  = (domainlabel ".")* toplabel ["."]

domainlabel
  = alphanum
  / $(alphanum (alphanum / "-")* alphanum)

toplabel
  = ALPHA
  / $(ALPHA (alphanum / "-")* alphanum)

parameter
  = ";" pname ("=" pvalue)?

pname
  = $(alphanum / "-")+

pvalue
  = $(paramchar+)

paramchar
  = param_unreserved
  / unreserved
  / pct_encoded

unreserved
  = alphanum
  / mark

mark
  = "-"
  / "_"
  / "."
  / "!"
  / "~"
  / "*"
  / "'"
  / "("
  / ")"

pct_encoded
  = "%" HEXDIG HEXDIG

param_unreserved
  = "["
  / "]"
  / "/"
  / ":"
  / "&"
  / "+"
  / "$"

phonedigit
  = DIGIT
  / visual_separator?

phonedigit_hex
  = HEXDIG
  / "*"
  / "#"
  / visual_separator?

visual_separator
  = "-"
  / "."
  / "("
  / ")"

alphanum
  = ALPHA
  / DIGIT

reserved
  = ";"
  / "/"
  / "?"
  / ":"
  / "@"
  / "&"
  / "="
  / "+"
  / "$"
  / ","

uric
  = reserved
  / unreserved
  / pct_encoded
