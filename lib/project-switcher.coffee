ProjectSwitcherView = require './project-switcher-view'

module.exports =
  projectSwitcherView: null

  activate: (state) ->
    @projectSwitcherView = new ProjectSwitcherView(state.projectSwitcherViewState)

  deactivate: ->
    @projectSwitcherView.destroy()

  serialize: ->
    projectSwitcherViewState: @projectSwitcherView.serialize()
