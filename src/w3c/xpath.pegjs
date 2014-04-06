/*
 * XML Path Language (XPath) 1.0
 *
 * http://www.w3.org/TR/xpath
 * Inspired by changes/fixes in https://github.com/andrejpavlovic/xpathjs
 *
 * Limitations & cleanup
 * - added optional whitespace, as per "For readability, whitespace may be used in expressions even though not explicitly allowed by the grammar: ExprWhitespace may be freely added within patterns before or after any ExprToken."
 * - tests: https://github.com/retnuh/mochiweb_xpath/blob/master/test/mochiweb_xpath_tests.erl
 *
 * @append w3c/xml.pegjs
 * @append w3c/xml-names.pegjs
 */

// CHANGE added optional whitespace
_
  = ExprWhitespace*

/* http://www.w3.org/TR/xpath/#location-paths 2 Location Paths */

LocationPath
  = RelativeLocationPath
  / AbsoluteLocationPath

// CHANGE fix left recursion
AbsoluteLocationPath
  = AbbreviatedAbsoluteLocationPath
  / '/' _ RelativeLocationPath?

// CHANGE fix left recursion
RelativeLocationPath
  = Step (_ ('//' / '/') _ Step)*

/* http://www.w3.org/TR/xpath/#location-steps 2.1 Location Steps */

Step
  = AxisSpecifier _ NodeTest (_ Predicate)*
  / AbbreviatedStep

AxisSpecifier
  = AxisName _ '::'
  / AbbreviatedAxisSpecifier

/* http://www.w3.org/TR/xpath/#axes 2.2 Axes */

// CHANGE reorder for greedy
AxisName
  = 'ancestor-or-self'
  / 'ancestor'
  / 'attribute'
  / 'child'
  / 'descendant-or-self'
  / 'descendant'
  / 'following-sibling'
  / 'following'
  / 'namespace'
  / 'parent'
  / 'preceding-sibling'
  / 'preceding'
  / 'self'

/* http://www.w3.org/TR/xpath/#node-tests 2.3 Node Tests */

// CHANGE reorder
NodeTest
  = NodeType _ '(' _ ')'
  / 'processing-instruction' _ '(' _ Literal _ ')'
  / NameTest

/* http://www.w3.org/TR/xpath/#predicates 2.4 Predicates */

Predicate
  = '[' _ PredicateExpr _ ']'

PredicateExpr
  = Expr

/* http://www.w3.org/TR/xpath/#abbreviated-syntax 2.5 Abbreviated Syntax */

AbbreviatedAbsoluteLocationPath
  = '//' _ RelativeLocationPath

// CHANGE removed
/*
AbbreviatedRelativeLocationPath
  = RelativeLocationPath '//' Step
*/

// CHANGE reorder for greedy
AbbreviatedStep
  = '..'
  / '.'

AbbreviatedAxisSpecifier
  = '@'?

/* http://www.w3.org/TR/xpath/#basics 3.1 Basics */

Expr
  = OrExpr

PrimaryExpr
  = VariableReference
  / '(' _ Expr _ ')'
  / Literal
  / Number
  / FunctionCall

/* http://www.w3.org/TR/xpath/#function-calls 3.2 Function Calls */

FunctionCall
  = FunctionName _ '(' (_ Argument (_ ',' _ Argument )* )? _ ')'

Argument
  = Expr

/* http://www.w3.org/TR/xpath/#node-sets 3.3 Node-sets */

// CHANGE fix left recursion
UnionExpr
  = PathExpr (_ '|' _ PathExpr)*

// CHANGE fix for greedy
PathExpr
  = FilterExpr (_ ('//' / '/') _ RelativeLocationPath)?
  / LocationPath

// CHANGE fix left recursion
FilterExpr
  = PrimaryExpr (_ Predicate)*

/* http://www.w3.org/TR/xpath/#booleans 3.4 Booleans */

// CHANGE fix left recursion
OrExpr
  = AndExpr (_ 'or' _ AndExpr)*

// CHANGE fix left recursion
AndExpr
  = EqualityExpr (_ 'and' _ EqualityExpr)*

// CHANGE fix left recursion
EqualityExpr
  = RelationalExpr (_ ('!=' / '=') _ RelationalExpr)*

// CHANGE fix left recursion
RelationalExpr
  = AdditiveExpr (_ ('<=' / '<' / '>=' / '>') _ AdditiveExpr)*

/* http://www.w3.org/TR/xpath/#numbers 3.5 Numbers */

// CHANGE fix left recursion
AdditiveExpr
  = MultiplicativeExpr (('+' / '-') MultiplicativeExpr)*

// CHANGE fix left recursion
MultiplicativeExpr
  = UnaryExpr (_ (MultiplyOperator / 'div' / 'mod') _ UnaryExpr)*

UnaryExpr
  = UnionExpr
  / '-' _ UnaryExpr

/* http://www.w3.org/TR/xpath/#lexical-structure 3.7 Lexical Structure */

// CHANGE reorder for greedy
ExprToken
  = '('
  / ')'
  / '['
  / ']'
  / '..'
  / '.'
  / '@'
  / ','
  / '::'
  / NameTest
  / NodeType
  / Operator
  / FunctionName
  / AxisName
  / Literal
  / Number
  / VariableReference

Literal
  = '"' [^"]* '"'
  / "'" [^']* "'"

Number
  = Digits ('.' Digits?)?
  / '.' Digits

Digits
  = [0-9]+

// CHANGE reorder for greedy
Operator
  = OperatorName
  / MultiplyOperator
  / '//'
  / '/'
  / '|'
  / '+'
  / '-'
  / '='
  / '!='
  / '<='
  / '<'
  / '>='
  / '>'

OperatorName
  = 'and'
  / 'or'
  / 'mod'
  / 'div'

MultiplyOperator
  = '*'

FunctionName
  = !NodeType QName

VariableReference
  = '$' QName

NameTest
  = '*'
  / NCName ':' '*'
  / QName

NodeType
  = 'comment'
  / 'text'
  / 'processing-instruction'
  / 'node'

ExprWhitespace
  = S
