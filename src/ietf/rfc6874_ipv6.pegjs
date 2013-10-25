/*
 * Representing IPv6 Zone Identifiers in Address Literals and Uniform Resource Identifiers
 *
 * http://tools.ietf.org/html/rfc6874
 *
 * @append ietf/rfc3986_uri.pegjs
 * @append ietf/rfc5234_core_abnf.pegjs
 */

IP_literal
  = "[" (IPv6address / IPv6addrz / IPvFuture) "]"

ZoneID
  = $(unreserved / pct_encoded)+

IPv6addrz
  = IPv6address "%25" ZoneID
