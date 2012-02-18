//= require underscore
//= require backbone
//= require yata/yata

Yata.Models.Todo = Backbone.Model.extend({
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

Yata.Collections.Todos = Backbone.Collection.extend({
    model: Yata.Models.Todo,
    url: '/todos/',

    // Get the list of todos that are completed.
    done: function() {
        return this.filter(function(todo){ return todo.get('done'); });
    },

    // Get the list of todos yet to be completed.
    remaining: function() {
        return this.without.apply(this, this.done());
    },

    // Get the next viable 'order' for the todo.
    nextOrder: function() {
        return this.length;
    },

    // Define a way to compare todos.
    comparator: function(todo) {
        return todo.get('order');
    }
});