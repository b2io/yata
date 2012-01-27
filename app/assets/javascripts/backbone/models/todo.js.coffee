class Yata.Models.Todo extends Backbone.Model
  paramRoot: 'todo'

  defaults:
    text: null
    done: null
    user_id: null

class Yata.Collections.TodosCollection extends Backbone.Collection
  model: Yata.Models.Todo
  url: '/todos'
