/*
 * HTTPbis P4
 *
 * http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional
 *
 * Limitations & cleanup
 * - ignoring obsolete rules obs_*`
 *
 * @append ietf/draft_ietf_httpbis_p2_semantics.pegjs
 * @append ietf/draft_ietf_httpbis_p1_messaging.pegjs
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5646_language.pegjs
 * @append ietf/rfc4647_language_matching.pegjs
 * @append ietf/rfc5322_imf.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-2.2 Last-Modified */
Last_Modified
  = HTTP_date

/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-2.3 ETag */
ETag
  = entity_tag

entity_tag
  = weak? opaque_tag

weak
  = "W/"

opaque_tag
  = DQUOTE etagc* DQUOTE

etagc
  // VCHAR except double quotes, plus obs-text
  = [\x21]
  / [\x23-\x7E]
  /*
  // CHANGE Ignore obsolete
  / obs_text
  */

/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-3.1 If-Match */
If_Match
  = "*"
  / ("," OWS)* entity_tag (OWS "," (OWS entity_tag)?)*


/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-3.2 If-None-Match */
If_None_Match
  = "*"
  / ("," OWS)* entity_tag (OWS "," (OWS entity_tag)?)*


/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-3.3 If-Modified-Since */
If_Modified_Since
  = HTTP_date


/* http://tools.ietf.org/html/draft-ietf-httpbis-p4-conditional#section-3.4 If-Unmodified-Since */
If_Unmodified_Since
  = HTTP_date
