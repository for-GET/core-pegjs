/*
 * Namespaces in XML 1.0 (Third Edition)
 *
 * http://www.w3.org/TR/REC-xml-names
 *
 * Limitations & cleanup
 * - stub
 */

QName
  = PrefixedName
  / UnprefixedName

PrefixedName
  = Prefix ":" LocalPart

UnprefixedName
  = LocalPart

Prefix
  = NCName

LocalPart
  = NCName

// CHANGE accept ':'
NCName
  = Name

Name
  = NameStartChar NameChar*

// CHANGE maybe remove ':'
// CHANGE remove [\u10000-\uEFFFF]
NameStartChar
  = [A-Z]
  / "_"
  / [a-z]
  / [\u00C0-\u00D6]
  / [\u00D8-\u00F6]
  / [\u00F8-\u02FF]
  / [\u0370-\u037D]
  / [\u037F-\u1FFF]
  / [\u200C-\u200D]
  / [\u2070-\u218F]
  / [\u2C00-\u2FEF]
  / [\u3001-\uD7FF]
  / [\uF900-\uFDCF]
  / [\uFDF0-\uFFFD]

NameChar
  = NameStartChar
  / "-"
  / "."
  / [0-9]
  / [\u00B7]
  / [\u0300-\u036F]
  / [\u203F-\u2040]
