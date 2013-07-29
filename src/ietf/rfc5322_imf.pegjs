/*
 * Internet Message Format
 *
 * http://tools.ietf.org/html/rfc5322
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* 3.2.1.  Quoted characters */
quoted_pair
  = "\\" (VCHAR / WSP)
  / obs_qp


/* 3.2.2.  Folding White Space and Comments */
FWS
  // Folding white space
  = $((WSP* CRLF)? WSP+)
  / obs_FWS

ctext
  = [\x21-\x27] // Printable US-ASCII
  / [\x2A-\x5B] // characters not including
  / [\x5D-\x7E] // "(", ")", or "\"
  / obs_ctext

ccontent
  = ctext
  / quoted_pair
  / comment

comment
  = "(" (FWS? ccontent)* FWS? ")"

CFWS
  = (FWS? comment)+ FWS?
  / FWS


/* 3.2.3.  Atom */
atext
  = ALPHA / DIGIT // Printable US-ASCII
  / "!" / "#"     // characters not including
  / "$" / "%"     // specials.  Used for atoms.
  / "&" / "'"
  / "*" / "+"
  / "-" / "/"
  / "=" / "?"
  / "^" / "_"
  / "`" / "{"
  / "|" / "}"
  / "~"

atom
  = CFWS? $(atext+) CFWS?

dot_atom_text
  = atext+ ("." atext+)*

dot_atom
  = CFWS? dot_atom_text CFWS?

/*
FIXME
specials        =   "(" / ")" /        ; Special characters that do
"<" / ">" /        ;  not appear in atext
"[" / "]" /
":" / ";" /
"@" / "\" /
"," / "." /
DQUOTE
*/


/* 3.2.4.  Quoted Strings */
qtext
  = "\x21"      // Printable US-ASCII
  / [\x23-\x5B] // characters not including
  / [\x5D-\x7E] // "\" or the quote character
  / obs_qtext

qcontent
  = qtext
  / quoted_pair

quoted_string
  = CFWS?
    DQUOTE (FWS? qcontent)* FWS? DQUOTE
    CFWS?


/* 3.2.5.  Miscellaneous Tokens */
word
  = atom
  / quoted_string

phrase
  = word+
  / obs_phrase

unstructured
  = (FWS? VCHAR)* WSP*
  / obs_unstruct


/* 3.3.  Date and Time Specification */
date_time
  = (day_of_week ",")? date time CFWS?

day_of_week
  = FWS? day_name
  / obs_day_of_week

day_name
  = "Mon"
  / "Tue"
  / "Wed"
  / "Thu"
  / "Fri"
  / "Sat"
  / "Sun"

date
  = day month year

day
  = FWS? DIGIT DIGIT? FWS
  / obs_day

month
  = "Jan"
  / "Feb"
  / "Mar"
  / "Apr"
  / "May"
  / "Jun"
  / "Jul"
  / "Aug"
  / "Sep"
  / "Oct"
  / "Nov"
  / "Dec"

year
  = FWS $(DIGIT DIGIT DIGIT DIGIT+) FWS
  / obs_year

time
  = time_of_day zone

time_of_day
  = hour ":" minute (":" second)?

hour
  = DIGIT DIGIT
  / obs_hour

minute
  = DIGIT DIGIT
  / obs_minute

second
  = DIGIT DIGIT
  / obs_second

zone
  = FWS ("+" / "-") $(DIGIT DIGIT DIGIT DIGIT)
  / obs_zone


/* 3.4.  Address Specification */
address
  = mailbox
  / group

mailbox
  = name_addr
  / addr_spec

name_addr
  = display_name? angle_addr

angle_addr
  = CFWS? "<" addr_spec ">" CFWS?
  / obs_angle_addr

group
  = display_name ":" group_list? ";" CFWS?

display_name
  = phrase

mailbox_list
  = mailbox ("," mailbox)*
  / obs_mbox_list

address_list
  = address ("," address)*
  / obs_addr_list

group_list
  = mailbox_list
  / CFWS
  / obs_group_list


/* 3.4.1.  Addr-Spec Specification */
addr_spec
  = local_part "@" domain

local_part
  = dot_atom
  / quoted_string
  / obs_local_part

domain
  = dot_atom
  / domain_literal
  / obs_domain

domain_literal
  = CFWS? "[" (FWS? dtext)* FWS? "]" CFWS?

dtext
  = [\x21-\x5A] // Printable US-ASCII
  / [\x5D-\x7E] // characters not including
  / obs_dtext   // "[", "]", or "\"


/* 3.5.  Overall Message Syntax */
/*
FIXME
message         =   (fields / obs-fields)
[CRLF body]

body            =   (*(*998text CRLF) *998text) / obs-body
*/

text
  = [\x00-\x09] // Characters excluding CR
  / "\x0B"      // and LF
  / "\x0C"
  / [\x0E-\x7F]


/* 4.1.  Miscellaneous Obsolete Tokens */
obs_NO_WS_CTL
  = [\x01-\x08] // US-ASCII control
  / "\x0B"      // characters that do not
  / "\x0C"      // include the carriage
  / [\x0E-\x1F] // return, line feed, and
  / "\x7F"      // white space characters

obs_ctext
  = obs_NO_WS_CTL

obs_qp
  = "\\" ("\x00" / obs_NO_WS_CTL / LF / CR)

obs_qtext
  = obs_NO_WS_CTL

obs_utext
  = "\x00"
  / obs_NO_WS_CTL
  / VCHAR

obs_body
  = $((LF* CR* (("\x00" / text) LF* CR*)*) / CRLF)*

obs_unstruct
  = $((LF* CR* (obs_utext LF* CR*)*) / FWS)*

obs_phrase
  = $(word (word / "." / CFWS)*)

obs_phrase_list
   = (phrase / CFWS)? ("," (phrase / CFWS)?)*


/* 4.2.  Obsolete Folding White Space */
obs_FWS
  = $(WSP+ (CRLF WSP+)*)


/* 4.3.  Obsolete Date and Time */
obs_day_of_week
  = CFWS? day_name CFWS?

obs_day
  = CFWS? DIGIT DIGIT? CFWS?

obs_year
  = CFWS? DIGIT DIGIT+ CFWS?

obs_hour
  = CFWS? DIGIT DIGIT CFWS?

obs_minute
  = CFWS? DIGIT DIGIT CFWS?

obs_second
  = CFWS? DIGIT DIGIT CFWS?

obs_zone
  // Universal Time
  = "UT"
  / "GMT"
  // North American UT
  // offsets
  / "EST" // Eastern:  - 5/ - 4
  / "EDT"
  / "CST" // Central:  - 6/ - 5
  / "CDT"
  / "MST" // Mountain: - 7/ - 6
  / "MDT"
  / "PST" // Pacific:  - 8/ - 7
  / "PDT"
  / [\x41-\x49] // Military zones - "A"
  / [\x4B-\x5A] // through "I" and "K"
  / [\x61-\x65] // through "Z", both
  / [\x6B-\x7A] // upper and lower case


/* 4.4.  Obsolete Addressing */
obs_angle_addr
  = CFWS? "<" obs_route addr_spec ">" CFWS?

obs_route
  = obs_domain_list ":"

obs_domain_list
  = (CFWS / ",")* "@" domain ("," CFWS? ("@" domain)?)*

obs_mbox_list
  = (CFWS? ",")* mailbox ("," (mailbox / CFWS)?)*

obs_addr_list
  = (CFWS? ",")* address ("," (address / CFWS)?)*

obs_group_list
  = (CFWS? ",")+ CFWS?

obs_local_part
  = word ("." word)*

obs_domain
  = atom ("." atom)*

obs_dtext
  = obs_NO_WS_CTL
  / quoted_pair
