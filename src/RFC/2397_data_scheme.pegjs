/*
 * The "data" URL scheme
 *
 * http://tools.ietf.org/html/rfc2397
 *
 * <urlchar>/<uric> is added inline since RFC2396 is obsoleted by RFC/3986_uri.pegjs (which doesn't have that rule anymore)
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append RFC/3986_uri.pegjs
 * @append RFC/5234_abnf.pegjs
 */

/* 3. Syntax */
dataurl
  = "data:" mediatype? ";base64"? "," data

mediatype
  = (type "/" subtype)? (";" parameter)*

data
  = $(uric*)

uric
  = reserved
  / unreserved
  / pct_encoded
