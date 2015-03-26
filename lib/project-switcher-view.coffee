{SelectListView} = require 'atom'
{WorkspaceView} = require 'atom'
utils = require './utils'
workspaceView = new WorkspaceView()

module.exports =
class ProjectSwitcherView extends SelectListView

  initialize: (serializeState) ->
    super
    @addClass 'overlay from-top'
    atom.commands.add 'atom-text-editor',
      'project-switcher:toggle': => @toggle()

  viewForItem: (item) ->
    "<li>#{item.name}</li>"

  confirmed: (item) ->
    atom.project.setPath item.fullpath
    @cancel()

  getFilterKey: ()->
    'name'

  # Returns an object that can be retrieved when package is activated
  serialize: ->

  # Tear down any state and detach
  destroy: ->
    @detach()

  toggle: ->
    if @hasParent()
      @detach()
    else
      @setItems utils.listProjects()
      workspaceView.append(this)
      @focusFilterEditor()
