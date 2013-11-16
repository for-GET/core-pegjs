/*
 * Date and Time on the Internet: Timestamps
 *
 * http://tools.ietf.org/html/rfc3339
 *
 * @append ietf/rfc5234-core-abnf.pegjs
 */

/* http://tools.ietf.org/html/rfc3339#section-5.6 Internet Date/Time Format */
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
