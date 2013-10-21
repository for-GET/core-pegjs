/*
 * Uniform Resource Identifier (URI): Generic Syntax
 *
 * http://tools.ietf.org/html/rfc3986
 *
 * <host> element has been renamed to <hostname> as a dirty workaround for
 * element being re-defined with another meaning in HTTPbis
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc3986#section-2.1 Percent-Encoding */
pct_encoded
  = $("%" HEXDIG HEXDIG)


/* http://tools.ietf.org/html/rfc3986#section-2.2 Reserved Characters */
reserved
  = gen_delims
  / sub_delims

gen_delims
  = ":"
  / "/"
  / "?"
  / "#"
  / "["
  / "]"
  / "@"

sub_delims
  = "!"
  / "$"
  / "&"
  / "'"
  / "("
  / ")"
  / "*"
  / "+"
  / ","
  / ";"
  / "="


/* http://tools.ietf.org/html/rfc3986#section-2.3 Unreserved Characters */
unreserved
  = ALPHA
  / DIGIT
  / "-"
  / "."
  / "_"
  / "~"


/* http://tools.ietf.org/html/rfc3986#section-3 Syntax Components */
URI
  = scheme ":" hier_part ("?" query)? ("#" fragment)?

hier_part
  = "//" authority path_abempty
  / path_absolute
  / path_rootless
  / path_empty


/* http://tools.ietf.org/html/rfc3986#section-3.1 Scheme */
scheme
  = $(ALPHA (ALPHA / DIGIT / "+" / "-" / ".")*)


/* http://tools.ietf.org/html/rfc3986#section-3.2 Authority */
authority
  = (userinfo "@")? hostname (":" port)?


/* http://tools.ietf.org/html/rfc3986#section-3.2.1 User Information */
userinfo
  = $(unreserved / pct_encoded / sub_delims / ":")*


/* http://tools.ietf.org/html/rfc3986#section-3.2.2 Host */
hostname
  = IP_literal
  / IPv4address
  / reg_name

IP_literal
  = "[" (IPv6address / IPvFuture) "]"

IPvFuture
  = "v" $(HEXDIG+) "." $(unreserved / sub_delims / ":")+

IPv6address
  = $(                                                            h16_ h16_ h16_ h16_ h16_ h16_ ls32
     /                                                       "::"      h16_ h16_ h16_ h16_ h16_ ls32
     / (                                               h16)? "::"           h16_ h16_ h16_ h16_ ls32
     / (                               h16_?           h16)? "::"                h16_ h16_ h16_ ls32
     / (                         (h16_ h16_?)?         h16)? "::"                     h16_ h16_ ls32
     / (                   (h16_ (h16_ h16_?)?)?       h16)? "::"                          h16_ ls32
     / (             (h16_ (h16_ (h16_ h16_?)?)?)?     h16)? "::"                               ls32
     / (       (h16_ (h16_ (h16_ (h16_ h16_?)?)?)?)?   h16)? "::"                               h16
     / ( (h16_ (h16_ (h16_ (h16_ (h16_ h16_?)?)?)?)?)? h16)? "::"
     )

ls32
  // least_significant 32 bits of address
  = h16 ":" h16
  / IPv4address

h16_
  = h16 ":"

h16
  // 16 bits of address represented in hexadecimal
  = $(HEXDIG (HEXDIG (HEXDIG HEXDIG?)?)?)

IPv4address
  = dec_octet "." dec_octet "." dec_octet "." dec_octet

dec_octet
  = $( DIGIT                 // 0-9
     / [\x31-\x39] DIGIT     // 10-99
     / "1" DIGIT DIGIT       // 100-199
     / "2" [\x30-\x34] DIGIT // 200-249
     / "25" [\x30-\x35]      // 250-255
     )

reg_name
  = $(unreserved / pct_encoded / sub_delims)*


/* http://tools.ietf.org/html/rfc3986#section-3.2.3 Port */
port
  = $(DIGIT*)


/* http://tools.ietf.org/html/rfc3986#section-3.3 Path */
path
  = path_abempty  // begins with "/" or is empty
  / path_absolute // begins with "/" but not "//"
  / path_noscheme // begins with a non_colon segment
  / path_rootless // begins with a segment
  / path_empty    // zero characters

path_abempty
  = $("/" segment)*

path_absolute
  = $("/" (segment_nz ("/" segment )*)?)

path_noscheme
  = $(segment_nz_nc ("/" segment)*)

path_rootless
  = $(segment_nz ("/" segment)*)

path_empty
  =

segment
  = $(pchar*)

segment_nz
  = $(pchar+)

segment_nz_nc
  // non_zero_length segment without any colon ":"
  = $(unreserved / pct_encoded / sub_delims / "@")+

pchar
  = unreserved
  / pct_encoded
  / sub_delims
  / ":"
  / "@"


/* http://tools.ietf.org/html/rfc3986#section-3.4 Query */
query
  = $(pchar / "/" / "?")*


/* http://tools.ietf.org/html/rfc3986#section-3.5 Fragment */
fragment
  = $(pchar / "/" / "?")*


/* http://tools.ietf.org/html/rfc3986#section-4.1 URI Reference */
URI_reference
  = URI
  / relative_ref


/* http://tools.ietf.org/html/rfc3986#section-4.2 Relative Reference */
relative_ref
  = relative_part ("?" query)? ("#" fragment)?

relative_part
  = "//" authority path_abempty
  / path_absolute
  / path_noscheme
  / path_empty


/* http://tools.ietf.org/html/rfc3986#section-4.3 Absolute URI */
absolute_URI
  = scheme ":" hier_part ("?" query)?
