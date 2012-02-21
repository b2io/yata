class Yata.Collections.Todos extends Backbone.Collection
  model: Yata.Models.Todo
  url: '/api/todos'

  comparator: (todo) ->
    todo.get('position')

  nextPosition: =>
    @last().get('position') + 1

  # TODO: Refactor this to a mixin.
  sortByUI: (ui) =>
    # Update the items on the server.
    serialized = ui.sortable('serialize')
    $.post(Proxy.get('sortTodosURL'), serialized)

    # Update the items on the client.
    idsInOrder = _.map(serialized.split("&"), (entry) -> entry.match(/\d+/)[0])
    _.each(idsInOrder, (id, idx) => @get(id).set('position', idx + 1))
