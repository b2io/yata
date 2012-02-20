class Yata.Routers.TodosRouter extends Backbone.Router

  routes:
    "": "index"

  initialize: ->
    @collection = new Yata.Collections.Lists()
    @collection.reset(gon.lists)

  index: ->
    view = new Yata.Views.Todos.Index(collection: @collection)
    $('#container').html(view.render().el)
