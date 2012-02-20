class Yata.Models.List extends Backbone.RelationalModel
  defaults: ->
    id: null
    text: 'New List'
    order: @getNextOrder
    count: 0

  getNextOrder: =>
    @collection.length