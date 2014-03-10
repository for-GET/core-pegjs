/*
 * Namespaces in XML 1.0 (Third Edition)
 *
 * http://www.w3.org/TR/REC-xml-names
 *
 * Limitations & cleanup
 * - FIXME convert octal to unicode
 * - stub
 */

QName
  = PrefixedName
  / UnprefixedName

PrefixedName
  = Prefix ':' LocalPart

UnprefixedName
  = LocalPart

Prefix
  = NCName

LocalPart
  = NCName

NCName
  = Name
  { ^: }

Name
  = NameStartChar NameChar*

NameStartChar
  = ":"
  / [A-Z]
  / "_"
  / [a-z]

NameChar
  = NameStartChar
  / "-"
  / "."
  / [0-9]

/*
NameStartChar
  = ":"
  / [A-Z]
  / "_"
  / [a-z]
  / [#xC0-#xD6]
  / [#xD8-#xF6]
  / [#xF8-#x2FF]
  / [#x370-#x37D]
  / [#x37F-#x1FFF]
  / [#x200C-#x200D]
  / [#x2070-#x218F]
  / [#x2C00-#x2FEF]
  / [#x3001-#xD7FF]
  / [#xF900-#xFDCF]
  / [#xFDF0-#xFFFD]
  / [#x10000-#xEFFFF]

NameChar
  = NameStartChar
  / "-"
  / "."
  / [0-9]
  / #xB7
  / [#x0300-#x036F]
  / [#x203F-#x2040]
*/
