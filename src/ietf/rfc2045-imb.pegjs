/*
 * Multipurpose Internet Mail Extensions (MIME) Part One: Format of Internet Message Bodies
 *
 * http://tools.ietf.org/html/rfc2045
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

// FIXME

/* http://tools.ietf.org/html/rfc2045#section-5.1  Syntax of the Content-Type Header Field */

// Must be in quoted-string,
// to use within parameter values
tspecials
  = "("
  / ")"
  / "<"
  / ">"
  / "@"
  / ","
  / ";"
  / ":"
  / "\\"
  / "\""
  / "/"
  / "["
  / "]"
  / "?"
  / "="

