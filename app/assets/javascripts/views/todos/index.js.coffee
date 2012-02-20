Yata.Views.Todos ?= {};

class Yata.Views.Todos.Index extends Backbone.View
  template: JST['todos/index']

  events:
    'click #add-list': 'addNewList'

  initialize: ->
    @collection.on('reset', @render)
    @collection.on('add', @appendList)

  render: =>
    $(@el).html(@template())
    @collection.each(@appendList)
    this

  appendList: (list, index) =>
    ListKlass = if index == 0 then Yata.Views.Todos.InboxList else Yata.Views.Todos.List
    view = new ListKlass(model: list)
    @$('#list-list').append(view.render().el)

  addNewList: =>
    @collection.create({ order: @collection.last().get('order') + 1, wait: true })
