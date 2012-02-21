class Yata.Models.Todo extends Backbone.Model
  defaults:
    id: null
    done: false
    user_id: gon.user_id

  toggle: =>
    @save(done: !@get('done'))
