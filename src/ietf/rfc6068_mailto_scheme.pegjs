/*
 * The 'mailto' URI Scheme
 *
 * http://tools.ietf.org/html/rfc6068
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5322_imf.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* 2.  Syntax of a 'mailto' URI */
mailtoURI
  = "mailto:" to? hfields?

to
  = addr_spec ("," addr_spec)*

hfields
  = "?" hfield ("&" hfield)*

hfield
  = hfname "=" hfvalue

hfname
  = qchar*
hfvalue
  = qchar*

addr_spec
  = local_part "@" domain

local_part
  = dot_atom_text
  / quoted_string

domain
  = dot_atom_text
  / "[" dtext_no_obs* "]"

dtext_no_obs
  = [\x21-\x5A] // Printable US-ASCII
  / [\x5D-\x7E] // characters not including
                // "[", "]", or "\"

qchar
  = unreserved
  / pct_encoded
  / some_delims

some_delims
  = "!"
  / "$"
  / "'"
  / "("
  / ")"
  / "*"
  / "+"
  / ","
  / ";"
  / ":"
  / "@"
