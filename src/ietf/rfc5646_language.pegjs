/*
 * Tags for Identifying Languages
 *
 * http://tools.ietf.org/html/rfc5646
 *
 * @append ietf/rfc5234_core_abnf.pegjs
 */

language_tag
  = langtag       // normal language tags
  / privateuse    // private use tag
  / grandfathered // grandfathered tags

langtag
  = language
    ("-" script)?
    ("-" region)?
    ("-" variant)*
    ("-" extension)*
    ("-" privateuse)?

language
  = $(ALPHA ALPHA ALPHA?)                                     // shortest ISO 639 code
    ("-" extlang)?                                            // sometimes followed by
                                                              // extended language subtags
  / $(ALPHA ALPHA ALPHA ALPHA)                                // or reserved for future use
  / $(ALPHA ALPHA ALPHA ALPHA ALPHA (ALPHA (ALPHA ALPHA?)?)?) // or registered language subtag

extlang
  = $(ALPHA ALPHA ALPHA)                // selected ISO 639 codes
    (hyphen_ALPHA_3_ hyphen_ALPHA_3_?)? // permanently reserved

hyphen_ALPHA_3_
  = "-" $(ALPHA ALPHA ALPHA)

script
  = $(ALPHA ALPHA ALPHA ALPHA) // ISO 15924 code

region
  = $(ALPHA ALPHA)       // ISO 3166-1 code
  / $(DIGIT DIGIT DIGIT) // UN M.49 code

variant
  = $(alphanum alphanum alphanum alphanum alphanum (alphanum (alphanum alphanum?)?)?) // registered variants
  / $(DIGIT alphanum alphanum alphanum)

extension
  = singleton ("-" $(alphanum alphanum (alphanum (alphanum (alphanum (alphanum (alphanum alphanum?)?)?)?)?)?))+

// Single alphanumerics
// "x" reserved for private use
singleton
  = DIGIT       // 0 - 9
  / [\x41-\x57] // A - W
  / [\x59-\x5A] // Y - Z
  / [\x61-\x77] // a - w
  / [\x79-\x7A] // y - z

privateuse
  = "x" ("-" $(alphanum (alphanum (alphanum (alphanum (alphanum (alphanum (alphanum alphanum?)?)?)?)?)?)?))+

grandfathered
  = irregular // non-redundant tags registered
  / regular   // during the RFC 3066 era

irregular
  = "en-GB-oed"  // irregular tags do not match
  / "i-ami"      // the 'langtag' production and
  / "i-bnn"      // would not otherwise be
  / "i-default"  // considered 'well-formed'
  / "i-enochian" // These tags are all valid,
  / "i-hak"      // but most are deprecated
  / "i-klingon"  // in favor of more modern
  / "i-lux"      // subtags or subtag
  / "i-mingo"    // combination
  / "i-navajo"
  / "i-pwn"
  / "i-tao"
  / "i-tay"
  / "i-tsu"
  / "sgn-BE-FR"
  / "sgn-BE-NL"
  / "sgn-CH-DE"

regular
  = "art-lojban"  // these tags match the 'langtag'
  / "cel-gaulish" // production, but their subtags
  / "no-bok"      // are not extended language
  / "no-nyn"      // or variant subtags: their meaning
  / "zh-guoyu"    // is defined by their registration
  / "zh-hakka"    // and all of these are deprecated
  / "zh-min"      // in favor of a more modern
  / "zh-min-nan"  // subtag or sequence of subtags
  / "zh-xiang"

alphanum
  // letters and numbers
  = ALPHA
  / DIGIT
