/*
 * draft-bortzmeyer-language-state-machines-01 - Cosmogol: a language to describe finite state machines
 *
 * http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines
 *
 * Limitations & cleanup
 * - names rule is reused more
 * - regular_identifier accepts also - as ending character
 * - regular_identifier accepts also _
 * - comments are allowed only on new lines
 * - identifier_chars are extended with TODOs
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines-01#section-4 Grammar */
state_machine
  = statement+

statement
  = comment_nl
  / (transition / declaration / assignment) LWSP_ ";" LWSP_

colon
  = LWSP_ ":" LWSP_
comma
  = LWSP_ "," LWSP_
equal
  = LWSP_ "=" LWSP_
arrow
  = LWSP_ "->" LWSP_

declaration
  = names colon value
// ALTERNATIVE: indicate the possible values in the grammar:
// declaration = names colon type
// type = "state" / "message" / "action"

assignment
  = name equal value

names
  = name (comma name)*

name
  = quoted_name
  / regular_identifier

quoted_name
  = DQUOTE $(identifier_chars+) DQUOTE

// TODO: this grammar allows identifiers like foo----bar
// (several dashes). Do we really want it?
regular_identifier
  = $((ALPHA / DIGIT) (("-" / "_")? (ALPHA / DIGIT))*)

transition
  = current_states colon messages arrow next_state (colon action)?

// ALTERNATIVE : some people prefer to put the message first:
//transition = message colon
//             current-state arrow next-state
//             [colon action]

// ALTERNATIVE: some people prefer to see the current-state and
// the message grouped together:
//transition = left-paren current-state comma message right-paren
//             arrow next-state
//             [colon action]

// ALTERNATIVE: allow some grouping, for instance:
//   Signal1:
//     IDLE -> BUSY:
//       connectSubscriber;
//     CONNECTING -> DISCONNECTING:
//       disconnectSubscriber
// # Henk-Jan van Tuyl <hjgtuyl@chello.nl>

// ALTERNATIVE: allow more than one action, comma-separated
//  Marc Petit-Huguenin <marc@8x8.com>

current_states
  = names
messages
  = names
next_state
  = name
action
  = name

value
  = name

// TODO: we should allow the dot!
// TODO: allow the square brackets (RFC 2960)
// TODO: allow parenthesis
// TODO: allow slashes and < and > (draft on shim6)
identifier_chars
  = ALPHA
  / DIGIT
  / "-"
  / "_"
  / "'"
  / ","
  / ";"
  / SP
  / "."
  / "["
  / "]"
  / "("
  / ")"
  / "<"
  / ">"
  / "/"
// All letters and digits and
// some (a bit arbitrary) chars

comment
  = $("#" (WSP / VCHAR)* CRLF)

comment_nl
  = comment
  / CRLF

comment_wsp
  = ( WSP
    / comment_nl
    )*

LWSP_
  = $((WSP / CRLF / LF)*)
