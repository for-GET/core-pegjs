/*
 * A pattern for media subtypes e.g. "example-v1+json"
 *
 * @append ietf/draft-ietf-httpbis-p2-semantics.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5646-language.pegjs
 * @append ietf/rfc4647-language-matching.pegjs
 * @append ietf/rfc5322-imf.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
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