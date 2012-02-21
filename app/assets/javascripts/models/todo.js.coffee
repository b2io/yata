class Yata.Models.Todo extends Backbone.Model
  defaults:
    id: null
    done: false

  toggle: =>
    @save(done: !@get('done'))
