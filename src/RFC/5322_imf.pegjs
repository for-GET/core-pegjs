/*
 * Internet Message Format
 *
 * http://tools.ietf.org/html/rfc5322
 *
 * @append RFC/5324_abnf.pegjs
 */

/* 3.2.1.  Quoted characters */
quoted_pair
  = "\\" (VCHAR / WSP)
  / obs_qp

/* 3.2.2.  Folding White Space and Comments */
FWS
  // Folding white space
  = (WSP* CRLF)? WSP+
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
  = FWS DIGIT DIGIT DIGIT DIGIT+ FWS
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
  = FWS ("+" / "-") DIGIT DIGIT DIGIT DIGIT
  / obs_zone


/* 4.1.  Miscellaneous Obsolete Tokens */
obs_NO_WS_CTL
  = [\x01-\x08] // US-ASCII control
  "\x0B"        // characters that do not
  "\x0C"        // include the carriage
  / [\x0E-\x1F] // return, line feed, and
  / "\x7F"      // white space characters

obs_ctext
  = obs_NO_WS_CTL

obs_qp
  = "\\" ("\x00" / obs_NO_WS_CTL / LF / CR)

/*
FIXME
obs-qtext       =   obs-NO-WS-CTL

obs-utext       =   %d0 / obs-NO-WS-CTL / VCHAR


obs-body        =   *((*LF *CR *((%d0 / text) *LF *CR)) / CRLF)

obs-unstruct    =   *((*LF *CR *(obs-utext *LF *CR)) / FWS)
obs-phrase      =   word *(word / "." / CFWS)

obs-phrase-list =   [phrase / CFWS] *("," [phrase / CFWS])
*/


/* 4.2.  Obsolete Folding White Space */
obs_FWS
  = WSP+ (CRLF WSP+)*


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
  =
/*
FIXME
obs-zone        =   "UT" / "GMT" /     ; Universal Time
; North American UT
; offsets
"EST" / "EDT" /    ; Eastern:  - 5/ - 4
"CST" / "CDT" /    ; Central:  - 6/ - 5
"MST" / "MDT" /    ; Mountain: - 7/ - 6
"PST" / "PDT" /    ; Pacific:  - 8/ - 7
;
%d65-73 /          ; Military zones - "A"
%d75-90 /          ; through "I" and "K"
%d97-105 /         ; through "Z", both
%d107-122          ; upper and lower case
*/
