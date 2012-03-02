Yata.Views.Todos.Modal ?= {};

class Yata.Views.Todos.Modal.InfoModal extends Backbone.View

  template: JST['todos/modals/modals']

  descriptionInput: null
  descriptionContent: null
  descriptionLabel: null
  modalBody: null

  initialize: ->


  render: =>
    # Render the overall template.
    @selectedList = Proxy.get('selectedList')
    @$el.html(@template(todo: @model, list: @selectedList))
    @descriptionInput = @$('.description-input')
    @modalBody = @$('.modal-body')
    @descriptionContent = @$('.description-content')
    @descriptionLabel = @$('.desc-label')

    #I had to manually bind these events
    #returning 'this' in render somehow borks the modal
    #TODO: Get to the bottom of this and let backbone auto-bind events
    @$('.description-input').on('keypress', @onKeyPress)
    @$('.description-input').on('blur', @close)
    @$('.modal-body').on('dblclick', @editing)

   # TODO: render just the field that changes. not the whole modal
    @model.on('change', @reRender)

    @toggle()

  reRender: =>
    unless @model.get('description') == ""
      @descriptionLabel.html(@model.get('description'))

  toggle: ->
    console.log("toggle")
    @$('#myModal').modal('show')

  close: =>
    console.log("close")
    if @descriptionContent.hasClass('editing')
      @descriptionContent.removeClass('editing')
      @model.save(description: @descriptionInput.val()) if @descriptionInput.val() != @model.get('description')

  onKeyPress: (event) =>
    @close() if event.keyCode == 13

  editing: =>
    console.log("editing")
    @descriptionContent.addClass('editing')
    @descriptionInput.focus()
