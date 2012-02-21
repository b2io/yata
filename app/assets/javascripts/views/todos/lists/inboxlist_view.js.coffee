Yata.Views.Todos.Lists ?= {}

class Yata.Views.Todos.Lists.InboxListView extends Yata.Views.Todos.Lists.ListView
  className: 'active inbox-list'
  template: JST["todos/lists/inbox"]

  events:
   'click .list': 'switchLists'

  initialize: ->
    Proxy.set('selectedList', @model)
    super
