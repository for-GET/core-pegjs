/*
 * YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF)
 *
 * http://tools.ietf.org/html/rfc6020
 *
 * Limitations & cleanup
 * - included errata
 * - *_str rules are wrapped in double quotes
 *
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

module_stmt
  = optsep module_keyword sep identifier_arg_str optsep "{" stmtsep module_header_stmts linkage_stmts meta_stmts revision_stmts body_stmts "}" optsep

submodule_stmt
  = optsep submodule_keyword sep identifier_arg_str optsep "{" stmtsep submodule_header_stmts linkage_stmts meta_stmts revision_stmts body_stmts "}" optsep

// these stmts can appear in any order
module_header_stmts
  = (yang_version_stmt stmtsep)? namespace_stmt stmtsep prefix_stmt stmtsep

// these stmts can appear in any order
submodule_header_stmts
  = (yang_version_stmt stmtsep)? belongs_to_stmt stmtsep

// these stmts can appear in any order
meta_stmts
  = (organization_stmt stmtsep)? (contact_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
linkage_stmts
  = (import_stmt stmtsep)* (include_stmt stmtsep)*

revision_stmts
  = (revision_stmt stmtsep)*

// CHANGE break apart
body_stmts
  = (body_stmt_ stmtsep)*

body_stmt_
  = extension_stmt
  / feature_stmt
  / identity_stmt
  / typedef_stmt
  / grouping_stmt
  / data_def_stmt
  / augment_stmt
  / rpc_stmt
  / notification_stmt
  / deviation_stmt

data_def_stmt
  = container_stmt
  / leaf_stmt
  / leaf_list_stmt
  / list_stmt
  / choice_stmt
  / anyxml_stmt
  / uses_stmt

yang_version_stmt
  = yang_version_keyword sep yang_version_arg_str optsep stmtend

yang_version_arg_str
  = yang_version_arg

yang_version_arg
  = "1"

import_stmt
  = import_keyword sep identifier_arg_str optsep "{" stmtsep prefix_stmt stmtsep (revision_date_stmt stmtsep)?
"}"

include_stmt
  = include_keyword sep identifier_arg_str optsep (";" / "{" stmtsep (revision_date_stmt stmtsep)? "}")

namespace_stmt
  = namespace_keyword sep uri_str optsep stmtend

uri_str
  = "\"" URI "\""

prefix_stmt
  = prefix_keyword sep prefix_arg_str optsep stmtend

belongs_to_stmt
  = belongs_to_keyword sep identifier_arg_str optsep "{" stmtsep prefix_stmt stmtsep "}"

organization_stmt
  = organization_keyword sep string optsep stmtend

contact_stmt
  = contact_keyword sep string optsep stmtend

description_stmt
  = description_keyword sep string optsep stmtend

reference_stmt
  = reference_keyword sep string optsep stmtend

units_stmt
  = units_keyword sep string optsep stmtend

// CHANGE break apart
revision_stmt
  = revision_keyword sep revision_date optsep (";" / "{" stmtsep revision_stmt_ "}")

revision_stmt_
  = (description_stmt stmtsep)? (reference_stmt stmtsep)?

revision_date
  = date_arg_str

revision_date_stmt
  = revision_date_keyword sep revision_date stmtend

// CHANGE break apart
extension_stmt
  = extension_keyword sep identifier_arg_str optsep (";" / "{" stmtsep extension_stmt_ "}")

// these stmts can appear in any order
extension_stmt_
  = (argument_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

argument_stmt
  = argument_keyword sep identifier_arg_str optsep (";" / "{" stmtsep (yin_element_stmt stmtsep)? "}")

yin_element_stmt
  = yin_element_keyword sep yin_element_arg_str stmtend

yin_element_arg_str
  = "\"" yin_element_arg "\""

yin_element_arg
  = true_keyword
  / false_keyword

// CHANGE break apart
identity_stmt
  = identity_keyword sep identifier_arg_str optsep
(";" /
"{" stmtsep
identity_stmt_
"}")

// these stmts can appear in any order
identity_stmt_
  = (base_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

base_stmt
  = base_keyword sep identifier_ref_arg_str optsep stmtend

// CHANGE break apart
feature_stmt
  = feature_keyword sep identifier_arg_str optsep
(";" /
"{" stmtsep
"}")

// these stmts can appear in any order
feature_stmt_
  = (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

if_feature_stmt
  = if_feature_keyword sep identifier_ref_arg_str optsep stmtend

// CHANGE break apart
typedef_stmt
  = typedef_keyword sep identifier_arg_str optsep "{" stmtsep typedef_stmt_ "}"

// these stmts can appear in any order
typedef_stmt_
  = type_stmt stmtsep (units_stmt stmtsep)? (default_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

type_stmt
  = type_keyword sep identifier_ref_arg_str optsep (";" / "{" stmtsep type_body_stmts "}")

type_body_stmts
  = numerical_restrictions
  / decimal64_specification
  / string_restrictions
  / enum_specification
  / leafref_specification
  / identityref_specification
  / instance_identifier_specification
  / bits_specification
  / union_specification
  / binary_specification

binary_specification
  = (length_stmt stmtsep)?

numerical_restrictions
  = range_stmt stmtsep

// CHANGE break apart
range_stmt
  = range_keyword sep range_arg_str optsep (";" / "{" stmtsep range_stmt_ "}")

// these stmts can appear in any order
range_stmt_
  = (error_message_stmt stmtsep)? (error_app_tag_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

  // these stmts can appear in any order
decimal64_specification
  = fraction_digits_stmt (range_stmt stmtsep)?

fraction_digits_stmt
  = fraction_digits_keyword sep fraction_digits_arg_str stmtend

fraction_digits_arg_str
  = "\"" fraction_digits_arg "\""

// CHANGE simplify ranges
fraction_digits_arg
  = "1" ([0-8])?
  / [2-9]

// these stmts can appear in any order
string_restrictions
  = (length_stmt stmtsep)? (pattern_stmt stmtsep)*

// CHANGE break apart
length_stmt
  = length_keyword sep length_arg_str optsep (";" / "{" stmtsep length_stmt_ "}")

// these stmts can appear in any order
length_stmt_
  = (error_message_stmt stmtsep)? (error_app_tag_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// CHANGE break apart
pattern_stmt
  = pattern_keyword sep string optsep (";" / "{" stmtsep pattern_stmt_ "}")

// these stmts can appear in any order
pattern_stmt_
  = (error_message_stmt stmtsep)? (error_app_tag_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

default_stmt
  = default_keyword sep string stmtend

enum_specification
  = (enum_stmt stmtsep)+

// CHANGE break apart
enum_stmt
  = enum_keyword sep string optsep (";" / "{" stmtsep enum_stmt_ "}")

// these stmts can appear in any order
enum_stmt_
  = (value_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

leafref_specification
  = path_stmt

path_stmt
  = path_keyword sep path_arg_str stmtend

require_instance_stmt
  = require_instance_keyword sep require_instance_arg_str stmtend

require_instance_arg_str
  = "\"" require_instance_arg "\""

require_instance_arg
  = true_keyword
  / false_keyword

instance_identifier_specification
  = (require_instance_stmt stmtsep)?

identityref_specification
  = base_stmt stmtsep

union_specification
  = (type_stmt stmtsep)+

bits_specification
  = (bit_stmt stmtsep)+

// CHANGE break apart
bit_stmt
  = bit_keyword sep identifier_arg_str optsep (";" / "{" stmtsep bit_stmt_ "}")

// these stmts can appear in any order
bit_stmt_
  = (position_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

position_stmt
  = position_keyword sep position_value_arg_str stmtend

position_value_arg_str
  = "\"" position_value_arg "\""

position_value_arg
  = non_negative_integer_value

status_stmt
  = status_keyword sep status_arg_str stmtend

status_arg_str
  = "\"" status_arg "\""

status_arg
  = current_keyword
  / obsolete_keyword
  / deprecated_keyword

config_stmt
  = config_keyword sep config_arg_str stmtend

config_arg_str
  = "\"" config_arg "\""

config_arg
  = true_keyword
  / false_keyword

mandatory_stmt
  = mandatory_keyword sep mandatory_arg_str stmtend

mandatory_arg_str
  = "\"" mandatory_arg "\""

mandatory_arg
  = true_keyword
  / false_keyword

presence_stmt
  = presence_keyword sep string stmtend

ordered_by_stmt
  = ordered_by_keyword sep ordered_by_arg_str stmtend

ordered_by_arg_str
  = "\"" ordered_by_arg "\""

ordered_by_arg
  = user_keyword
  / system_keyword

// CHANGE break apart
must_stmt
  = must_keyword sep string optsep (";" / "{" stmtsep must_stmt_ "}")

// these stmts can appear in any order
must_stmt_
  = (error_message_stmt stmtsep)? (error_app_tag_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

error_message_stmt
  = error_message_keyword sep string stmtend

error_app_tag_stmt
  = error_app_tag_keyword sep string stmtend

min_elements_stmt
  = min_elements_keyword sep min_value_arg_str stmtend

min_value_arg_str
  = "\"" min_value_arg "\""

min_value_arg
  = non_negative_integer_value

max_elements_stmt
  = max_elements_keyword sep max_value_arg_str stmtend

max_value_arg_str
  = "\"" max_value_arg "\""

max_value_arg
  = unbounded_keyword
  / positive_integer_value

value_stmt
  = value_keyword sep integer_value_arg_str stmtend

integer_value_arg_str
  = "\"" integer_value_arg "\""

integer_value_arg
  = integer_value

// CHANGE break apart
grouping_stmt
  = grouping_keyword sep identifier_arg_str optsep (";" / "{" stmtsep grouping_stmt_ "}")

// these stmts can appear in any order
grouping_stmt_
  = (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)*

// CHANGE break apart
container_stmt
  = container_keyword sep identifier_arg_str optsep (";" / "{" stmtsep container_stmt_ "}")

// these stmts can appear in any order
container_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (must_stmt stmtsep)* (presence_stmt stmtsep)? (config_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)*

// CHANGE break apart
leaf_stmt
  = leaf_keyword sep identifier_arg_str optsep "{" stmtsep leaf_stmt_ "}"

// these stmts can appear in any order
leaf_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* type_stmt stmtsep (units_stmt stmtsep)? (must_stmt stmtsep)* (default_stmt stmtsep)?
(config_stmt stmtsep)? (mandatory_stmt stmtsep)? (status_stmt stmtsep)?
(description_stmt stmtsep)? (reference_stmt stmtsep)?

// CHANGE break apart
leaf_list_stmt
  = leaf_list_keyword sep identifier_arg_str optsep "{" stmtsep leaf_list_stmt_ "}"

// these stmts can appear in any order
leaf_list_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* type_stmt stmtsep (units_stmt stmtsep)? (must_stmt stmtsep)* (config_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)? (ordered_by_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// CHANGE break apart
list_stmt
  = list_keyword sep identifier_arg_str optsep "{" stmtsep list_stmt_ "}"

// these stmts can appear in any order
list_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (must_stmt stmtsep)* (key_stmt stmtsep)? (unique_stmt stmtsep)* (config_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)? (ordered_by_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)+

key_stmt
  = key_keyword sep key_arg_str stmtend

key_arg_str
  = "\"" key_arg "\""

key_arg
  = node_identifier (sep node_identifier)*

unique_stmt
  = unique_keyword sep unique_arg_str stmtend

unique_arg_str
  = "\"" unique_arg "\""

unique_arg
  = descendant_schema_nodeid (sep descendant_schema_nodeid)*

// CHANGE break apart
choice_stmt
  = choice_keyword sep identifier_arg_str optsep (";" / "{" stmtsep choice_stmt_ "}")

// these stmts can appear in any order
choice_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (default_stmt stmtsep)? (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((short_case_stmt / case_stmt) stmtsep)*

short_case_stmt
  = container_stmt
  / leaf_stmt
  / leaf_list_stmt
  / list_stmt
  / anyxml_stmt

// CHANGE break apart
case_stmt
  = case_keyword sep identifier_arg_str optsep (";" / "{" stmtsep case_stmt_ "}")

// these stmts can appear in any order
case_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? (data_def_stmt stmtsep)*

// CHANGE break apart
anyxml_stmt
  = anyxml_keyword sep identifier_arg_str optsep (";" / "{" stmtsep anyxml_stmt_ "}")

// these stmts can appear in any order
anyxml_stmt_
  = (when_stmt stmtsep)?
(if_feature_stmt stmtsep)*
(must_stmt stmtsep)*
(config_stmt stmtsep)?
(mandatory_stmt stmtsep)?
(status_stmt stmtsep)?
(description_stmt stmtsep)?
(reference_stmt stmtsep)?

// CHANGE break apart
uses_stmt
  = uses_keyword sep identifier_ref_arg_str optsep (";" / "{" stmtsep uses_stmt_ "}")

// these stmts can appear in any order
uses_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? (refine_stmt stmtsep)* (uses_augment_stmt stmtsep)*

// CHANGE break apart
refine_stmt
  = refine_keyword sep refine_arg_str optsep (";" / "{" stmtsep refine_stmt_ "}")

refine_stmt_
  = refine_container_stmts
  / refine_leaf_stmts
  / refine_leaf_list_stmts
  / refine_list_stmts
  / refine_choice_stmts
  / refine_case_stmts
  / refine_anyxml_stmts

refine_arg_str
  = "\"" refine_arg "\""

refine_arg
  = descendant_schema_nodeid

// these stmts can appear in any order
refine_container_stmts
  = (must_stmt stmtsep)* (presence_stmt stmtsep)? (config_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_leaf_stmts
  = (must_stmt stmtsep)* (default_stmt stmtsep)? (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_leaf_list_stmts
  = (must_stmt stmtsep)* (config_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_list_stmts
  = (must_stmt stmtsep)* (config_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_choice_stmts
  = (default_stmt stmtsep)? (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_case_stmts
  = (description_stmt stmtsep)? (reference_stmt stmtsep)?

// these stmts can appear in any order
refine_anyxml_stmts
  = (must_stmt stmtsep)* (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)?

// CHANGE break apart
uses_augment_stmt
  = augment_keyword sep uses_augment_arg_str optsep "{" stmtsep uses_augment_stmt_ "}"

// these stmts can appear in any order
uses_augment_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((data_def_stmt stmtsep) / (case_stmt stmtsep))+

uses_augment_arg_str
  = "\"" uses_augment_arg "\""

uses_augment_arg
  = descendant_schema_nodeid

// CHANGE break apart
augment_stmt
  = augment_keyword sep augment_arg_str optsep "{" stmtsep augment_stmt_ "}"

// these stmts can appear in any order
augment_stmt_
  = (when_stmt stmtsep)? (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((data_def_stmt stmtsep) / (case_stmt stmtsep))+

augment_arg_str
  = "\"" augment_arg "\""

augment_arg
  = absolute_schema_nodeid

unknown_statement
  = prefix ":" identifier [sep string] optsep (";" / "{" *unknown_statement2 "}")

unknown_statement2
  = [prefix ":"] identifier [sep string] optsep (";" / "{" *unknown_statement2 "}")

// CHANGE break apart
when_stmt
  = when_keyword sep string optsep (";" / "{" stmtsep when_stmt_ "}")

// these stmts can appear in any order
when_stmt_
  = (description_stmt stmtsep)? (reference_stmt stmtsep)?

// CHANGE break apart
rpc_stmt
  = rpc_keyword sep identifier_arg_str optsep (";" / "{" stmtsep rpc_stmt_ "}")

// these stmts can appear in any order
rpc_stmt_
  = (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((typedef_stmt / grouping_stmt) stmtsep)* (input_stmt stmtsep)? (output_stmt stmtsep)?

// CHANGE break apart
input_stmt
  = input_keyword optsep "{" stmtsep input_stmt_ "}"

// these stmts can appear in any order
input_stmt_
  = ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)+

// CHANGE break apart
output_stmt
  = output_keyword optsep "{" stmtsep output_stmt_ "}"

// these stmts can appear in any order
output_stmt_
  = ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)+

// CHANGE break apart
notification_stmt
  = notification_keyword sep identifier_arg_str optsep (";" / "{" stmtsep notification_stmt_ "}")

// these stmts can appear in any order
notification_stmt_
  = (if_feature_stmt stmtsep)* (status_stmt stmtsep)? (description_stmt stmtsep)? (reference_stmt stmtsep)? ((typedef_stmt / grouping_stmt) stmtsep)* (data_def_stmt stmtsep)*

// CHANGE break apart
deviation_stmt
  = deviation_keyword sep deviation_arg_str optsep "{" stmtsep deviation_stmt_ "}"

// these stmts can appear in any order
deviation_stmt_
  = (description_stmt stmtsep)? (reference_stmt stmtsep)? (deviate_not_supported_stmt / (deviate_add_stmt / deviate_replace_stmt / deviate_delete_stmt)+)

deviation_arg_str
  = "\"" deviation_arg "\""

deviation_arg
  = absolute_schema_nodeid

deviate_not_supported_stmt
  = deviate_keyword sep not_supported_keyword optsep (";" / "{" stmtsep
"}")

// CHANGE break apart
deviate_add_stmt
  = deviate_keyword sep add_keyword optsep (";" / "{" stmtsep deviate_add_stmt_ "}")

// these stmts can appear in any order
deviate_add_stmt_
  = (units_stmt stmtsep)? (must_stmt stmtsep)* (unique_stmt stmtsep)* (default_stmt stmtsep)? (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)?

// CHANGE break apart
deviate_delete_stmt
  = deviate_keyword sep delete_keyword optsep (";" / "{" stmtsep deviate_delete_stmt_ "}")

// these stmts can appear in any order
deviate_delete_stmt_
  = (units_stmt stmtsep)? (must_stmt stmtsep)* (unique_stmt stmtsep)* (default_stmt stmtsep)?

// CHANGE break apart
deviate_replace_stmt
  = deviate_keyword sep replace_keyword optsep (";" / "{" stmtsep deviate_replace_stmt_ "}")

// these stmts can appear in any order
deviate_replace_stmt_
  = (type_stmt stmtsep)? (units_stmt stmtsep)? (default_stmt stmtsep)? (config_stmt stmtsep)? (mandatory_stmt stmtsep)? (min_elements_stmt stmtsep)? (max_elements_stmt stmtsep)?

// Ranges

range_arg_str
  = "\"" range_arg "\""

range_arg
  = range_part (optsep "|" optsep range_part)*

range_part
  = range_boundary (optsep ".." optsep range_boundary)?

range_boundary
  = min_keyword
  / max_keyword
  / integer_value
  / decimal_value

// Lengths

length_arg_str
  = "\"" length_arg "\""

length_arg
  = length_part (optsep "|" optsep length_part)*

length_part
  = length_boundary (optsep ".." optsep length_boundary)?

length_boundary
  = min_keyword
  / max_keyword
  / non_negative_integer_value

// Date

date_arg_str
  = "\"" date_arg "\""

date_arg
  = DIGIT DIGIT DIGIT DIGIT "-" DIGIT DIGIT "-" DIGIT DIGIT

// Schema Node Identifiers

schema_nodeid
  = absolute_schema_nodeid
  / descendant_schema_nodeid

absolute_schema_nodeid
  = ("/" node_identifier)+

descendant_schema_nodeid
  = node_identifier (absolute_schema_nodeid)?

node_identifier
  = (prefix ":")? identifier

// Instance Identifiers

instance_identifier
  = ("/" (node_identifier *predicate))+

predicate
  = "[" WSP* (predicate_expr / pos) WSP* "]"

predicate_expr
  = (node_identifier / ".") WSP* "=" WSP* ((DQUOTE string DQUOTE) / (SQUOTE string SQUOTE))

pos
  = non_negative_integer_value

// leafref path

path_arg_str
  = "\"" path_arg "\""

path_arg
  = absolute_path
  / relative_path

absolute_path
  = ("/" (node_identifier *path_predicate))+

relative_path
  = (".." "/")+ descendant_path

descendant_path
  = node_identifier (path_predicate* absolute_path)?

path_predicate
  = "[" WSP* path_equality_expr WSP* "]"

path_equality_expr
  = node_identifier WSP* "=" WSP* path_key_expr

path_key_expr
  = current_function_invocation WSP* "/" WSP* rel_path_keyexpr

rel_path_keyexpr
  = (".." *WSP "/" *WSP)+ (node_identifier WSP* "/" WSP*)* node_identifier

// Keywords, using abnfgen's syntax for case_sensitive strings

// statement keywords
anyxml_keyword
  = "anyxml"
argument_keyword
  = "argument"
augment_keyword
  = "augment"
base_keyword
  = "base"
belongs_to_keyword
  = "belongs_to"
bit_keyword
  = "bit"
case_keyword
  = "case"
choice_keyword
  = "choice"
config_keyword
  = "config"
contact_keyword
  = "contact"
container_keyword
  = "container"
default_keyword
  = "default"
description_keyword
  = "description"
enum_keyword
  = "enum"
error_app_tag_keyword
  = "error_app_tag"
error_message_keyword
  = "error_message"
extension_keyword
  = "extension"
deviation_keyword
  = "deviation"
deviate_keyword
  = "deviate"
feature_keyword
  = "feature"
fraction_digits_keyword
  = "fraction_digits"
grouping_keyword
  = "grouping"
identity_keyword
  = "identity"
if_feature_keyword
  = "if_feature"
import_keyword
  = "import"
include_keyword
  = "include"
input_keyword
  = "input"
key_keyword
  = "key"
leaf_keyword
  = "leaf"
leaf_list_keyword
  = "leaf_list"
length_keyword
  = "length"
list_keyword
  = "list"
mandatory_keyword
  = "mandatory"
max_elements_keyword
  = "max_elements"
min_elements_keyword
  = "min_elements"
module_keyword
  = "module"
must_keyword
  = "must"
namespace_keyword
  = "namespace"
notification_keyword
  = "notification"
ordered_by_keyword
  = "ordered_by"
organization_keyword
  = "organization"
output_keyword
  = "output"
path_keyword
  = "path"
pattern_keyword
  = "pattern"
position_keyword
  = "position"
prefix_keyword
  = "prefix"
presence_keyword
  = "presence"
range_keyword
  = "range"
reference_keyword
  = "reference"
refine_keyword
  = "refine"
require_instance_keyword
  = "require_instance"
revision_keyword
  = "revision"
revision_date_keyword
  = "revision_date"
rpc_keyword
  = "rpc"
status_keyword
  = "status"
submodule_keyword
  = "submodule"
type_keyword
  = "type"
typedef_keyword
  = "typedef"
unique_keyword
  = "unique"
units_keyword
  = "units"
uses_keyword
  = "uses"
value_keyword
  = "value"
when_keyword
  = "when"
yang_version_keyword
  = "yang_version"
yin_element_keyword
  = "yin_element"

// other keywords

add_keyword
  = "add"
current_keyword
  = "current"
delete_keyword
  = "delete"
deprecated_keyword
  = "deprecated"
false_keyword
  = "false"
max_keyword
  = "max"
min_keyword
  = "min"
not_supported_keyword
  = "not_supported"
obsolete_keyword
  = "obsolete"
replace_keyword
  = "replace"
system_keyword
  = "system"
true_keyword
  = "true"
unbounded_keyword
  = "unbounded"
user_keyword
  = "user"

current_function_invocation
  = current_keyword *WSP "(" *WSP ")"

// Basic Rules

prefix_arg_str
  = "\"" prefix_arg "\""

prefix_arg
  = prefix

prefix
  = identifier

// CHANGE this rule should NOT be wrapped in quotes
identifier_arg_str
  = identifier_arg

identifier_arg
  = identifier

// An identifier MUST NOT start with (('X'|'x') ('M'|'m') ('L'|'l'))
identifier
  = (ALPHA / "_") (ALPHA / DIGIT / "_" / "-" / ".")*

identifier_ref_arg_str
  = "\"" identifier_ref_arg "\""

identifier_ref_arg
  = (prefix ":")? identifier

// CHANGE restrict to non " chars
string
  = "\"" [^"]* "\""

integer_value
  = "-" non_negative_integer_value
  / non_negative_integer_value

non_negative_integer_value
  = "0"
  / positive_integer_value

positive_integer_value
  = non_zero_digit DIGIT*

zero_integer_value
  = DIGIT+

stmtend
  = ";"
  / "{" unknown_statement* "}"

// unconditional separator
sep
  = (WSP / line_break)+

optsep
  = (WSP / line_break)*

stmtsep
  = (WSP / line_break / unknown_statement)*

line_break
  = CRLF
  / LF

non_zero_digit
  = [1-9]

decimal_value
  = integer_value ("." zero_integer_value)

// ' (Single Quote)
SQUOTE
  = "'"
