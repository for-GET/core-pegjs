/*
 * URI Template
 *
 * http://tools.ietf.org/html/rfc6570
 *
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc3987_iri.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc6570#section-2 Syntax */
URI_Template
  = (literals / expression)*


/* http://tools.ietf.org/html/rfc6570#section-2.1 Literals */
literals
  // any Unicode character except: CTL, SP,
  // DQUOTE, "'", "%" (aside from pct-encoded),
  // "<", ">", "\", "^", "`", "{", "|", "}"
  = "\x21"
  / [\x23-\x24]
  / "\x26"
  / [\x28-\x3B]
  / "\x3D"
  / [\x3F-\x5B]
  / "\x5D"
  / "\x5F"
  / [\x61-\x7A]
  / "\x7E"
  / ucschar
  / iprivate
  / pct_encoded


/* http://tools.ietf.org/html/rfc6570#section-2.2 Expressions */
expression
  =  "{" operator? variable_list "}"

operator
  = op_level2
  / op_level3
  / op_reserve

op_level2
  = "+"
  / "#"

op_level3
  = "."
  / "/"
  / ";"
  / "?"
  / "&"

op_reserve
  = "="
  / ","
  / "!"
  / "@"
  / "|"


/* http://tools.ietf.org/html/rfc6570#section-2.3 Variables */
variable_list
  = varspec ("," varspec)*

varspec
  = varname modifier_level4?

varname
  = $(varchar ("."? varchar)*)

varchar
  = ALPHA
  / DIGIT
  / "_"
  / pct_encoded


/* http://tools.ietf.org/html/rfc6570#section-2.4 Value Modifiers */
modifier_level4
  = prefix
  / explode


/* http://tools.ietf.org/html/rfc6570#section-2.4.1 Prefix Values */
prefix
  = ":" max_length

max_length
  // positive integer < 10000
  = $([\x31-\x39] DIGIT? DIGIT? DIGIT?)


/* http://tools.ietf.org/html/rfc6570#section-2.4.2 Composite Values */
explode
  = "*"
