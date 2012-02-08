// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require underscore
//= require backbone
//= require json2


$(function(){
    // TEMPLATES

    var app = { templates: {} };

    app.templates.todo = '\
	    <div class="todo <% if (done) { %> done <% } %>">\
	        <input type="checkbox" class="todo-check" <% if (done) { %> checked <% } %> />\
	        <div class="todo-content">\
                <span class="todo-label"><%= text %></span>\
                <input type="text" class="todo-input" value="<%= text %>" />\
	        </div>\
	        <a class="todo-destroy close" title="<% if (done) { %>Clear<% } else { %>Delete<% } %>"><% if (done) { %>&#x2713;<% } else { %>&#x2717;<% } %></a>\
	    </div>\
	';

    app.templates.stats = '\
        <h3>Stats<% if (done > 0) { %><button class="todo-clear pull-right btn btn-success">Clear Completed</button><% } %></h3>\
        <ul>\
        <li><%= done %> completed tasks.</li>\
        <li><%= remaining %> remaining tasks.</li>\
        </ul>\
	';

    // MODELS

    window.Todo = Backbone.Model.extend({
        defaults: function() {
            return {
                done: false,
                order: Todos.nextOrder()
            };
        },

        toggle: function() {
            this.save({ done: !this.get('done') });
        }
    });

    window.TodoList = Backbone.Collection.extend({
        model: Todo,
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
            return (!this.length) ? 1 : this.last().get('order') + 1;
        },

        // Define a way to compare todos.
        comparator: function(todo) {
            return todo.get('order');
        }
    });

// VIEWS

    window.TodoView = Backbone.View.extend({

        // Properties

        tagName: 'li',

        template: _.template(app.templates.todo),

        // Creation

        initialize: function() {
            // Listen for relevant changes on the model:
            this.model.bind('change', this.render, this);
            this.model.bind('destroy', this.remove, this);
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

            // Pull the 'text' property off the model.
            var text = this.model.get('text');

            // Set the text of the label and input appropriately.
            //this.$('.todo-label').text(text);
            //this.$('.todo-input').val(text);

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

    window.AppView = Backbone.View.extend({
        el: $('#todoapp'),

        statsTemplate: _.template(app.templates.stats),

        events: {
            'keypress #new-todo'	: 'createOnEnter',
            'click .todo-clear'		: 'clearCompleted'
        },

        initialize: function() {
            this.input = this.$('#new-todo');

            Todos.bind('add', this.addOne, this);
            Todos.bind('reset', this.addAll, this);
            Todos.bind('all', this.render, this);

            Todos.fetch();
        },

        render: function() {
            this.$('#todo-stats').html(this.statsTemplate({
                total		: Todos.length,
                done		: Todos.done().length,
                remaining	: Todos.remaining().length
            }));
        },

        addOne: function(todo) {
            var view = new TodoView({ model: todo });
            this.$('#todo-list').append(view.render().el);
        },

        addAll: function() {
            Todos.each(this.addOne);
        },

        createOnEnter: function(e) {
            var text = this.input.val();
            if (!text || e.keyCode != 13) return;
            Todos.create({ text: text });
            this.input.val('');
        },

        clearCompleted: function() {
            _.each(Todos.done(), function(todo) { todo.destroy(); });
            return false;
        }
    });

// INITIALIZATION

    window.Todos = new TodoList;
    window.App = new AppView;
});





















