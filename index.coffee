# TODO: Remove the catch once Atom 1.7.0 is released
try {shell} = require 'electron' catch then shell = require 'shell'
{CompositeDisposable} = require 'atom'
path = require 'path'
fs = require 'fs'
simpleGit = require('simple-git')

module.exports =
  subscriptions: null,

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable
    @subscriptions.add atom.commands.add 'atom-workspace',
      'github-utils:open': => @open()


  open: ->
    editor = atom.workspace.getActivePaneItem()
    file = editor?.buffer.file?.path
    ourDir = path.dirname file
    if !ourDir
      console.log 'no git parent (or otherwise found)'
      return

    simpleGit ourDir
      .listRemote [], (err, vals) ->
        console.log err
        console.log vals
