# Core PEGjs [![Build Status][2]][1]

A collection of core [PEGjs](https://github.com/dmajda/pegjs) grammars (IETF, ISO, etc.)

Wherever there are ABNF specifications, the ABNF rules MUST simply ported to PEGjs without any semantic modification.

**This is part of a bigger effort: [for-GET HTTP](https://github.com/for-GET/README).**


## Reason

The PEGs part of this library MUST have no `actions` (code), in order to make them reusable, outside the context in which they are used. Code and semantic output is to be implemented by libraries that reuse the syntax in these PEGs, thanks to the [overrideAction PEGjs plugin](https://github.com/andreineculau/pegjs-override-action).

An example of such libraries is [API-PEGjs](https://github.com/andreineculau/api-pegjs).


## Extension

PEGjs doesn't allow for composability (referencing other grammars).

This library makes use of an `@append` marker/instruction to concatenate multiple grammars into one, before publishing.

__This is a workaround__. As soon as https://github.com/dmajda/pegjs/issues/38 is closed, you can expect a breaking change, if the situation so needs.


## License

[Apache 2.0](LICENSE)


  [1]: https://travis-ci.org/for-GET/core-pegjs
  [2]: https://travis-ci.org/for-GET/core-pegjs.png
