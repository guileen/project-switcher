{SelectListView} = require 'atom'
utils = require './utils'

module.exports =
class ProjectSwitcherView extends SelectListView

  initialize: (serializeState) ->
    super
    @addClass 'overlay from-top'
    atom.workspaceView.command "project-switcher:toggle", => @toggle()

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
      atom.workspaceView.append(this)
      @focusFilterEditor()
