Yata.Views.Todos.Todos ?= {}

class Yata.Views.Todos.Todos.TodoView extends Backbone.View
  tagName: 'li'
  template: JST['todos/todos/todo']

  todo: null
  todoInput: null

  events:
    'click .todo-check': 'toggleDone'
    'click .todo-destroy': 'clear'
    'dblclick .todo': 'edit'
    'keypress .todo-input': 'updateOnEnter'
    'blur .todo-input': 'close'

  initialize: ->
    @model.on('change', @render)
    @model.on('destroy remove', @remove)

  render: =>
    # Render the template.
    @$el.html(@template(todo: @model))

    # Cache relevant sub-views.
    @todo = @$('.todo')
    @todoInput = @$('.todo-input')

    this

  remove: =>
    @$el.remove()

  toggleDone: =>
    @model.toggle()

  clear: =>
    @model.destroy()

  edit: =>
    @todo.addClass('editing')
    @todoInput.focus()

  updateOnEnter: (event) =>
    @close() if event.keyCode == 13

  close: =>
    if @todo.hasClass('editing')
      @todo.removeClass('editing')
      @model.save(text: @todoInput.val()) if @todoInput.val() != @model.get('text')
