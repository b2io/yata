Yata.Views.Todos.Todos ?= {}

class Yata.Views.Todos.Todos.TodosView extends Backbone.View
  template: JST['todos/todos/todos']

  initialize: ->
    Dispatcher.on('lists:selectionChanged', @lists_selectionChangedHandler)

  render: =>
    @$el.html(@template())
    this

  lists_selectionChangedHandler: (list) =>
    # TODO: Render the todos in this list.
