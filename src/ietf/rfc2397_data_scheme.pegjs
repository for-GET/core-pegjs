/*
 * The "data" URL scheme
 *
 * http://tools.ietf.org/html/rfc2397
 *
 * <urlchar>/<uric> is added inline since RFC2396 is obsoleted by RFC/3986_uri.pegjs (which doesn't have that rule anymore)
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5322_imf.pegjs
 * @append ietf/rfc4647_language_matching.pegjs
 * @append ietf/rfc5646_language.pegjs
 * @append ietf/draft_ietf_httpbis_p1_messaging.pegjs
 * @append ietf/draft_ietf_httpbis_p2_semantics.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
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
