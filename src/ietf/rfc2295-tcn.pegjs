/*
 * Transparent Content Negotiation in HTTP
 *
 * http://tools.ietf.org/html/rfc2295
 *
 * @append ietf/draft-ietf-httpbis-p2-semantics.pegjs
 * @append ietf/draft-ietf-httpbis-p1-messaging.pegjs
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5646-language.pegjs
 * @append ietf/rfc4647-language-matching.pegjs
 * @append ietf/rfc5322-imf.pegjs
 * @append ietf/rfc2045-imb.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc2295#section-3 Notation */

/*
In ABNF
1%rule = rule *( 1*LWS rule )
// CHANGE PWS to WSP
1%rule = rule *( 1*WSP rule )

In PEGjs
1%rule = rule (WSP+ rule)?
*/

number
  = $(DIGIT+)

short_float
  = $(DIGIT (DIGIT DIGIT?)? ("." (DIGIT (DIGIT DIGIT?)?)?))


/* http://tools.ietf.org/html/rfc2295#section-5.1 Syntax */

variant_description
  = "{\"" URI "\"" source_quality variant_attribute* "}"

source_quality
  = qvalue

// CHANGE add space after all extension names as inferred from examples
variant_attribute
  = "{type" WSP+ media_type "}"
  / "{charset" WSP+ charset "}"
  / "{language" WSP+ ("," OWS)* language_tag (OWS "," (OWS language_tag)?)* "}"
  / "{length" WSP+ $(DIGIT+) "}"
  / "{features" WSP+ feature_list "}"
  / "{description" WSP+ quoted_string (WSP+ language_tag)? "}"
  / extension_attribute

extension_attribute
  = "{" extension_name WSP+ extension_value "}"

extension_name
  = token

extension_value
  = $( token
     / quoted_string
     /*
     // CHANGE LWS to WSP
     / LWS
     */
     / WSP
     / extension_specials
     )*

// any element of tspecials except <"> and "}"
extension_specials
  = !"\"" !"{" tspecials


/* http://tools.ietf.org/html/rfc2295#section-6.1  Feature tags */
ftag
  = token
  / quoted_string


/* http://tools.ietf.org/html/rfc2295#section-6.1.1 Feature tag values */
tag_value
  = token
  / quoted_string


/* http://tools.ietf.org/html/rfc2295#section-6.3 Feature predicates */
fpred
  = "!"? ftag
  / ftag ("=" / "!=") tag_value
  / ftag "=" "[" numeric_range "]"

numeric_range
  = number? "-" number?


/* http://tools.ietf.org/html/rfc2295#section-6.4 Features attributes */
feature_list
  = feature_list_element (WSP+ feature_list_element)?

feature_list_element
  = (fpred / fpred_bag) (";" ("+" true_improvement)? ("-" false_degradation)?)?

fpred_bag
  = "[" fpred (WSP+ fpred)? "]"

true_improvement
  = short_float

false_degradation
  = short_float


/* http://tools.ietf.org/html/rfc2295#section-7.1 Version numbers */
rvsa_version
  = major "." minor

major
  = DIGIT (DIGIT (DIGIT DIGIT?)?)?
minor
  = DIGIT (DIGIT (DIGIT DIGIT?)?)?


/* http://tools.ietf.org/html/rfc2295#section-8.2 Accept-Features */
// CHANGE remove header name
Accept_Features = (("," / Accept_Features_item_) (OWS "," (OWS Accept_Features_item_)?)*)?

Accept_Features_item_ = feature_expr (";" feature_extension)*

feature_expr
  = "!"? ftag
  / ftag ("=" / "!=") tag_value
  / ftag "=" "{" tag_value "}"
  / "*"

feature_extension
  = token ("=" (token / quoted_string))?


/* http://tools.ietf.org/html/rfc2295#section-8.3 Alternates */
// CHANGE remove header name
Alternates = variant_list

variant_list
  = ("," OWS)* variant_list_item_ (OWS "," (OWS variant_list_item_)?)*

variant_list_item_
  = variant_description
  / fallback_variant
  / list_directive

fallback_variant
  = "{\"" URI "\"}"

list_directive
  = "proxy-rvsa=\"" (("," / rvsa_version) (OWS "," (OWS rvsa_version)?)*)? "\""
  / extension_list_directive

extension_list_directive
  = token ("=" (token / quoted_string))?


/* http://tools.ietf.org/html/rfc2295#section-8.4 Negotiate */
// CHANGE remove header name
Negotiate = ("," OWS)* negotiate_directive (OWS "," (OWS negotiate_directive)?)*

negotiate_directive
  = "trans"
  / "vlist"
  / "guess-small"
  / rvsa_version
  / "*"
  / negotiate_extension

negotiate_extension
  = token ("=" token)?


/* http://tools.ietf.org/html/rfc2295#section-8.5 TCN */
// CHANGE remove header name
TCN = (("," / TCN_item_) (OWS "," (OWS TCN_item_)?)*)?

TCN_item_
  = response_type
  / server_side_override_directive
  / tcn_extension

response_type
  = "list"
  / "choice"
  / "adhoc"

server_side_override_directive
  = "re-choose"
  / "keep"

tcn_extension
  = token ("=" (token / quoted_string))?


/* http://tools.ietf.org/html/rfc2295#section-8.6 Variant-Vary */
// CHANGE remove header name
Variant_Vary
  = "*"
  / ("," OWS)* field_name (OWS "," (OWS field_name)?)*