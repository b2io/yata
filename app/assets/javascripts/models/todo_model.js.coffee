class Yata.Models.Todo extends Backbone.Model
  checklist_items: null

  defaults:
    id: null
    done: false
    checklist_items: []
    description: "Double-click to add description"

  toggle: =>
    @save(done: !@get('done'))

  initialize: ->
    @checklist_items = new Yata.Collections.ChecklistItems(@get('checklist_items'))