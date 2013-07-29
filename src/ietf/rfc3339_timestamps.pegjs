/*
 * Date and Time on the Internet: Timestamps
 *
 * http://tools.ietf.org/html/rfc3339
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* 5.6. Internet Date/Time Format */
date_fullyear
  = $(DIGIT DIGIT DIGIT DIGIT)

date_month
  // 01-12
  = $(DIGIT DIGIT)

date_mday
  // 01-28, 01-29, 01-30, 01-31 based on
  // month/year
  = $(DIGIT DIGIT)

time_hour
  // 00-23
  = $(DIGIT DIGIT)

time_minute
  // 00-59
  = $(DIGIT DIGIT)

time_second
  // 00-58, 00-59, 00-60 based on leap second
  // rules
  = $(DIGIT DIGIT)

time_secfrac
  = "." $(DIGIT+)

time_numoffset
  = ("+" / "-") time_hour ":" time_minute

time_offset
  = "Z"
  / time_numoffset

partial_time
  = time_hour ":" time_minute ":" time_second time_secfrac?

full_date
  = date_fullyear "-" date_month "-" date_mday

full_time
  = partial_time time_offset

date_time
  = full_date "T" full_time


/* Appendix A. ISO 8601 Collected ABNF */
/* Date */
date_century
  // 00-99
  = $(DIGIT DIGIT)

date_decade
  // 0-9
  = DIGIT

date_subdecade
  // 0-9
  = DIGIT

date_year
  = date_decade date_subdecade

date_fullyear
  = date_century date_year

date_month
  // 01-12
  = $(DIGIT DIGIT)

date_wday
  // 1-7
  // 1 is Monday, 7 is Sunday
  = DIGIT

date_mday
  // 01-28, 01-29, 01-30, 01-31 based on
  // month/year
  = $(DIGIT DIGIT)

date_yday
  // 001-365, 001-366 based on year
  = $(DIGIT DIGIT DIGIT)

date_week
  // 01-52, 01-53 based on year
  = $(DIGIT DIGIT)

datepart_fullyear
  = date_century? date_year "-"?

datepart_ptyear
  = "-" (date_subdecade "-"?)?

datepart_wkyear
  = datepart_ptyear
  / datepart_fullyear

dateopt_century
  = "-"
  / date_century

dateopt_fullyear
  = "-"
  / datepart_fullyear

dateopt_year
  = "-"
  / date_year "-"?

dateopt_month
  = "-"
  / date_month "-"?

dateopt_week
  = "-"
  / date_week "-"?

datespec_full
  = datepart_fullyear date_month "-"? date_mday

datespec_year
  = date_century
  / dateopt_century date_year

datespec_month
  = "-" dateopt_year date_month ("-"? date_mday)

datespec_mday
  = "--" dateopt_month date_mday

datespec_week
  = datepart_wkyear "W" (date_week / dateopt_week date_wday)

datespec_wday
  = "---" date_wday

datespec_yday
  = dateopt_fullyear date_yday

date
  = datespec_full
  / datespec_year
  / datespec_month
  / datespec_mday
  / datespec_week
  / datespec_wday
  / datespec_yday


/* Time */
time_hour
  // 00-24
  = $(DIGIT DIGIT)

time_minute
  // 00-59
  = $(DIGIT DIGIT)

time_second
  // 00-58, 00-59, 00-60 based on
  // leap-second rules
  = $(DIGIT DIGIT)

time_fraction
  = ("," / ".") $(DIGIT+)

time_numoffset
  = ("+" / "-") time_hour (":"? time_minute)?

time_zone
  = "Z"
  / time_numoffset

timeopt_hour
  = "-"
  / time_hour ":"?

timeopt_minute
  = "-"
  / time_minute ":"?

timespec_hour
  = time_hour (":"? time_minute (":"? time_second)?)?

timespec_minute
  = timeopt_hour time_minute (":"? time_second)?

timespec_second
  = "-" timeopt_minute time_second

timespec_base
  = timespec_hour
  / timespec_minute
  / timespec_second

time
  = timespec_base time_fraction? time_zone?

iso_date_time
  = date "T" time


/* Durations */
dur_second
  = DIGIT+ "S"

dur_minute
  = DIGIT+ "M" dur_second?

dur_hour
  = DIGIT+ "H" dur_minute?

dur_time
  = "T" (dur_hour / dur_minute / dur_second)

dur_day
  = DIGIT+ "D"
dur_week
  = DIGIT+ "W"
dur_month
  = DIGIT+ "M" dur_day?

dur_year
  = DIGIT+ "Y" dur_month?

dur_date
  = (dur_day / dur_month / dur_year) dur_time?

duration
  = "P" (dur_date / dur_time / dur_week)


/* Periods */
period_explicit
  = iso_date_time "/" iso_date_time

period_start
  = iso_date_time "/" duration

period_end
  = duration "/" iso_date_time

period
  = period_explicit
  / period_start
  / period_end
