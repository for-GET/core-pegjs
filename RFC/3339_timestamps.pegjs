/*
 * Date and Time on the Internet: Timestamps
 *
 * http://tools.ietf.org/html/rfc3339
 */

// FIXME ABNF to PEGjs

/* 5.6. Internet Date/Time Format */
date-fullyear   = 4DIGIT
date-month      = 2DIGIT  ; 01-12
date-mday       = 2DIGIT  ; 01-28, 01-29, 01-30, 01-31 based on
                         ; month/year
time-hour       = 2DIGIT  ; 00-23
time-minute     = 2DIGIT  ; 00-59
time-second     = 2DIGIT  ; 00-58, 00-59, 00-60 based on leap second
                         ; rules
time-secfrac    = "." 1*DIGIT
time-numoffset  = ("+" / "-") time-hour ":" time-minute
time-offset     = "Z" / time-numoffset

partial-time    = time-hour ":" time-minute ":" time-second
                 [time-secfrac]
full-date       = date-fullyear "-" date-month "-" date-mday
full-time       = partial-time time-offset

date-time       = full-date "T" full-time


/* Appendix A. ISO 8601 Collected ABNF */
/* Date */
date-century    = 2DIGIT  ; 00-99
date-decade     =  DIGIT  ; 0-9
date-subdecade  =  DIGIT  ; 0-9
date-year       = date-decade date-subdecade
date-fullyear   = date-century date-year
date-month      = 2DIGIT  ; 01-12
date-wday       =  DIGIT  ; 1-7  ; 1 is Monday, 7 is Sunday
date-mday       = 2DIGIT  ; 01-28, 01-29, 01-30, 01-31 based on
                     ; month/year
date-yday       = 3DIGIT  ; 001-365, 001-366 based on year
date-week       = 2DIGIT  ; 01-52, 01-53 based on year

datepart-fullyear = [date-century] date-year ["-"]
datepart-ptyear   = "-" [date-subdecade ["-"]]
datepart-wkyear   = datepart-ptyear / datepart-fullyear

dateopt-century   = "-" / date-century
dateopt-fullyear  = "-" / datepart-fullyear
dateopt-year      = "-" / (date-year ["-"])
dateopt-month     = "-" / (date-month ["-"])
dateopt-week      = "-" / (date-week ["-"])
datespec-full     = datepart-fullyear date-month ["-"] date-mday
datespec-year     = date-century / dateopt-century date-year
datespec-month    = "-" dateopt-year date-month [["-"] date-mday]
datespec-mday     = "--" dateopt-month date-mday
datespec-week     = datepart-wkyear "W"
                  (date-week / dateopt-week date-wday)
datespec-wday     = "---" date-wday
datespec-yday     = dateopt-fullyear date-yday

date              = datespec-full / datespec-year
                  / datespec-month /
datespec-mday / datespec-week / datespec-wday / datespec-yday


/* Time */
time-hour         = 2DIGIT ; 00-24
time-minute       = 2DIGIT ; 00-59
time-second       = 2DIGIT ; 00-58, 00-59, 00-60 based on
                          ; leap-second rules
time-fraction     = ("," / ".") 1*DIGIT
time-numoffset    = ("+" / "-") time-hour [[":"] time-minute]
time-zone         = "Z" / time-numoffset

timeopt-hour      = "-" / (time-hour [":"])
timeopt-minute    = "-" / (time-minute [":"])

timespec-hour     = time-hour [[":"] time-minute [[":"] time-second]]
timespec-minute   = timeopt-hour time-minute [[":"] time-second]
timespec-second   = "-" timeopt-minute time-second
timespec-base     = timespec-hour / timespec-minute / timespec-second

time              = timespec-base [time-fraction] [time-zone]

iso-date-time     = date "T" time


/* Durations */
dur-second        = 1*DIGIT "S"
dur-minute        = 1*DIGIT "M" [dur-second]
dur-hour          = 1*DIGIT "H" [dur-minute]
dur-time          = "T" (dur-hour / dur-minute / dur-second)
dur-day           = 1*DIGIT "D"
dur-week          = 1*DIGIT "W"
dur-month         = 1*DIGIT "M" [dur-day]
dur-year          = 1*DIGIT "Y" [dur-month]
dur-date          = (dur-day / dur-month / dur-year) [dur-time]

duration          = "P" (dur-date / dur-time / dur-week)

/* Periods */
period-explicit   = iso-date-time "/" iso-date-time
period-start      = iso-date-time "/" duration
period-end        = duration "/" iso-date-time

period            = period-explicit / period-start / period-end
