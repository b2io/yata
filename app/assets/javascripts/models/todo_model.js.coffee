class Yata.Models.Todo extends Backbone.Model
  defaults:
    id: null
    done: false
    description: ""

  toggle: =>
    @save(done: !@get('done'))
