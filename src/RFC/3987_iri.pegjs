/*
 * Internationalized Resource Identifiers (IRIs)
 *
 * http://tools.ietf.org/html/rfc3987
 *
 * @append RFC/5324_abnf.pegjs
 */

// FIXME

ucschar
  = [\xA0-\xD7FF]
  / [\xF900-\xFDCF]
  / [\xFDF0-\xFFEF]

  / [\x10000-\x1FFFD]
  / [\x20000-\x2FFFD]
  / [\x30000-\x3FFFD]

  / [\x40000-\x4FFFD]
  / [\x50000-\x5FFFD]
  / [\x60000-\x6FFFD]

  / [\x70000-\x7FFFD]
  / [\x80000-\x8FFFD]
  / [\x90000-\x9FFFD]

  / [\xA0000-\xAFFFD]
  / [\xB0000-\xBFFFD]
  / [\xC0000-\xCFFFD]

  / [\xD0000-\xDFFFD]
  / [\xE1000-\xEFFFD]

iprivate
  = [\xE000-\xF8FF]
  / [\xF0000-\xFFFFD]
  / [\x100000-\x10FFFD]
