{SelectListView, $, $$} = require 'atom-space-pen-views'
utils = require './utils'

module.exports =
class ProjectSwitcherView extends SelectListView
  @activate: ->
    view = new ProjectSwitcherView
    @disposable = atom.commands.add 'atom-workspace',
     'project-switcher:toggle', -> view.toggle()

  @deactivate: ->
    @disposable.dispose()

  keyBindings: null

  initialize: ->
    super

    @addClass 'overlay from-top'

  getFilterKey: ->
    'name'

  cancelled: ->
    @hide()

  toggle: ->
    if @panel?.isVisible()
      @cancel()
    else
      @show()

  show: ->
    @panel ?= atom.workspace.addModalPanel(item: this)
    @panel.show()

    @storeFocusedElement()

    if @previouslyFocusedElement[0] and @previouslyFocusedElement[0] isnt document.body
      @eventElement = @previouslyFocusedElement[0]
    else
      @eventElement = atom.views.getView(atom.workspace)
    @keyBindings = atom.keymaps.findKeyBindings(target: @eventElement)

    @setItems utils.listProjects()

    @focusFilterEditor()

  hide: ->
    @panel?.hide()

  viewForItem: (item) ->
    "<li>#{item.name}</li>"

  confirmed: (item) ->
    atom.project.setPaths [item.fullpath]
    @cancel()
