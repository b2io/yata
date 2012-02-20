Yata.Views.Todos ?= {};

class Yata.Views.Todos.Index extends Backbone.View
  template: JST['todos/index']

  initialize: ->
    @collection.on('reset', @render)
    @collection.on('add', @appendList)

  render: =>
    $(@el).html(@template())
    @collection.each(@appendList)
    this

  # TODO: Differentiate between the inbox list and the other lists.
  appendList: (list, index) =>
    view = if index == 0 then new Yata.Views.Todos.InboxList(model: list) else new Yata.Views.Todos.List(model: list)
    @$('#list-list').append(view.render().el)
