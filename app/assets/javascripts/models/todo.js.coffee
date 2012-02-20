class Yata.Models.Todo extends Backbone.Model
  defaults:
    id: null
    done: false

###
TodosApp.Models.Todo = Backbone.RelationalModel.extend({

    defaults: function() {
        return {
            id: null,
            done: false
        };
    },

    toggle: function() {
        this.save({ done: !this.get('done') });
    }

});