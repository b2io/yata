class Yata.Collections.Lists extends Backbone.Collection
  model: Yata.Models.List,
  url: '/api/lists',

  comparator: (list) ->
    list.get('position')

  nextPosition: =>
    @last().get('position') + 1

  # TODO: Refactor this to a mixin.
  sortByUI: (ui) =>
    # Update the items on the server.
    serialized = ui.sortable('serialize')
    $.post(Proxy.get('sortListsURL'), serialized)

    # Update the items on the client.
    idsInOrder = _.map(serialized.split("&"), (entry) -> entry.match(/\d+/)[0])
    _.each(idsInOrder, (id, idx) => @get(id).set('position', idx + 1))