Yata.Views.Components ?= {};

class Yata.Views.Components.ChecklistView extends Backbone.View

  template: JST['todos/components/checklist']

  checklistItems: null

  initialize: ->

  render: =>
    console.log(@model)
    @item = @model.checklist_items.create(todo_id: @model.get('id'), { wait: true })
    @model.save()
    @checklistItems = @model.checklist_items
    console.log(@checklistItems)
    @$el.html(@template(checklist: @checklistItems))



    this
