Yata.Views.Todos.Lists ?= {}

class Yata.Views.Todos.Lists.InboxListView extends Yata.Views.Todos.Lists.ListView
  className: 'active inbox-list'
  template: JST["todos/lists/inboxlist"]

  events:
   'click .list': 'switchLists'

  initialize: ->
    Proxy.set('selectedList', @model)
    @model.todos.on('add remove', @render)

