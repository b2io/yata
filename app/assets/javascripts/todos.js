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
//= require jquery-ui


$(function(){
    // TEMPLATES

    var app = { templates: {} };

    app.templates.todo = '\
	    <div data-id="<%= id %>" class="todo <% if (done) { %> done <% } %>">\
	        <input type="checkbox" class="todo-check" <% if (done) { %> checked <% } %> />\
	        <div class="todo-content">\
                <span class="todo-label"><%= text %></span>\
                <input type="text" class="todo-input" value="<%= text %>" />\
	        </div>\
	        <a class="todo-destroy close" title="<% if (done) { %>Clear<% } else { %>Delete<% } %>"><% if (done) { %>&#x2713;<% } else { %>&#x2717;<% } %></a>\
	    </div>\
	';

    app.templates.list = '<a data-id="<%= id %>" class="list"><%= text %></a>';

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
            return this.length;
        },

        // Define a way to compare todos.
        comparator: function(todo) {
            return todo.get('order');
        }
    });

    window.List = Backbone.Model.extend({
        defaults: function() {
            return {
                text: "New List",
                order: Lists.nextOrder()
            }
        }
    });

    window.ListList = Backbone.Collection.extend({
        model: List,
        url: '/lists/',

        nextOrder: function() {
            return this.length;
        },

        comparator: function(list) {
            return list.get('order');
        }
    });

// VIEWS

    window.ListView = Backbone.View.extend({
        tagName: 'li',
        template: _.template(app.templates.list),

        initialize: function() {
          this.model.bind('change', this.render, this);
          this.model.bind('destroy', this.remove, this);
        },

        events: {
          'click .list'                 : 'switchLists'
        },

        render: function() {
            $(this.el).html(this.template(this.model.toJSON()));

            return this;
        },

        remove: function() {
            $(this.el).remove();
        },

        switchLists: function() {
            var listId = $(this.el).children('a').data('id');

            Todos.fetch({ data: { list: listId } })
        }

    });

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

        // Properties

        el: $('#todoapp'),

        statsTemplate: _.template(app.templates.stats),

        // Creation

        initialize: function() {
            this.input = this.$('#new-todo');

            Todos.bind('add', this.addOneTodo, this);
            Todos.bind('reset', this.addAllTodos, this);
            Todos.bind('all', this.render, this);

            Todos.fetch();

            Lists.bind('add', this.addOneList, this);
            Lists.bind('reset', this.addAllLists, this);
            Lists.bind('all', this.render, this);

            Lists.fetch();
        },

        events: {
            'keypress #new-todo'	: 'createOnEnter',
            'click .todo-clear'		: 'clearCompleted',
            'sortupdate #todo-list' : 'updateTodosAfterSort',
            'sortupdate #list-list' : 'updateListsAfterSort'
        },

        // Handlers

        render: function() {
            this.$('#todo-stats').html(this.statsTemplate({
                total		: Todos.length,
                done		: Todos.done().length,
                remaining	: Todos.remaining().length
            }));
        },

        addOneTodo: function(todo) {
            var view = new TodoView({ model: todo });
            this.$('#todo-list').append(view.render().el);
        },

        addAllTodos: function() {
            this.$('#todo-list').html('');
            Todos.each(this.addOneTodo);
        },

        addOneList: function(list) {
            var view = new ListView({ model: list });
            this.$('#list-list').append(view.render().el);
        },

        addAllLists: function() {
          Lists.each(this.addOneList);
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
        },

        updateTodosAfterSort: function(event, ui) {
            // Go through each of the todos in the list.
            _.each(this.$('.todo'), function(item, idx) {
                // Get the related todo (using the 'data-id' as a key) and update its order.
                Todos.get($(item).data('id')).save({ 'order': idx });
            });
        },

        updateListsAfterSort: function(event, ui) {
            _.each(this.$('.list'), function(item, idx) {
               Lists.get($(item).data('id')).save({ 'order': idx });
            });
        }

    });

// INITIALIZATION

    window.Lists = new ListList;
    window.Todos = new TodoList;
    window.App = new AppView;

    // Make the todo-list sortable.
    $('#todo-list').sortable({
        distance: 10,
        placeholder: "dd-placeholder",
        opacity: 0.75
    }).disableSelection();

    $('#list-list').sortable({
        distance: 10,
        placeholder: "dd-placeholder",
        opacity: 0.75
    }).disableSelection();

    $('#inbox-list').on('click', function() {
       Todos.fetch();
    });

});
