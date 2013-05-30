/*
 * The "data" URL scheme
 *
 * http://www.ietf.org/rfc/rfc2397.txt
 *
 * <mediatype> has been replaced by <media_type> as defined in RFC/httpbis_p2.pegjs
 *
 * <urlchar>/<uric> has been replaced since RFC2396 is obsoleted by RFC/3986_uri.pegjs (which doesn't have that rule anymore)
 *
 * #append RFC/2396_uri.pegjs is obsoleted by RFC/3986_uri.pegjs
 * @append RFC/3986_uri.pegjs
 * @append RFC/5324_abnf.pegjs
 */

/* 3. Syntax */
dataurl
  = "data:" media_type? ";base64"? "," data

data
  = $(reserved / unreserved / pct_encoded)*
