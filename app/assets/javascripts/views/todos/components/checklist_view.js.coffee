Yata.Views.Components ?= {};

class Yata.Views.Components.ChecklistView extends Backbone.View

  template: JST['todos/components/checklist']

  checklistItems: null
  checklistInput: null
  checklistAddLabel: null
  progressBar: null

  events:
    'dblclick .checklist-add-item': 'handleAddItemDblClick'
    'blur .checklist-input' : "handleChecklistInput"
    'keypress .checklist-input' : "updateOnEnter"

  initialize: ->

  render: =>

    @model.on("change", @modelChanged)

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
    console.log('model changed')
    @render()

  handleAddItemDblClick: =>
    console.log('handleAddItemDoubleClick')
    @$('.checklist-input').removeClass('hide')
    @$('.checklist-add-item').addClass('hide')
    @$('.checklist-input').focus()

  handleChecklistInput: =>
    @$('.checklist-input').addClass('hide')
    @$('.checklist-add-item').removeClass('hide')
    console.log(@$('.checklist-input').val())
    if (@$('.checklist-input').val() != "")
      @model.checklist_items.create(todo_id: @model.get('id'), text: @$('.checklist-input').val(), { wait: true })
      @$('.checklist-input').val("")


  updateOnEnter: (event) =>
    @handleChecklistInput() if event.keyCode == 13
