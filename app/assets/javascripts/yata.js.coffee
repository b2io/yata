window.Yata =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  Proxies: {}
  init: ->
    # Create a central event-dispatcher
    window.Dispatcher = _.extend({}, Backbone.Events)

    # Proxy data that will need to be shared.
    window.Proxy = new Yata.Proxies.TodosProxy
      userId: gon.user_id
      lists: new Yata.Collections.Lists(gon.lists)
      sortTodosURL: gon.sort_todos_url
      sortListsURL: gon.sort_lists_url

    # Bootstrap the application.
    router = new Yata.Routers.TodosRouter()
    Backbone.history.start()

$(document).ready ->
  Yata.init()
