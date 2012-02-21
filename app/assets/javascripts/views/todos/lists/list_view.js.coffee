Yata.Views.Todos.Lists ?= {}

class Yata.Views.Todos.Lists.ListView extends Backbone.View
  tagName: 'li'
  template: JST["todos/lists/list"]

  listComponent: null
  clearButton: null
  listLabel: null
  listInput: null

  initialize: ->
    # Set the ID of the element for jQuery-UI's sortable serialize behavior.
    @$el.attr('id', "list_#{@model.get('id')}")

    # Listen for relevant changes on the model.
    @model.on('change', @render)
    @model.on('destroy', @remove)
    @model.todos.on('add remove', @render)

  events:
    'click .list': 'switchLists'
    'click .list-destroy': 'clear'
    'dblclick .list-label': 'edit'
    'keypress .list-input': 'updateOnEnter'
    'blur .list-input': 'close'

  render: =>
    @$el.html(@template(list: @model))

    @listComponent = @$('.list')
    @clearButton = @$('.list-destroy')
    @listLabel = @$('.list-label')
    @listInput = @$('.list-input')

    this

  remove: =>
    @$el.remove()

  switchLists: (event) =>
    if not $(@el).hasClass('active')
      $('#list-list li.active').removeClass('active')
      @$el.addClass('active')
      $('#list-list .list.editing').removeClass('editing')
      listId = @listComponent.data('id')
      Proxy.set('selectedList', @model)

  # TODO: Implement modal confirmation.
  clear: (event) =>
    @model.destroy()
    $('.inbox-list .list').click()
    event.stopPropagation()

  edit: (event) =>
    @listComponent.addClass('editing')
    @listInput.focus()

  updateOnEnter: (event) =>
    @close() if event.keyCode == 13

  close: (event) =>
    if @listComponent.hasClass('editing')
      @listComponent.removeClass('editing')
      @model.save(text: @listInput.val()) if @listInput.val() != @model.get('text')
