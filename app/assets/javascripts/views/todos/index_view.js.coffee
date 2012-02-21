Yata.Views.Todos ?= {};

class Yata.Views.Todos.Index extends Backbone.View
  template: JST['todos/index']

  initialize: ->
    @todosView = new Yata.Views.Todos.Todos.TodosView()
    @listsView = new Yata.Views.Todos.Lists.ListsView()

  render: =>
    @$el.html(@template())

    @$('#todos-container').html(@todosView.render().el)
    @$('#lists-container').html(@listsView.render().el)

    this
