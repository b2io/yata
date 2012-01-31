$(function(){
    // TEMPLATES

    var app = { templates: {} };

    app.templates.todo = '\
	    <div class="input-prepend">\
	        <label class="add-on">\
	            <input type="checkbox" class="todo-check" <% if (done) { %> checked <% } %> />\
	        </label>\
	        <input type="text" class="todo-input" size="16" />\
	        <button class="todo-destroy btn danger">Delete</button>\
	    </div>\
	';

    app.templates.stats = '\
	    <%= done %> completed tasks.\
	    <%= remaining %> remaining tasks.\
	    <% if (done > 0) { %><button class="todo-clear btn">Clear Completed</button><% } %>\
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
        url: 'todos/',

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
        tagName: 'li',

        template: _.template(app.templates.todo),

        events: {
            'click .todo-check'			: 'toggleDone',
            'click .todo-destroy'		: 'clear',
            'keypress .todo-input'		: 'updateOnEnter'
        },

        initialize: function() {
            this.model.bind('change', this.render, this);
            this.model.bind('destroy', this.remove, this);
        },

        render: function() {
            $(this.el).html(this.template(this.model.toJSON()));

            this.content = this.$('.todo-content');
            this.input = this.$('.todo-input');

            var text = this.model.get('text');

            this.content.text(text);

            this.input.bind('blur', _.bind(this.close, this)).val(text);

            return this;
        },

        toggleDone: function() {
            this.model.toggle();
        },

        close: function() {
            this.model.save({ text: this.input.val() });
        },

        updateOnEnter: function(e) {
            if (e.keyCode == 13) this.close();
        },

        remove: function() {
            $(this.el).remove();
        },

        clear: function() {
            this.model.destroy();
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





















