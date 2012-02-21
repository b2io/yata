class Yata.Collections.Lists extends Backbone.Collection
  model: Yata.Models.List,
  url: '/api/lists',

  nextOrder: =>
    @last().get('order') + 1

  comparator: (list) ->
    list.get('order')