class Yata.Collections.Lists extends Backbone.Collection

  model: Yata.Models.List,
  url: '/api/lists',

  nextOrder: =>
    this.length

  comparator: (list) ->
    list.get('order')