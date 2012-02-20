Yata.Views.Todos.Todos ?= {}

class Yata.Views.Todos.Todos.TodosView extends Backbone.View
  template: JST['todos/todos/todos']

  todoList: null

  initialize: ->
    Dispatcher.on('lists:selectionChanged', @lists_selectionChangedHandler)

  render: =>
    @$el.html(@template())

    @todoList = @$('#todo-list')

    this

  renderTodo: (todo) =>
    todoView = new Yata.Views.Todos.Todos.TodoView(model: todo)
    @todoList.append(todoView.render().el)

  lists_selectionChangedHandler: (list) =>
    @todoList.html('')
    list.todos.each(@renderTodo)
