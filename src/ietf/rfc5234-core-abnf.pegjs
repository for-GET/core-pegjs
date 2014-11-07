/*
 * Augmented BNF for Syntax Specifications: ABNF
 *
 * http://tools.ietf.org/html/rfc5234
 */

/* http://tools.ietf.org/html/rfc5234#appendix-B Core ABNF of ABNF */
ALPHA
  = [\x41-\x5A]
  / [\x61-\x7A]

BIT
  = "0"
  / "1"

CHAR
  = [\x01-\x7F]

CR
  = "\x0D"

CRLF
  = CR LF

CTL
  = [\x00-\x1F]
  / "\x7F"

DIGIT
  = [\x30-\x39]

DQUOTE
  = [\x22]

HEXDIG
  = DIGIT
  / "A"i
  / "B"i
  / "C"i
  / "D"i
  / "E"i
  / "F"i

HTAB
  = "\x09"

LF
  = "\x0A"

LWSP
  = $(WSP / CRLF WSP)*

OCTET
  = [\x00-\xFF]

SP
  = "\x20"

VCHAR
  = [\x21-\x7E]

WSP
  = SP
  / HTAB
