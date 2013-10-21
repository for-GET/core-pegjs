/*
 * Augmented BNF for Syntax Specifications: ABNF
 *
 * http://tools.ietf.org/html/rfc5234
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc5234#section-4 ABNF Definition of ABNF */
rulelist
  = ( rule
    / c_wsp* c_nl
    )+

// continues if next line starts
// with white space
rule
  = rulename defined_as elements c_nl

rulename
  = $(ALPHA (ALPHA / DIGIT / "-")*)

// basic rules definition and
// incremental alternatives
defined_as
  = c_wsp* $("=" / "=/") c_wsp*

elements
  = alternation c_wsp*

c_wsp
  = WSP
  / c_nl WSP

// comment or newline
c_nl
  = comment
  / CRLF

comment
  = ";" $(WSP / VCHAR)* CRLF

alternation
  = concatenation (c_wsp* "/" c_wsp concatenation*)*

concatenation
  = repetition (c_wsp+ repetition)*

repetition
  = repeat? element

repeat
  = $(DIGIT+)
  / $(DIGIT*) "*" $(DIGIT*)

element
  = rulename
  / group
  / option
  / char_val
  / num_val
  / prose_val

group
  = "(" c_wsp* alternation c_wsp* ")"

option
  = "[" c_wsp* alternation c_wsp* "]"

// quoted string of SP and VCHAR
// without DQUOTE
char_val
  = DQUOTE ([\x20-\x21] / [\x23-\x7E])* DQUOTE

num_val
  = "%" (bin_val / dec_val / hex_val)

// series of concatenated bit values
// or single ONEOF range
bin_val
  = "b" BIT+ (("." BIT+)+ / ("-" BIT+))?

dec_val
  = "d" DIGIT+ (("." DIGIT+)+ / ("-" DIGIT+))?

hex_val
  = "x" HEXDIG+ (("." HEXDIG+)+ / ("-" HEXDIG+))?

// bracketed string of SP and VCHAR
// without angles
// prose description, to be used as
// last resort
prose_val
  = "<" ([\x20-\x3D] / [\x3F-\x7E])* ">"
