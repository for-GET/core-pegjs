/*
 * YANG - A Data Modeling Language for the Network Configuration Protocol (NETCONF)
 *
 * http://tools.ietf.org/html/rfc6020
 *
 * Limitations & cleanup
 * - included errata
 * - *_str rules are optionally wrapped in quotes
 * - doesn't check for repetition count of statements where "these stmts can appear in any order"
 *
 * @append ietf/rfc3986-uri.pegjs
 * @append ietf/rfc5234-core-abnf.pegjs
 */

module_stmt
  = optsep module_keyword sep identifier_arg_str optsep "{" stmtsep module_header_stmts linkage_stmts meta_stmts revision_stmts body_stmts "}" optsep

submodule_stmt
  = optsep submodule_keyword sep identifier_arg_str optsep "{" stmtsep submodule_header_stmts linkage_stmts meta_stmts revision_stmts body_stmts "}" optsep

// these stmts can appear in any order
// CHANGE don't check repetition count
module_header_stmts
  = (module_header_stmt_ stmtsep)*

module_header_stmt_
  = yang_version_stmt
  / namespace_stmt
  / prefix_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
submodule_header_stmts
  = (submodule_header_stmt_ stmtsep)*

submodule_header_stmt_
  = yang_version_stmt
  / belongs_to_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
meta_stmts
  = (meta_stmt_ stmtsep)*

meta_stmt_
  = organization_stmt
  / contact_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
linkage_stmts
  = (linkage_stmt_ stmtsep)*

linkage_stmt_
  = import_stmt
  / include_stmt

revision_stmts
  = (revision_stmt stmtsep)*

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
  = DQUOTE URI DQUOTE
  / SQUOTE URI SQUOTE
  / URI

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

revision_stmt
  = revision_keyword sep revision_date optsep (";" / "{" stmtsep revision_stmt_subs_ "}")

// CHANGE order doesn't matter
// CHANGE don't check repetition count
revision_stmt_subs_
  = (revision_stmt_sub_ stmtsep)*

revision_stmt_sub_
  = description_stmt
  / reference_stmt

revision_date
  = date_arg_str

revision_date_stmt
  = revision_date_keyword sep revision_date stmtend

extension_stmt
  = extension_keyword sep identifier_arg_str optsep (";" / "{" stmtsep extension_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
extension_stmt_subs_
  = (extension_stmt_sub_ stmtsep)*

extension_stmt_sub_
  = argument_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

argument_stmt
  = argument_keyword sep identifier_arg_str optsep (";" / "{" stmtsep (yin_element_stmt stmtsep)? "}")

yin_element_stmt
  = yin_element_keyword sep yin_element_arg_str stmtend

yin_element_arg_str
  = DQUOTE yin_element_arg DQUOTE
  / SQUOTE yin_element_arg SQUOTE
  / yin_element_arg

yin_element_arg
  = true_keyword
  / false_keyword

identity_stmt
  = identity_keyword sep identifier_arg_str optsep (";" / "{" stmtsep identity_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
identity_stmt_subs_
  = (identity_stmt_sub_ stmtsep)*

identity_stmt_sub_
  = base_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

base_stmt
  = base_keyword sep identifier_ref_arg_str optsep stmtend

feature_stmt
  = feature_keyword sep identifier_arg_str optsep (";" / "{" stmtsep feature_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
feature_stmt_subs_
  = (feature_stmt_sub_ stmtsep)*

feature_stmt_sub_
  = if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

if_feature_stmt
  = if_feature_keyword sep identifier_ref_arg_str optsep stmtend

typedef_stmt
  = typedef_keyword sep identifier_arg_str optsep "{" stmtsep typedef_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
typedef_stmt_subs_
  = (typedef_stmt_sub_ stmtsep)*

typedef_stmt_sub_
  = type_stmt
  / units_stmt
  / default_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

type_stmt
  = type_keyword sep identifier_ref_arg_str optsep (";" / "{" stmtsep type_body_stmts "}")

// CHANGE add empty body alternative
// CHANGE to counteract making all *_restrictions/*_specification rule required
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
  / stmtsep

// CHANGE required
binary_specification
  = length_stmt stmtsep

numerical_restrictions
  = range_stmt stmtsep

range_stmt
  = range_keyword sep range_arg_str optsep (";" / "{" stmtsep range_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
range_stmt_subs_
  = (range_stmt_sub_ stmtsep)*

range_stmt_sub_
  = error_message_stmt
  / error_app_tag_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
decimal64_specification
  = fraction_digits_stmt (range_stmt stmtsep)?

fraction_digits_stmt
  = fraction_digits_keyword sep fraction_digits_arg_str stmtend

fraction_digits_arg_str
  = DQUOTE fraction_digits_arg DQUOTE
  / SQUOTE fraction_digits_arg SQUOTE
  / fraction_digits_arg

// CHANGE simplify ranges
fraction_digits_arg
  = $("1" ([0-8])?)
  / [2-9]

// these stmts can appear in any order
// CHANGE required
// CHANGE don't check repetition count
string_restrictions
  = (string_restriction_ stmtsep)+

string_restriction_
  = length_stmt
  / pattern_stmt

length_stmt
  = length_keyword sep length_arg_str optsep (";" / "{" stmtsep length_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
length_stmt_subs_
  = (length_stmt_sub_ stmtsep)*

length_stmt_sub_
  = error_message_stmt
  / error_app_tag_stmt
  / description_stmt
  / reference_stmt

pattern_stmt
  = pattern_keyword sep string optsep (";" / "{" stmtsep pattern_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
pattern_stmt_subs_
  = (pattern_stmt_sub_ stmtsep)*

pattern_stmt_sub_
  = error_message_stmt
  / error_app_tag_stmt
  / description_stmt
  / reference_stmt

default_stmt
  = default_keyword sep string stmtend

enum_specification
  = (enum_stmt stmtsep)+

enum_stmt
  = enum_keyword sep string optsep (";" / "{" stmtsep enum_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
enum_stmt_subs_
  = (enum_stmt_sub_ stmtsep)*

enum_stmt_sub_
  = value_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

leafref_specification
  = path_stmt

path_stmt
  = path_keyword sep path_arg_str stmtend

require_instance_stmt
  = require_instance_keyword sep require_instance_arg_str stmtend

require_instance_arg_str
  = DQUOTE require_instance_arg DQUOTE
  / SQUOTE require_instance_arg SQUOTE
  / require_instance_arg

require_instance_arg
  = true_keyword
  / false_keyword

// CHANGE required
instance_identifier_specification
  = require_instance_stmt stmtsep

identityref_specification
  = base_stmt stmtsep

union_specification
  = (type_stmt stmtsep)+

bits_specification
  = (bit_stmt stmtsep)+

bit_stmt
  = bit_keyword sep identifier_arg_str optsep (";" / "{" stmtsep bit_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
bit_stmt_subs_
  = (bit_stmt_sub_ stmtsep)*

bit_stmt_sub_
  = position_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

position_stmt
  = position_keyword sep position_value_arg_str stmtend

position_value_arg_str
  = DQUOTE position_value_arg DQUOTE
  / SQUOTE position_value_arg SQUOTE
  / position_value_arg

position_value_arg
  = non_negative_integer_value

status_stmt
  = status_keyword sep status_arg_str stmtend

status_arg_str
  = DQUOTE status_arg DQUOTE
  / SQUOTE status_arg SQUOTE
  / status_arg

status_arg
  = current_keyword
  / obsolete_keyword
  / deprecated_keyword

config_stmt
  = config_keyword sep config_arg_str stmtend

config_arg_str
  = DQUOTE config_arg DQUOTE
  / SQUOTE config_arg SQUOTE
  / config_arg

config_arg
  = true_keyword
  / false_keyword

mandatory_stmt
  = mandatory_keyword sep mandatory_arg_str stmtend

mandatory_arg_str
  = DQUOTE mandatory_arg DQUOTE
  / SQUOTE mandatory_arg SQUOTE
  / mandatory_arg

mandatory_arg
  = true_keyword
  / false_keyword

presence_stmt
  = presence_keyword sep string stmtend

ordered_by_stmt
  = ordered_by_keyword sep ordered_by_arg_str stmtend

ordered_by_arg_str
  = DQUOTE ordered_by_arg DQUOTE
  / SQUOTE ordered_by_arg SQUOTE
  / ordered_by_arg

ordered_by_arg
  = user_keyword
  / system_keyword

must_stmt
  = must_keyword sep string optsep (";" / "{" stmtsep must_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
must_stmt_subs_
  = (must_stmt_sub_ stmtsep)*

must_stmt_sub_
  = error_message_stmt
  / error_app_tag_stmt
  / description_stmt
  / reference_stmt

error_message_stmt
  = error_message_keyword sep string stmtend

error_app_tag_stmt
  = error_app_tag_keyword sep string stmtend

min_elements_stmt
  = min_elements_keyword sep min_value_arg_str stmtend

min_value_arg_str
  = DQUOTE min_value_arg DQUOTE
  / SQUOTE min_value_arg SQUOTE
  / min_value_arg

min_value_arg
  = non_negative_integer_value

max_elements_stmt
  = max_elements_keyword sep max_value_arg_str stmtend

max_value_arg_str
  = DQUOTE max_value_arg DQUOTE
  / SQUOTE max_value_arg SQUOTE
  / max_value_arg

max_value_arg
  = unbounded_keyword
  / positive_integer_value

value_stmt
  = value_keyword sep integer_value_arg_str stmtend

integer_value_arg_str
  = DQUOTE integer_value_arg DQUOTE
  / SQUOTE integer_value_arg SQUOTE
  / integer_value_arg

integer_value_arg
  = integer_value

grouping_stmt
  = grouping_keyword sep identifier_arg_str optsep (";" / "{" stmtsep grouping_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
grouping_stmt_subs_
  = (grouping_stmt_sub_ stmtsep)*

grouping_stmt_sub_
  = status_stmt
  / description_stmt
  / reference_stmt
  / typedef_stmt
  / grouping_stmt
  / data_def_stmt

container_stmt
  = container_keyword sep identifier_arg_str optsep (";" / "{" stmtsep container_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
container_stmt_subs_
  = (container_stmt_sub_ stmtsep)*

container_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / must_stmt
  / presence_stmt
  / config_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / typedef_stmt
  / grouping_stmt
  / data_def_stmt

leaf_stmt
  = leaf_keyword sep identifier_arg_str optsep "{" stmtsep leaf_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
leaf_stmt_subs_
  = (leaf_stmt_sub_ stmtsep)*

leaf_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / type_stmt
  / units_stmt
  / must_stmt
  / default_stmt
  / config_stmt
  / mandatory_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

leaf_list_stmt
  = leaf_list_keyword sep identifier_arg_str optsep "{" stmtsep leaf_list_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
leaf_list_stmt_subs_
  = (leaf_list_stmt_sub_ stmtsep)*

leaf_list_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / type_stmt
  / units_stmt
  / must_stmt
  / config_stmt
  / min_elements_stmt
  / max_elements_stmt
  / ordered_by_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

list_stmt
  = list_keyword sep identifier_arg_str optsep "{" stmtsep list_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
list_stmt_subs_
  = (list_stmt_sub_ stmtsep)*

list_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / must_stmt
  / key_stmt
  / unique_stmt
  / config_stmt
  / min_elements_stmt
  / max_elements_stmt
  / ordered_by_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / typedef_stmt
  / grouping_stmt
  / data_def_stmt

key_stmt
  = key_keyword sep key_arg_str stmtend

key_arg_str
  = DQUOTE key_arg DQUOTE
  / SQUOTE key_arg SQUOTE
  / key_arg

key_arg
  = node_identifier (sep node_identifier)*

unique_stmt
  = unique_keyword sep unique_arg_str stmtend

unique_arg_str
  = DQUOTE unique_arg DQUOTE
  / SQUOTE unique_arg SQUOTE
  / unique_arg

unique_arg
  = descendant_schema_nodeid (sep descendant_schema_nodeid)*

choice_stmt
  = choice_keyword sep identifier_arg_str optsep (";" / "{" stmtsep choice_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
choice_stmt_subs_
  = (choice_stmt_sub_ stmtsep)*

choice_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / default_stmt
  / config_stmt
  / mandatory_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / short_case_stmt
  / case_stmt

short_case_stmt
  = container_stmt
  / leaf_stmt
  / leaf_list_stmt
  / list_stmt
  / anyxml_stmt

case_stmt
  = case_keyword sep identifier_arg_str optsep (";" / "{" stmtsep case_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
case_stmt_subs_
  = (case_stmt_sub_ stmtsep)*

case_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / data_def_stmt

anyxml_stmt
  = anyxml_keyword sep identifier_arg_str optsep (";" / "{" stmtsep anyxml_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
anyxml_stmt_subs_
  = (anyxml_stmt_sub_ stmtsep)*

anyxml_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / must_stmt
  / config_stmt
  / mandatory_stmt
  / status_stmt
  / description_stmt
  / reference_stmt

uses_stmt
  = uses_keyword sep identifier_ref_arg_str optsep (";" / "{" stmtsep uses_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
uses_stmt_subs_
  = (uses_stmt_sub_ stmtsep)*

uses_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / refine_stmt
  / uses_augment_stmt

refine_stmt
  = refine_keyword sep refine_arg_str optsep (";" / "{" stmtsep refine_stmt_subs_ "}")

refine_stmt_subs_
  = refine_container_stmts
  / refine_leaf_stmts
  / refine_leaf_list_stmts
  / refine_list_stmts
  / refine_choice_stmts
  / refine_case_stmts
  / refine_anyxml_stmts

refine_arg_str
  = DQUOTE refine_arg DQUOTE
  / SQUOTE refine_arg SQUOTE
  / refine_arg

refine_arg
  = descendant_schema_nodeid

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_container_stmts
  = (refine_container_stmt_ stmtsep)*

refine_container_stmt_
  = must_stmt
  / presence_stmt
  / config_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_leaf_stmts
  = (refine_leaf_stmt_ stmtsep)*

refine_leaf_stmt_
  = must_stmt
  / default_stmt
  / config_stmt
  / mandatory_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_leaf_list_stmts
  = (refine_leaf_list_stmt_ stmtsep)*

refine_leaf_list_stmt_
  = must_stmt
  / config_stmt
  / min_elements_stmt
  / max_elements_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_list_stmts
  = (refine_list_stmt_ stmtsep)*

refine_list_stmt_
  = must_stmt
  / config_stmt
  / min_elements_stmt
  / max_elements_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_choice_stmts
  = (refine_choice_stmt_ stmtsep)*

refine_choice_stmt_
  = default_stmt
  / config_stmt
  / mandatory_stmt
  / description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_case_stmts
  = (refine_case_stmt_ stmtsep)*

refine_case_stmt_
  = description_stmt
  / reference_stmt

// these stmts can appear in any order
// CHANGE don't check repetition count
refine_anyxml_stmts
  = (refine_anyxml_stmt_ stmtsep)*

refine_anyxml_stmt_
  = must_stmt
  / config_stmt
  / mandatory_stmt
  / description_stmt
  / reference_stmt

uses_augment_stmt
  = augment_keyword sep uses_augment_arg_str optsep "{" stmtsep uses_augment_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
uses_augment_stmt_subs_
  = (uses_augment_stmt_sub_ stmtsep)*

uses_augment_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / data_def_stmt
  / case_stmt

uses_augment_arg_str
  = DQUOTE uses_augment_arg DQUOTE
  / SQUOTE uses_augment_arg SQUOTE
  / uses_augment_arg

uses_augment_arg
  = descendant_schema_nodeid

augment_stmt
  = augment_keyword sep augment_arg_str optsep "{" stmtsep augment_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
augment_stmt_subs_
  = (augment_stmt_sub_ stmtsep)*

augment_stmt_sub_
  = when_stmt
  / if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / data_def_stmt
  / case_stmt

augment_arg_str
  = DQUOTE augment_arg DQUOTE
  / SQUOTE augment_arg SQUOTE
  / augment_arg

augment_arg
  = absolute_schema_nodeid

unknown_statement
  = prefix ":" identifier (sep string)? optsep (";" / "{" unknown_statement2* "}")

unknown_statement2
  = (prefix ":")? identifier (sep string)? optsep (";" / "{" unknown_statement2* "}")

when_stmt
  = when_keyword sep string optsep (";" / "{" stmtsep when_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
when_stmt_subs_
  = (when_stmt_sub_ stmtsep)*

when_stmt_sub_
  = description_stmt
  / reference_stmt

rpc_stmt
  = rpc_keyword sep identifier_arg_str optsep (";" / "{" stmtsep rpc_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
rpc_stmt_subs_
  = (rpc_stmt_sub_ stmtsep)*

rpc_stmt_sub_
  = if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / typedef_stmt
  / grouping_stmt
  / input_stmt
  / output_stmt

input_stmt
  = input_keyword optsep "{" stmtsep input_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
input_stmt_subs_
  = (input_stmt_sub_ stmtsep)*

input_stmt_sub_
  = typedef_stmt
  / grouping_stmt
  / data_def_stmt

output_stmt
  = output_keyword optsep "{" stmtsep output_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
output_stmt_subs_
  = (output_stmt_sub_ stmtsep)*

output_stmt_sub_
  = typedef_stmt
  / grouping_stmt
  / data_def_stmt

notification_stmt
  = notification_keyword sep identifier_arg_str optsep (";" / "{" stmtsep notification_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
notification_stmt_subs_
  = (notification_stmt_sub_ stmtsep)*

notification_stmt_sub_
  = if_feature_stmt
  / status_stmt
  / description_stmt
  / reference_stmt
  / typedef_stmt
  / grouping_stmt
  / data_def_stmt

deviation_stmt
  = deviation_keyword sep deviation_arg_str optsep "{" stmtsep deviation_stmt_subs_ "}"

// these stmts can appear in any order
// CHANGE don't check repetition count
deviation_stmt_subs_
  = (deviation_stmt_sub_ stmtsep)*

deviation_stmt_sub_
  = description_stmt
  / reference_stmt
  / deviate_not_supported_stmt
  / deviate_add_stmt
  / deviate_replace_stmt
  / deviate_delete_stmt

deviation_arg_str
  = DQUOTE deviation_arg DQUOTE
  / SQUOTE deviation_arg SQUOTE
  / deviation_arg

deviation_arg
  = absolute_schema_nodeid

deviate_not_supported_stmt
  = deviate_keyword sep not_supported_keyword optsep (";" / "{" stmtsep
"}")

deviate_add_stmt
  = deviate_keyword sep add_keyword optsep (";" / "{" stmtsep deviate_add_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
deviate_add_stmt_subs_
  = (deviate_add_stmt_sub_ stmtsep)*

deviate_add_stmt_sub_
  = units_stmt
  / must_stmt
  / unique_stmt
  / default_stmt
  / config_stmt
  / mandatory_stmt
  / min_elements_stmt
  / max_elements_stmt

deviate_delete_stmt
  = deviate_keyword sep delete_keyword optsep (";" / "{" stmtsep deviate_delete_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
deviate_delete_stmt_subs_
  = (deviate_delete_stmt_sub_ stmtsep)*

deviate_delete_stmt_sub_
  = units_stmt
  / must_stmt
  / unique_stmt
  / default_stmt

deviate_replace_stmt
  = deviate_keyword sep replace_keyword optsep (";" / "{" stmtsep deviate_replace_stmt_subs_ "}")

// these stmts can appear in any order
// CHANGE don't check repetition count
deviate_replace_stmt_subs_
  = (deviate_replace_stmt_sub_ stmtsep)*

deviate_replace_stmt_sub_
  = type_stmt
  / units_stmt
  / default_stmt
  / config_stmt
  / mandatory_stmt
  / min_elements_stmt
  / max_elements_stmt

// Ranges

range_arg_str
  = DQUOTE range_arg DQUOTE
  / SQUOTE range_arg SQUOTE
  / range_arg

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
  = DQUOTE length_arg DQUOTE
  / SQUOTE length_arg SQUOTE
  / length_arg

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
  = DQUOTE date_arg DQUOTE
  / SQUOTE date_arg SQUOTE
  / date_arg

date_arg
  = $(DIGIT DIGIT DIGIT DIGIT "-" DIGIT DIGIT "-" DIGIT DIGIT)

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
  = ("/" (node_identifier predicate*))+

predicate
  = "[" WSP* (predicate_expr / pos) WSP* "]"

predicate_expr
  = (node_identifier / ".") WSP* "=" WSP* ((DQUOTE string DQUOTE) / (SQUOTE string SQUOTE))

pos
  = non_negative_integer_value

// leafref path

path_arg_str
  = DQUOTE path_arg DQUOTE
  / SQUOTE path_arg SQUOTE
  / path_arg

path_arg
  = absolute_path
  / relative_path

absolute_path
  = ("/" (node_identifier path_predicate*))+

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
  = (".." WSP* "/" WSP*)+ (node_identifier WSP* "/" WSP*)* node_identifier

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
  = "belongs-to"
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
  = "error-app-tag"
error_message_keyword
  = "error-message"
extension_keyword
  = "extension"
deviation_keyword
  = "deviation"
deviate_keyword
  = "deviate"
feature_keyword
  = "feature"
fraction_digits_keyword
  = "fraction-digits"
grouping_keyword
  = "grouping"
identity_keyword
  = "identity"
if_feature_keyword
  = "if-feature"
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
  = "leaf-list"
length_keyword
  = "length"
list_keyword
  = "list"
mandatory_keyword
  = "mandatory"
max_elements_keyword
  = "max-elements"
min_elements_keyword
  = "min-elements"
module_keyword
  = "module"
must_keyword
  = "must"
namespace_keyword
  = "namespace"
notification_keyword
  = "notification"
ordered_by_keyword
  = "ordered-by"
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
  = "require-instance"
revision_keyword
  = "revision"
revision_date_keyword
  = "revision-date"
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
  = "yang-version"
yin_element_keyword
  = "yin-element"

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
  = current_keyword WSP* "(" WSP* ")"

// Basic Rules

prefix_arg_str
  = DQUOTE prefix_arg DQUOTE
  / SQUOTE prefix_arg SQUOTE
  / prefix_arg

prefix_arg
  = prefix

prefix
  = identifier

identifier_arg_str
  = DQUOTE identifier_arg DQUOTE
  / SQUOTE identifier_arg SQUOTE
  / identifier_arg

identifier_arg
  = identifier

// An identifier MUST NOT start with (('X'|'x') ('M'|'m') ('L'|'l'))
identifier
  = $((ALPHA / "_") (ALPHA / DIGIT / "_" / "-" / ".")*)

identifier_ref_arg_str
  = DQUOTE identifier_ref_arg DQUOTE
  / SQUOTE identifier_ref_arg SQUOTE
  / identifier_ref_arg

identifier_ref_arg
  = (prefix ":")? identifier

// CHANGE restrict to non-quote or non-space chars
// CHANGE allow multiline strings, concatenated by +
string
  = string_quoted_
  / string_unquoted_

string_quoted_
  = DQUOTE $[^"]* DQUOTE (optsep "+" optsep string_quoted_)*
  / SQUOTE $[^']* SQUOTE (optsep "+" optsep string_quoted_)*

string_unquoted_
  = $[^ ]+

integer_value
  = "-" non_negative_integer_value
  / non_negative_integer_value

non_negative_integer_value
  = "0"
  / positive_integer_value

positive_integer_value
  = $(non_zero_digit DIGIT*)

zero_integer_value
  = $DIGIT+

stmtend
  = ";"
  / "{" unknown_statement* "}"

// unconditional separator
sep
  = $(WSP / line_break)+

optsep
  = $(WSP / line_break)*

// CHANGE DRY optsep
// CHANGE allow comments
stmtsep
  = optsep stmtsep_*

stmtsep_
  = single_line_comment_
  / multi_line_comment_
  / unknown_statement optsep

single_line_comment_
  = "//" $(!line_break .)* line_break optsep

multi_line_comment_
  = "/*" $(!"*/" .)+ "*/" optsep

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
