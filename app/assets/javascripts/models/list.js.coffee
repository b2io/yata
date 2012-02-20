class Yata.Models.List extends Backbone.RelationalModel
  defaults: ->
    id: null
    text: 'New List'
    todos: []
    user_id: gon.user_id