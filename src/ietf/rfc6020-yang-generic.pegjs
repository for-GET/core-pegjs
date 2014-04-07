/*
 * YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF)
 *
 * http://tools.ietf.org/html/rfc6020
 *
 * Limitations & cleanup
 * - this is a generic grammar parsing only "unknown" i.e. generic statements
 *
 * @append ietf/rfc5234-core-abnf.pegjs
 */

// CHANGE allow stmtsep before and after
// CHANGE allow optsep after
// CHANGE group "prefix:" for action simplification
unknown_statement
  = (prefix ":") identifier (sep string)? optsep (";" / "{" stmtsep_no_stmt_ (unknown_statement2 stmtsep_no_stmt_)* "}") optsep

// CHANGE allow stmtsep before and after
// CHANGE allow optsep after
unknown_statement2
  = (prefix ":")? identifier (sep string)? optsep (";" / "{" stmtsep_no_stmt_ (unknown_statement2 stmtsep_no_stmt_)* "}") optsep

prefix
  = identifier

// An identifier MUST NOT start with (('X'|'x') ('M'|'m') ('L'|'l'))
// CHANGED encode rule for identifier not to start with <xml>
identifier
  = $(!identifier_xml_ (ALPHA / "_") (ALPHA / DIGIT / "_" / "-" / ".")*)

identifier_xml_
  = [Xx][Mm][Ll]

// CHANGE restrict quoted: no inner quote (even escaped)
// CHANGE restrict unquoted: no inner quote, no semicolon, open curly bracket
// CHANGE allow multiline strings, concatenated by +
string
  = string_quoted_
  / string_unquoted_

string_quoted_
  = DQUOTE $[^"]* DQUOTE (optsep "+" optsep string_quoted_)*
  / SQUOTE $[^']* SQUOTE (optsep "+" optsep string_quoted_)*

string_unquoted_
  = $(!(sep [";{]) [^";{])+

// unconditional separator
sep
  = $(WSP / line_break)+

// CHANGE accept comments as well
optsep
  = $(WSP / line_break / comment_)*

// CHANGE DRY optsep
// CHANGE allow comments
stmtsep
  = optsep (comment_ / unknown_statement)*

stmtsep_no_stmt_
  = optsep comment_*

comment_
  = single_line_comment_ optsep
  / multi_line_comment_ optsep

single_line_comment_
  = "//" $(!line_break .)* line_break

multi_line_comment_
  = "/*" $(!"*/" .)+ "*/"

line_break
  = CRLF
  / LF

// ' (Single Quote)
SQUOTE
  = "'"
