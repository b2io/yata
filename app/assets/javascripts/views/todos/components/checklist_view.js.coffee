Yata.Views.Components ?= {};

class Yata.Views.Components.ChecklistView extends Backbone.View

  template: JST['todos/components/checklist']

  checklistItems: null
  checklistInput: null
  checklistAddLabel: null
  progressBar: null

  events:
    'click .checklist-input' : 'handleChecklistInputClick'
    'blur .checklist-input' : "handleChecklistInput"
    'keypress .checklist-input' : "updateOnEnter"
    'click .checklist-check' : "handleChecklistClick"

  initialize: ->

  render: =>

    @model.checklist_items.on('add', @modelChanged)

    @checklistItems = @model.checklist_items.models

    completeItems = 0;

    for item in @model.checklist_items.models
      do (item) ->
        if (item.get('done') == true)
          completeItems += 1;

    percentComplete = Math.round((completeItems/@checklistItems.length) * 100)

    @$el.html(@template(checklist: @checklistItems, completeItems: completeItems))

    @updateProgress(percentComplete)

    this

  updateProgress: (percentComplete) =>
    @$('.bar').attr('style', "width: #{percentComplete}%")

  modelChanged: =>
    @render()

  handleChecklistInput: =>
    val = @$('.checklist-input').val()
    if (val != "") && (val != "Add Item")
      @model.checklist_items.create(todo_id: @model.get('id'), text: @$('.checklist-input').val(), { wait: true })
      @$('.checklist-input').val("Add Item")
      @render()

  handleChecklistInputClick: =>
    @$('.checklist-input').val("")
    @$('.checklist-input').focus()


  updateOnEnter: (event) =>
    @handleChecklistInput() if event.keyCode == 13

  handleChecklistClick: (event) ->
    currentCheckItem = @model.checklist_items.get((Number) event.currentTarget.id)
    currentCheckItem.toggle()
    @render()