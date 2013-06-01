# core-pegjs

A collection of core [PEGjs](https://github.com/dmajda/pegjs) grammars (RFC, ISO, etc.)

Wherever there are ABNF specifications, the ABNF rules MUST simply ported to PEGjs without any semantic modification.


## Reason

The PEGs part of this library MUST have no `actions` (code), in order to make them reusable, outside the context in which they are used. Code and semantic output is to be implemented by libraries that reuse the syntax in these PEGs, thanks to the [overrideAction PEGjs plugin](https://github.com/andreineculau/pegjs-override-action).

Such libraries are exemplified by [API-PEGjs](https://github.com/andreineculau/api-pegjs).


## Extension

PEGjs doesn't allow for composability (referencing other grammars).

This library makes use of an `@append` marker/instruction to concatenate multiple grammars into one, before publishing.

This __is__ a __workaround__. As soon as https://github.com/dmajda/pegjs/issues/38 is closed, you can expect a breaking change, if the situation so needs.


## License

MIT
