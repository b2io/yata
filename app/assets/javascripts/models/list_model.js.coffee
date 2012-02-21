class Yata.Models.List extends Backbone.RelationalModel
  # TODO: Setup relationship between todos and lists.

  todos: null

  defaults: ->
    id: null
    text: 'New List'
    todos: []
    user_id: gon.user_id

  initialize: ->
    @todos = new Yata.Collections.Todos(@get('todos'))