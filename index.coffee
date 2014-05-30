fs = require 'fs'

module.exports = (id) ->
  grammar = module.exports.cache[id]
  return grammar  if grammar?
  # FIXME check if dependencies' source is newer than the distro
  grammarFile = "#{__dirname}/lib/#{id}.pegjs"
  srcGrammarFile = "#{__dirname}/src/#{id}.pegjs"
  if fs.existsSync srcGrammarFile
    if fs.statSync(srcGrammarFile).mtime.getTime() > fs.statSync(grammarFile).mtime.getTime()
      throw new Error "Source grammar #{srcGrammarFile} is newer than
        the compiled one #{grammarFile}. Please recompile!"
  grammar = module.exports.cache[id] = fs.readFileSync grammarFile, 'utf8'
  grammar

module.exports.cache = {}
