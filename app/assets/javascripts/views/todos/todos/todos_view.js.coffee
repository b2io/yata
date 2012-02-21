Yata.Views.Todos.Todos ?= {}

# TODO: Make todos draggable.
class Yata.Views.Todos.Todos.TodosView extends Backbone.View
  template: JST['todos/todos/todos']

  list: null

  todoList: null
  todoInput: null

  events:
    'keypress #new-todo': 'createOnEnter'
    'click .todo-clear': 'clearCompleted'
    'sortupdate #todo-list': 'updateAfterSort'

  initialize: ->
    Proxy.on('change:selectedList', @proxy_selectedListChangeHandler)

  render: =>
    # Render the overall template.
    @$el.html(@template())

    # Cache relevant sub-views.
    @todoList = @$('#todo-list')
    @todoInput = @$('#new-todo')

    # Turn on sorting for the todos.
    @todoList.sortable(
      axix: 'y'
      distance: 10
      placeholder: "dd-placeholder"
      opacity: 0.75
    ).disableSelection();

    this

  renderTodo: (todo) =>
    todoView = new Yata.Views.Todos.Todos.TodoView(model: todo)
    @todoList.append(todoView.render().el)

  proxy_selectedListChangeHandler: (proxy, list) =>
    # Stop listening to changes in the previous list.
    @list?.todos.off('add', @renderTodo)

    # Assuming the new list is valid:
    if list?
      # Cache it, listen for changes to its todos, and render it.
      @list = list
      @list.todos.on('add', @renderTodo)
      @todoList.html('')
      @list.todos.each(@renderTodo)

  createOnEnter: (event) =>
    text = @todoInput.val()
    if text and event.keyCode == 13
      @list.todos.create(text: text, list_id: @list.get('id') )
      @todoInput.val('')

  clearCompleted: =>
    this

  updateAfterSort: (event, ui) =>
    @list.todos.sortByUI(@todoList)
