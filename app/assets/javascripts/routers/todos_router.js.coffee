class Yata.Routers.TodosRouter extends Backbone.Router
  routes:
    "*path": "index"

  index: ->
    indexView = new Yata.Views.Todos.Index()
    $('#container').html(indexView.render().el)
