/*
 * URN Syntax
 *
 * http://tools.ietf.org/html/rfc2141
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

// FIXME

/* http://tools.ietf.org/html/rfc2141#section-2 Syntax */
/*URN
  = "urn:" NID ":" NSS
*/


/* http://tools.ietf.org/html/rfc2141#section-2.1 Namespace Identifier Syntax */
/*
<NID>         ::= <let-num> [ 1,31<let-num-hyp> ]

<let-num-hyp> ::= <upper> | <lower> | <number> | "-"

<let-num>     ::= <upper> | <lower> | <number>

<upper>       ::= "A" | "B" | "C" | "D" | "E" | "F" | "G" | "H" |
"I" | "J" | "K" | "L" | "M" | "N" | "O" | "P" |
"Q" | "R" | "S" | "T" | "U" | "V" | "W" | "X" |
"Y" | "Z"

<lower>       ::= "a" | "b" | "c" | "d" | "e" | "f" | "g" | "h" |
"i" | "j" | "k" | "l" | "m" | "n" | "o" | "p" |
"q" | "r" | "s" | "t" | "u" | "v" | "w" | "x" |
"y" | "z"

<number>      ::= "0" | "1" | "2" | "3" | "4" | "5" | "6" | "7" |
"8" | "9"
*/


/* http://tools.ietf.org/html/rfc2141#section-2.2 Namespace Specific String Syntax */
/*
<NSS>         ::= 1*<URN chars>

<URN chars>   ::= <trans> | "%" <hex> <hex>

<trans>       ::= <upper> | <lower> | <number> | <other> | <reserved>

<hex>         ::= <number> | "A" | "B" | "C" | "D" | "E" | "F" |
"a" | "b" | "c" | "d" | "e" | "f"

<other>       ::= "(" | ")" | "+" | "," | "-" | "." |
":" | "=" | "@" | ";" | "$" |
"_" | "!" | "*" | "'"
*/


/* http://tools.ietf.org/html/rfc2141#section-2.3 Reserved characters */
/*
<reserved>    ::= '%" | "/" | "?" | "#"
*/


/* http://tools.ietf.org/html/rfc2141#section-2.4 Excluded characters */
/*
<excluded> ::= octets 1-32 (1-20 hex) | "\" | """ | "&" | "<"
| ">" | "[" | "]" | "^" | "`" | "{" | "|" | "}" | "~"
| octets 127-255 (7F-FF hex)
*/
