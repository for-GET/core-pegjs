fs = require 'fs'
path = require 'path'
glob = require 'glob'

module.exports = {}

options =
  sync: true

glob "#{__dirname}/lib/**/*.pegjs", options, (err, files) ->
  for file in files
    mod = path.dirname path.relative "#{__dirname}/lib", file
    mod += '/' + path.basename file, '.pegjs'
    module.exports[mod] = fs.readFileSync file, 'utf8'
