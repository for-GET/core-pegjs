/*
 * Tokenized Multi Header
 *
 * Accept-*
 * Cache-Control
 * If-Match
 * If-None-Match
 *
 * @append generic/char.pegjs
 */

tokenized_header
  = _ fields:fields* _
  { return fields }

fields
  = _ head:field tail:(_ field_separator field)*
  {
    var fields = [], field, i;
    field = head;
    fields.push(field);
    for (i = 0; i < tail.length; i++) {
      field = tail[i][2];
      fields.push(field);
    }
    return fields;
  }

field
  = _ token:field_token parameters:parameters?
  { return {
    token: token,
    parameters: parameters || {}
  } }

field_token
  = parameter
  / token

field_separator
  = ","


/* Parameters */
parameters
  = _ parameter_separator _ head:parameter tail:(_ parameter_separator parameter)*
  {
    var parameters = {}, parameter, i;
    parameter = head;
    parameters[parameter.attribute] = parameter.value;
    for (i = 0; i < tail.length; i++) {
      parameter = tail[i][2];
      parameters[parameter.attribute] = parameter.value;
    }
    return parameters;
  }

parameter
  = _ parameter:parameter_token
  { return parameter }

parameter_token
  = attribute_value_pair
  / token

parameter_separator
  = ";"


/* Misc */

header_attribute_value_pair
  = expires_maxage_attribute_value_pair
  / attribute_value_pair

expires_maxage_attribute_value_pair
  = _ attribute:("expires"i / "max-age"i) attribute_value_separator value:date_token
  { return {
    attribute: attribute,
    value: value
  } }

date_token
  // http://tools.ietf.org/html/rfc2109#section-10.1.2
  = day:[a-z]i "," token:token
  { return day.concat([","], token).join("") }


attribute_value_pair
  = expires_maxage_attribute_value_pair
  / _ attribute:attribute attribute_value_separator value:value
  { return {
    attribute: attribute,
    value: value
  } }

attribute
  = _ attribute:token
  { return attribute.toLowerCase() }

value
  = token
  / quoted_string

attribute_value_separator
  = "="

token
  = token:[^ =,;]+
  { return token.join("") }

quoted_string
  = '"' value:[^"]+ '"'
  { return value.join("") }

