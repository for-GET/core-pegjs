/*
 * XML Path Language (XPath) 1.0
 *
 * http://www.w3.org/TR/xpath
 *
 * Limitations & cleanup
 * - FIXME left recursion
 * - tests: https://github.com/retnuh/mochiweb_xpath/blob/master/test/mochiweb_xpath_tests.erl
 *
 * @append w3c/xml.pegjs
 * @append w3c/xml-names.pegjs
 */

/* http://www.w3.org/TR/xpath/#location-paths 2 Location Paths */

LocationPath
  = RelativeLocationPath
  / AbsoluteLocationPath

AbsoluteLocationPath
  = '/' RelativeLocationPath?
  / AbbreviatedAbsoluteLocationPath

RelativeLocationPath
  = Step
  / RelativeLocationPath '/' Step
  / AbbreviatedRelativeLocationPath

/* http://www.w3.org/TR/xpath/#location-steps 2.1 Location Steps */

Step
  = AxisSpecifier NodeTest Predicate*
  / AbbreviatedStep

AxisSpecifier
  = AxisName '::'
  / AbbreviatedAxisSpecifier

/* http://www.w3.org/TR/xpath/#axes 2.2 Axes */

AxisName
  = 'ancestor'
  / 'ancestor-or-self'
  / 'attribute'
  / 'child'
  / 'descendant'
  / 'descendant-or-self'
  / 'following'
  / 'following-sibling'
  / 'namespace'
  / 'parent'
  / 'preceding'
  / 'preceding-sibling'
  / 'self'

/* http://www.w3.org/TR/xpath/#node-tests 2.3 Node Tests */

NodeTest
  = NameTest
  / NodeType '(' ')'
  / 'processing-instruction' '(' Literal ')'

/* http://www.w3.org/TR/xpath/#predicates 2.4 Predicates */

Predicate
  = '[' PredicateExpr ']'

PredicateExpr
  = Expr

/* http://www.w3.org/TR/xpath/#abbreviated-syntax 2.5 Abbreviated Syntax */

AbbreviatedAbsoluteLocationPath
  = '//' RelativeLocationPath

AbbreviatedRelativeLocationPath
  = RelativeLocationPath '//' Step

AbbreviatedStep
  = '.'
  / '..'

AbbreviatedAxisSpecifier
  = '@'?

/* http://www.w3.org/TR/xpath/#basics 3.1 Basics */

Expr
  = OrExpr

PrimaryExpr
  = VariableReference
  / '(' Expr ')'
  / Literal
  / Number
  / FunctionCall

/* http://www.w3.org/TR/xpath/#function-calls 3.2 Function Calls */

FunctionCall
  = FunctionName '(' (Argument (',' Argument )* )? ')'

Argument
  = Expr

/* http://www.w3.org/TR/xpath/#node-sets 3.3 Node-sets */

UnionExpr
  = PathExpr
  / UnionExpr '|' PathExpr

PathExpr
  = LocationPath
  / FilterExpr
  / FilterExpr '/' RelativeLocationPath
  / FilterExpr '//' RelativeLocationPath

FilterExpr
  = PrimaryExpr
  / FilterExpr Predicate

/* http://www.w3.org/TR/xpath/#booleans 3.4 Booleans */

OrExpr
  = AndExpr
  / OrExpr 'or' AndExpr

AndExpr
  = EqualityExpr
  / AndExpr 'and' EqualityExpr

EqualityExpr
  = RelationalExpr
  / EqualityExpr '=' RelationalExpr
  / EqualityExpr '!=' RelationalExpr

RelationalExpr
  = AdditiveExpr
  / RelationalExpr '<' AdditiveExpr
  / RelationalExpr '>' AdditiveExpr
  / RelationalExpr '<=' AdditiveExpr
  / RelationalExpr '>=' AdditiveExpr

/* http://www.w3.org/TR/xpath/#numbers 3.5 Numbers */

AdditiveExpr
  = MultiplicativeExpr
  / AdditiveExpr '+' MultiplicativeExpr
  / AdditiveExpr '-' MultiplicativeExpr

MultiplicativeExpr
  = UnaryExpr
  / MultiplicativeExpr MultiplyOperator UnaryExpr
  / MultiplicativeExpr 'div' UnaryExpr
  / MultiplicativeExpr 'mod' UnaryExpr

UnaryExpr
  = UnionExpr
  / '-' UnaryExpr

/* http://www.w3.org/TR/xpath/#lexical-structure 3.7 Lexical Structure */

ExprToken
  = '('
  / ')'
  / '['
  / ']'
  / '.'
  / '..'
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

Operator
  = OperatorName
  / MultiplyOperator
  / '/'
  / '//'
  / '|'
  / '+'
  / '-'
  / '='
  / '!='
  / '<'
  / '<='
  / '>'
  / '>='

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
