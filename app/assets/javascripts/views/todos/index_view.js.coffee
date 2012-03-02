Yata.Views.Todos ?= {};

class Yata.Views.Todos.Index extends Backbone.View
  template: JST['todos/index']

  initialize: ->
    @todosView = new Yata.Views.Todos.Todos.TodosView()
    @listsView = new Yata.Views.Todos.Lists.ListsView()
    window.Dispatcher.bind("info_modal_requested", this.handle_info_modal_requested)

  render: =>
    @$el.html(@template())

    @$('#todos-container').html(@todosView.render().el)
    @$('#lists-container').html(@listsView.render().el)

    this

  handle_info_modal_requested: (todo) =>
    infoModalView = new Yata.Views.Todos.Modal.InfoModal(model: todo);
    @$('#info-modal').html(infoModalView.render())
