/*
 * The "data" URL scheme
 *
 * http://tools.ietf.org/html/rfc2397
 *
 * <urlchar>/<uric> is added inline since RFC2396 is obsoleted by RFC/3986_uri.pegjs (which doesn't have that rule anymore)
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5322-imf.pegjs
 * @append ietf/rfc4647-language-matching.pegjs
 * @append ietf/rfc5646-language.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/draft-ietf-httpbis-p2-semantics.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc2397#section-3 Syntax */
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
