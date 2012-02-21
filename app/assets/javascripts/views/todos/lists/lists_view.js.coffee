Yata.Views.Todos.Lists ?= {}

class Yata.Views.Todos.Lists.ListsView extends Backbone.View
  template: JST['todos/lists/lists']

  lists: null

  events:
    'click #add-list': 'addNewList'

  initialize: ->
    @lists = Proxy.get('lists')
    @lists.on('reset', @render)
    @lists.on('add', @appendList)

  render: =>
    @$el.html(@template())
    @lists.each(@appendList)
    this

  appendList: (list, index) =>
    ListKlass = if index == 0 then Yata.Views.Todos.Lists.InboxListView else Yata.Views.Todos.Lists.ListView
    listView = new ListKlass(model: list)
    @$('#list-list').append(listView.render().el)

  addNewList: =>
    @collection.create({ order: @collection.last().get('order') + 1, wait: true })