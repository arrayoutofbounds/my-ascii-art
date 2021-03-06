
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'my-ascii-art:convert': => @convert()

  deactivate: ->
    @subscriptions.dispose()


  convert: ->
    if editor = atom.workspace.getActiveTextEditor()
      selection = editor.getSelectedText()

      figlet = require 'figlet'
      font = "Star Wars"
      figlet selection, {font: font}, (error, art) ->
        if error
          console.error(error)
        else
          editor.insertText("\n#{art}\n")
