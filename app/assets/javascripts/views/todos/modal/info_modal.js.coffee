Yata.Views.Todos.Modal ?= {};

class Yata.Views.Todos.Modal.InfoModal extends Backbone.View

  template: JST['todos/modals/modals']

  descriptionInput: null
  descriptionContent: null
  descriptionLabel: null
  modalBody: null
  checkListPlaceholder: null
  checklistButton: null
  checklist: null

  initialize: ->


  render: =>

    # Render the overall template.
    @selectedList = Proxy.get('selectedList')
    @$el.html(@template(todo: @model, list: @selectedList))
    @descriptionInput = @$('.description-input')
    @modalBody = @$('.modal-body')
    @descriptionContent = @$('.description-content')
    @descriptionLabel = @$('.desc-label')
    @checkListPlaceholder = @$('#checklist-placeholder')
    @checklistButton = @$('.checklist-btn')

    #I had to manually bind these events
    #returning 'this' in render somehow borks the modal
    #TODO: Get to the bottom of this and let backbone auto-bind events
    @$('.description-input').on('keypress', @onKeyPress)
    @$('.description-input').on('blur', @close)
    @$('.description-content').on('dblclick', @editing)
    @checklistButton.on('click', @addChecklist)

    console.log(@model)

    if (@model.checklist_items.length > 0)
      @addChecklist()
   # TODO: render just the field that changes. not the whole modal
    @model.on('change', @reRender)

    @toggle()



  reRender: =>
    unless @model.get('description') == ""
      @descriptionLabel.html(@model.get('description'))

  toggle: ->

    @$('#myModal').modal('show')

  close: =>
    if @descriptionContent.hasClass('editing')
      @descriptionContent.removeClass('editing')
      @model.save(description: @descriptionInput.val()) if @descriptionInput.val() != @model.get('description')

  onKeyPress: (event) =>
    @close() if event.keyCode == 13

  editing: =>

    @descriptionContent.addClass('editing')
    @descriptionInput.focus()

  addChecklist: =>
    @checklistButton.off('click', @addChecklist)
    @checklistButton.on('click', @removeChecklist)
    @checklistButton.html("<i class='icon-check icon-white'/> Remove Checklist ")
    @checkList = new Yata.Views.Components.ChecklistView(model: @model);
    @checkListPlaceholder.html(@checkList.render().el)

  removeChecklist: =>
    @checklistButton.off('click', @removeChecklist)
    @checklistButton.on('click', @addChecklist)
    @checklistButton.html("<i class='icon-check icon-white'/> Add Checklist ")
    console.log("before")
    console.log(@model)
    console.log("after")

    for item in @model.checklist_items.models
      do (item) ->
        console.log(item)
        item.destroy() unless item is undefined

    @model.checklist_items.reset()
    @model.save(checklist_items: [])

    console.log(@model.get('checklist_items'))
    console.log(@model.checklist_items.models.length)

    #@model.save()
    @checkListPlaceholder.html("")


