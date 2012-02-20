class Yata.Routers.TodosRouter extends Backbone.Router
  routes:
    "": "index"

  index: ->
    indexView = new Yata.Views.Todos.Index()
    $('#container').html(indexView.render().el)
