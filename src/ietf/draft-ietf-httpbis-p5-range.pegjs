/*
 * HTTPbis P5
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p5-range
 *
 * @append ietf/draft-ietf-httpbis-p4-conditional.pegjs
 * @append ietf/draft-ietf-httpbis-p2-semantics.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5646-language.pegjs
 * @append ietf/rfc4647-language-matching.pegjs
 * @append ietf/rfc5322-imf.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

// FIXME

/* http://tools.ietf.org/html/draft-ietf-httpbis-p5-range#section-3.2 If-Range */
If_Range
  = entity_tag
  / HTTP_date
