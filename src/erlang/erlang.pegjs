/*
 * Erlang
 *
 * https://github.com/erlang/otp/blob/maint/lib/stdlib/src/erl_parse.yrl
 *
 * Limitations & cleanup
 * - stub
 * - doesn't allow whitespace and comments
 *
 * @append ietf/rfc5234-core-abnf.pegjs
 */

// CHANGE addition
forms
  = form+

form
  = attribute "."
  / function "."
  / rule_clauses "."

attribute
  = "-" atom attr_val
  / "-" atom typed_attr_val
  / "-" atom "(" typed_attr_val ")"
  / "-" "spec" type_spec
  / "-" "callback" type_spec


type_spec
  = spec_fun type_sigs
  / "(" spec_fun type_sigs ")"

spec_fun
  = atom
  / atom ":" atom
  // The following two are retained only for backwards compatibility;
  // they are not part of the EEP syntax and should be removed.
  / atom "/" integer "::"
  / atom ":" atom "/" integer "::"

typed_attr_val
  = expr "," typed_record_fields
  / expr "::" top_type


typed_record_fields
  = "{" typed_exprs "}"

typed_exprs
  = typed_expr
  / typed_expr "," typed_exprs
  / expr "," typed_exprs
  / typed_expr "," exprs

typed_expr
  = expr "::" top_type

// CHANGE use * operator
type_sigs
  = type_sig (";" type_sig)*

// CHANGE use ? operator
type_sig
  = fun_type ("when" type_guards)?

// CHANGE use * operator
type_guards
  = type_guard ("," type_guard)*

type_guard
  = atom "(" top_types ")"
  / var "::" top_type

// CHANGE use * operator
top_types
  = top_type ("," top_type)*

// CHANGE use ? operator
top_type
  = (var "::")? top_type_100

// CHANGE use ? operator
top_type_100
  = top_type_200 ("|" top_type_100)?

// CHANGE use ? operator
top_type_200
  = top_type_300 (".." top_type_300)?

// CHANGE fix left recursion
top_type_300
  = top_type_400 (add_op top_type_400)*

// CHANGE fix left recursion
top_type_400
  = top_type_500 (mult_op top_type_500)*

top_type_500
  = prefix_op top_type

type
  = "(" top_type ")"
  / var
  / atom
  / atom "(" ")"
  / atom "(" top_types ")"
  / atom ":" atom "(" ")"
  / atom ":" atom "(" top_types ")"
  / "[" "]"
  / "[" top_type "]"
  / "[" top_type "," "..." "]"
  / "#" "{" "}"
  / "#" "{" map_pair_types "}"
  / "{" "}"
  / "{" top_types "}"
  / "#" atom "{" "}"
  / "#" atom "{" field_types "}"
  / binary_type
  / integer
  / "fun" "(" ")"
  / "fun" "(" fun_type_100 ")"

fun_type_100
  = "(" "..." ")" "->" top_type
  / fun_type

// CHANGE use ? operator
fun_type
  = "(" (top_types)? ")" "->" top_type

// CHANGE use * operator
map_pair_types
  = map_pair_type ("," map_pair_type)*

map_pair_type
  = top_type "=>" top_type

// CHANGE use * operator
field_types
  = field_type ("," field_type)*

field_type
  = atom "::" top_type

binary_type
  = "<<" ">>"
  / "<<" bin_base_type ">>"
  / "<<" bin_unit_type ">>"
  / "<<" bin_base_type "," bin_unit_type ">>"

bin_base_type
  = var ":" type

bin_unit_type
  = var ":" var "*" type

attr_val
  = expr
  / expr "," exprs
  / "(" expr "," exprs ")"

function
  = function_clauses

// CHANGE use * operator
function_clauses
  = function_clause (";" function_clause)*

function_clause
  = atom clause_args clause_guard clause_body

clause_args
  = argument_list

clause_guard
  = ("when" guard)?

// CHANGE use ? operator
clause_body
  = "->" exprs

expr
  = "catch" expr
  / expr_100

expr_100
  = expr_150 "=" expr_100
  / expr_150 "!" expr_100
  / expr_150

expr_150
  = expr_160 "orelse" expr_150
  / expr_160

expr_160
  = expr_200 "andalso" expr_160
  / expr_200

expr_200
  = expr_300 comp_op expr_300
  / expr_300

expr_300
  = expr_400 list_op expr_300
  / expr_400

// CHANGE use * operator
expr_400
  = expr_500 (add_op expr_500)*
  / expr_500

// CHANGE use * operator
expr_500
  = expr_600 (mult_op expr_600)*
  / expr_600

expr_600
  = prefix_op expr_700
  / map_expr
  / expr_700

expr_700
  = function_call
  / record_expr
  / expr_800

// CHANGE use ? operator
expr_800
  = expr_max (":" expr_max)?

expr_max
  = var
  / atomic
  / list
  / binary
  / list_comprehension
  / binary_comprehension
  / tuple
  // / struct
  / "(" expr ")"
  / "begin" expr "end"
  / if_expr
  / case_expr
  / receive_expr
  / fun_expr
  / try_expr

list
  = "[" "]"
  / "[" expr tail

tail
  = "]"
  / "|" expr "]"
  / "," expr tail

binary
  = "<<" ">>"
  / "<<" bin_elements ">>"

// CHANGE use * operator
bin_elements
  = bin_element ("," bin_element)*

bin_element
  = bit_expr opt_bit_size_expr opt_bit_type_list

bit_expr
  = prefix_op expr_max

// CHANGE use ? operator
opt_bit_size_expr
  = (":" bit_size_expr)?

// CHANGE use ? operator
opt_bit_type_list
  = ("/" bit_type_list)?

// CHANGE use * operator
bit_type_list
  = bit_type ("-" bit_type)*

// CHANGE use ? operator
bit_type
  = atom (":" integer)?

bit_size_expr
  = expr_max

list_comprehension
  = "[" expr "||" lc_exprs "]"

binary_comprehension
  = "<<" binary "||" lc_exprs ">>"

// CHANGE use * operator
lc_exprs
  = lc_expr ("," lc_expr)*

lc_expr
  = expr
  / expr "<-" expr
  / binary "<=" expr

// CHANGE use ? operator
tuple
  = "{" exprs? "}"

/* struct
  = atom tuple
*/

// CHANGE use operators
map_expr
  = ((expr_max? "#")? map_tuple)+

// CHANGE use ? operator
map_tuple
  = "{" map_fields? "}"

// CHANGE use * operator
map_fields
  = map_field ("," map_field)*

map_field
  = map_field_assoc
  / map_field_exact

map_field_assoc
  = map_key "=>" expr

map_field_exact
  = map_key ":=" expr

map_key
  = expr

// N.B. This is called from expr_700.
// N.B. Field names are returned as the complete object, even if they are
// always atoms for the moment, this might change in the future.

record_expr
  = (expr_max? "#" atom ("." atom / record_tuple) )+

// CHANGE use ? operator
record_tuple
  = "{" record_fields? "}"

// CHANGE use * operator
record_fields
  = record_field ("," record_field)*

record_field
  = var "=" expr
  / atom "=" expr

// N.B. This is called from expr_700.

function_call
  = expr_800 argument_list

if_expr
  = "if" if_clauses "end"

// CHANGE use * operator
if_clauses
  = if_clause (";" if_clause)*

if_clause
  = guard clause_body

case_expr
  = "case" expr "of" cr_clauses "end"

// CHANGE use * operator
cr_clauses
  = cr_clause (";" cr_clause)*

cr_clause
  = expr clause_guard clause_body

receive_expr
  = "receive" cr_clauses "end"
  / "receive" "after" expr clause_body "end"
  / "receive" cr_clauses "after" expr clause_body "end"

fun_expr
  = "fun" atom "/" integer
  / "fun" atom_or_var ":" atom_or_var "/" integer_or_var
  / "fun" fun_clauses "end"

atom_or_var
  = atom
  / var

integer_or_var
  = integer
  / var

// CHANGE use * operator
fun_clauses
  = fun_clause (";" fun_clause)*

fun_clause
  = var? argument_list clause_guard clause_body

// CHANGE use ? operator
try_expr
  = "try" exprs ("of" cr_clauses)? try_catch

try_catch
  = "catch" try_clauses "end"
  / "catch" try_clauses "after" exprs "end"
  / "after" exprs "end"

// CHANGE use * operator
try_clauses
  = try_clause (";" try_clause)*

try_clause
  = expr clause_guard clause_body
  / atom ":" expr clause_guard clause_body
  / var ":" expr clause_guard clause_body

// CHANGE use ? operator
argument_list
  = "(" exprs? ")"

// CHANGE use * operator
exprs
  = expr ("," expr)*

// CHANGE use * operator
guard
  = exprs (";" exprs)*

atomic
  = char
  / integer
  / float
  / atom
  / string

// CHANGE use + operator
strings
  = string+

prefix_op
  = "+"
  / "-"
  / "bnot"
  / "not"

mult_op
  = "/"
  / "*"
  / "div"
  / "rem"
  / "band"
  / "and"

add_op
  = "+"
  / "-"
  / "bor"
  / "bxor"
  / "bsl"
  / "bsr"
  / "or"
  / "xor"

list_op
  = "++"
  / "--"

comp_op
  = "=="
  / "/="
  / "=<"
  / "<"
  / ">="
  / ">"
  / "=:="
  / "=/="

rule
  = rule_clauses

// CHANGE use * operator
rule_clauses
  = rule_clause (";" rule_clause)*

rule_clause
  = atom clause_args clause_guard rule_body

rule_body
  = ":-" lc_exprs

// CHANGE addition
atom
  = [a-z@][0-9a-zA-Z_@]*

// CHANGE addition
var
  = [A-Z_][0-9a-zA-Z_]*

// CHANGE addition
float
  = "-"? [0-9]+ "." [0-9]+  ([Ee] [+-]? [0-9]+)?

// CHANGE addition
integer
  = "-"? [0-9]+ ("#" [0-9a-zA-Z]+)?

// CHANGE addition
char
  = "$" ("\\"? [^\r\n] / "\\" [0-9] [0-9] [0-9])

// CHANGE addition
string
  = "'" ( "\\" / [\\'] )* "'"

// CHANGE addition
comment
  = "%" [^\r\n]* "\r"? "\n"

// CHANGE addition
WS
  = [ \t\r\n]+

// CHANGE addition
OWSC
  = (WS / comment)*
