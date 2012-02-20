window.Yata =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  init: ->
    # Create a central event-dispatcher
    window.Dispatcher = _.extend({}, Backbone.Events)

    # Proxy data that will need to be shared.
    window.Proxy =
      userId: gon.user_id
      lists: new Yata.Collections.Lists(gon.lists)

    # Bootstrap the application.
    router = new Yata.Routers.TodosRouter()
    Backbone.history.start()

$(document).ready ->
  Yata.init()
