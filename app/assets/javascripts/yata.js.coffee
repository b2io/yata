window.Yata =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    router = new Yata.Routers.TodosRouter()
    Backbone.history.start()

$(document).ready ->
  Yata.init()
