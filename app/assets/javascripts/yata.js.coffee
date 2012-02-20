window.Yata =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    window.Dispatcher = _.extend({}, Backbone.Events)
    router = new Yata.Routers.TodosRouter()
    Backbone.history.start()

$(document).ready ->
  Yata.init()
