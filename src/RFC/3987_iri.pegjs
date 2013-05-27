/*
 * Internationalized Resource Identifiers (IRIs)
 *
 * http://tools.ietf.org/html/rfc3987
 *
 * @append RFC/5324_abnf.pegjs
 */

// FIXME

ucschar
  = [\u00A0-\uD7FF]
  / [\uF900-\uFDCF]
  / [\uFDF0-\uFFEF]

  / [\u10000-\u1FFFD]
  / [\u20000-\u2FFFD]
  / [\u30000-\u3FFFD]

  / [\u40000-\u4FFFD]
  / [\u50000-\u5FFFD]
  / [\u60000-\u6FFFD]

  / [\u70000-\u7FFFD]
  / [\u80000-\u8FFFD]
  / [\u90000-\u9FFFD]

  / [\uA0000-\uAFFFD]
  / [\uB0000-\uBFFFD]
  / [\uC0000-\uCFFFD]

  / [\uD0000-\uDFFFD]
  / [\uE1000-\uEFFFD]

iprivate
  = [\uE000-\uF8FF]
  / [\uF0000-\uFFFFD]
  / [\u100000-\u10FFFD]
