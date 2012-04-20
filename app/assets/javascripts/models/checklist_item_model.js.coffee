class Yata.Models.ChecklistItem extends Backbone.Model
  defaults: ->
    text: "Add Item"
    done: false

  initialize: ->

  toggle: =>
    @save(done: !@get('done'))

