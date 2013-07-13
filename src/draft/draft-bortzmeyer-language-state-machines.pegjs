/*
 * draft-bortzmeyer-language-state-machines-01 - Cosmogol: a language to describe finite state machines
 * http://tools.ietf.org/html/draft-bortzmeyer-language-state-machines
 *
 * @append RFC/5234_core_abnf.pegjs
 */

state_machine
  = ( statement
    / comment_wsp*
    )+

statement
  = (declaration / transition / assignment) comment_wsp* ";" comment_wsp*

colon
  = comment_wsp* ":" comment_wsp*
comma
  = comment_wsp* "," comment_wsp*
equal
  = comment_wsp* "=" comment_wsp*
arrow
  = comment_wsp* "->" comment_wsp*

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
  = DQUOTE identifier_chars+ DQUOTE

// TODO: this grammar allows identifiers like foo----bar
// (several dashes). Do we really want it?
regular_identifier
  = ALPHA
  / ALPHA (ALPHA / DIGIT / "-")* (ALPHA / DIGIT)

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
  = name (comma name)*
messages
  = name (comma name)*
next_state = name
action = name

value
  = regular_identifier
  / quoted_name

identifier_chars
  = ALPHA
  / DIGIT
  / "-"
  / "_"
  / "'"
  / ","
  / ";"
  / SP
// All letters and digits and
// some (a bit arbitrary) chars

comment
  = "#" (WSP / VCHAR)* CRLF

comment_nl
  = comment
  / CRLF

comment_wsp
  = ( WSP
    / comment_nl
    )*
