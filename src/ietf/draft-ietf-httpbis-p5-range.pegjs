/*
 * HTTPbis P5
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p5-range
 *
 * @append ietf/draft_ietf_httpbis_p4_conditional.pegjs
 * @append ietf/draft_ietf_httpbis_p2_semantics.pegjs
 * @append ietf/draft_ietf_httpbis_p1_messaging.pegjs
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5646_language.pegjs
 * @append ietf/rfc4647_language_matching.pegjs
 * @append ietf/rfc5322_imf.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

// FIXME

/* http://tools.ietf.org/html/draft-ietf-httpbis-p5-range#section-3.2 If-Range */
If_Range
  = entity_tag
  / HTTP_date
