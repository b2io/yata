Yata.Views.Todos ?= {};

class Yata.Views.Todos.InboxList extends Yata.Views.Todos.List
  template: JST["todos/inbox"]

  events:
   'click .list': 'switchLists'

  initialize: ->
    @$el.attr('id', 'inbox-list')
    @$el.addClass('active')
    super
