Yata.Views.Todos.Todos ?= {}

class Yata.Views.Todos.Todos.TodoView extends Backbone.View
  tagName: 'li'
  template: JST['todos/todos/todo']

  events:
    'click .todo-check': 'toggleDone'

  initialize: ->
    @model.on('change', @render)

  render: =>
    @$el.html(@template(todo: @model))
    this

  toggleDone: =>
    @model.toggle()

###
TodosApp.Views.Todos = TodosApp.Views.Todos || {};

TodosApp.Views.Todos.TodoView = Backbone.View.extend({

    // Properties

    state: null,
    tagName: 'li',
    template: JST["todos/todo"],

    // Creation

    initialize: function(options) {
        this.state = options.state;

        // TODO: Update the count of the list after deleting a todo.

        // Ensure all methods of this object are called with correct scope.
        _.bindAll(this);

        // Listen for relevant changes on the model:
        this.model.on('change', this.render);
        this.model.on('destroy', this.remove);
        this.model.on('remove', this.remove);
    },

    events: {
        'click .todo-check'			: 'toggleDone',
        'click .todo-destroy'		: 'clear',
        'dblclick .todo'            : 'edit',
        'keypress .todo-input'		: 'updateOnEnter',
        'blur .todo-input'          : 'close'
    },

    // Handlers

    render: function() {
        // Render the view by running the model (as JSON) through the templating engine.
        $(this.el).html(this.template(this.model.toJSON()));

        return this;
    },

    remove: function() {
        // Remove the view from the list.
        $(this.el).remove();
    },

    toggleDone: function() {
        // Flip the done flag on the model.
        this.model.toggle();
    },

    clear: function() {
        // Remove the model from its collection.
        this.model.destroy();
    },

    edit: function(e) {
        // Indicate that we're editing this item.
        this.$('.todo').addClass('editing');

        // Set focus on the input.
        this.$('.todo-input').focus();
    },

    updateOnEnter: function(e) {
        // If the 'enter' key has been pressed: close the item.
        if (e.keyCode == 13) this.close();
    },

    close: function() {
        // Indicate that we're done editing this item.
        this.$('.todo').removeClass('editing');

        // Update the model with the new text.
        this.model.save({ text: this.$('.todo-input').val() });
    }

});