/*
 * draft-bortzmeyer-language-state-machines-01 - Cosmogol: a language to describe finite state machines
 *
 * http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines
 *
 * Limitations & cleanup
 * - based on https://github.com/andreineculau/cosmogol-abnf
 *
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines-01#section-4 Grammar */
state_machine
  = comment_nl* statement (statement / comment_nl)+

statement
  = (transition / declaration / assignment) semicolon

declaration
  = coordnames colon value
// ALTERNATIVE: indicate the possible values in the grammar:
// declaration = names colon type
// type = "state" / "message" / "action"

assignment
  = name equal value

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

names
  = name (comma name)*
name
  = quoted_name
  / regular_identifier
quoted_name
  = DQUOTE $(identifier_chars+) DQUOTE
regular_identifier
  = $((ALPHA / DIGIT) (("-" / "_")? (ALPHA / DIGIT))*)
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

coords
  = coord (comma coord)*
coordnames
  = coordname (comma coordname)*
coordname
  = name ":" coord ":" coord
  / name ":" coord
  / name
coord
  = $(ALPHA+) $(DIGIT+)

semicolon
  = CRLFWSP ";" CRLFWSP
colon
  = CRLFWSP ":" CRLFWSP
comma
  = CRLFWSP "," CRLFWSP
equal
  = CRLFWSP "=" CRLFWSP
arrow
  = CRLFWSP "-" (coords "-")? ">" CRLFWSP

comment
  = $("#" (WSP / VCHAR)* CR? LF)
comment_nl
  = comment
  / CR? LF

CRLFWSP
  = (CR? LF)* WSP*
