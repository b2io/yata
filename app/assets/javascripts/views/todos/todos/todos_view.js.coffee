Yata.Views.Todos.Todos ?= {}

class Yata.Views.Todos.Todos.TodosView extends Backbone.View
  template: JST['todos/todos/todos']

  todoList: null

  initialize: ->
    Proxy.on('change:selectedList', @proxy_selectedListChangeHandler)

  render: =>
    @$el.html(@template())
    @todoList = @$('#todo-list')
    this

  renderTodo: (todo) =>
    todoView = new Yata.Views.Todos.Todos.TodoView(model: todo)
    @todoList.append(todoView.render().el)

  proxy_selectedListChangeHandler: (proxy, list) =>
    if list?
      @todoList.html('')
      list.todos.each(@renderTodo)
