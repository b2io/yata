Yata.Views.Todos.Lists ?= {}

class Yata.Views.Todos.Lists.InboxListView extends Yata.Views.Todos.Lists.ListView
  id: 'inbox-list'
  className: 'active'
  template: JST["todos/lists/inbox"]

  events:
   'click .list': 'switchLists'
