# core-pegjs

A library of core [PEGjs](https://github.com/dmajda/pegjs) modules (RFC, ISO, etc.)


## Status

Not published to NPM until [these issues are closed](https://github.com/andreineculau/core-pegjs/issues?milestone=1&state=open).


## Extension

PEGjs doesn't allow for composability (referencing other grammars).

This library makes use of an `@append` marker/instruction to concatenate multiple grammars into one, before publishing.

This __is__ a __workaround__. As soon as https://github.com/dmajda/pegjs/issues/38 is closed, you can expect a breaking change, if the situation so needs.

## License

MIT
