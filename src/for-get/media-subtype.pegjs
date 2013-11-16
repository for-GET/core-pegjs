/*
 * A pattern for media subtypes e.g. "example-v1+json"
 *
 * @append ietf/draft_ietf_httpbis_p2_semantics.pegjs
 * @append ietf/draft_ietf_httpbis_p1_messaging.pegjs
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5646_language.pegjs
 * @append ietf/rfc4647_language_matching.pegjs
 * @append ietf/rfc5322_imf.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

media_subtype
  = media_subtype_entity "-v" media_subtype_version "+" media_subtype_syntax
  / media_subtype_entity "-v" media_subtype_version
  / media_subtype_entity "+" media_subtype_syntax
  / media_subtype_syntax
  / subtype

media_subtype_entity
  = $(!("-v" / "+") tchar)+

media_subtype_version
  = $(DIGIT+)

media_subtype_syntax
  = $(ALPHA+)