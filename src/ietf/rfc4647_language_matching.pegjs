/*
 * Matching of Language Tags
 *
 * http://tools.ietf.org/html/rfc4647
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

/* 2.1.  Basic Language Range */
language_range
  = $(ALPHA_1_8_ ("-" alphanum_1_8_)*)
  / "*"

ALPHA_1_8_
  = $(ALPHA ALPHA? ALPHA? ALPHA? ALPHA? ALPHA? ALPHA? ALPHA?)

alphanum_1_8_
  = $(alphanum alphanum? alphanum? alphanum? alphanum? alphanum? alphanum? alphanum?)

alphanum
  = ALPHA
  / DIGIT

/* 2.2.  Extended Language Range */
extended_language_range
  = (ALPHA_1_8_ / "*") ("-" (alphanum_1_8_ / "*"))*
