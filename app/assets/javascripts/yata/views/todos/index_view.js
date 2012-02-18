//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require backbone
//= require yata/yata
//= require yata/views/todos/todo_view
//= require yata/views/todos/list_view

Yata.Views.Todos = Yata.Views.Todos || {};

Yata.Views.Todos.Index = Backbone.View.extend({

    el: $('#todoapp'),

    statsTemplate: _.template(
        '<h3>Stats<% if (done > 0) { %><button class="todo-clear pull-right btn btn-success">Clear Completed</button><% } %></h3>\
        <ul>\
        <li><%= done %> completed tasks.</li>\
        <li><%= remaining %> remaining tasks.</li>\
        </ul>'
    ),

    selectedListId: null,

    // Creation

    initialize: function() {
        this.state = {};
        this.input = this.$('#new-todo');

        // TODO: Convert the global calls to local properties with a 'new'.

        // Ensure all methods of this object are called with correct scope.
        _.bindAll(this);

        Todos.on('add', this.addOneTodo);
        Todos.on('reset', this.addAllTodos);
        Todos.on('all', this.render);

        Todos.fetch();

        Lists.on('add', this.addOneList);
        Lists.on('reset', this.addAllLists);
        Lists.on('all', this.render);

        Lists.fetch();

        // Make the todo-list sortable.
        $('#todo-list').sortable({
            distance: 10,
            placeholder: "dd-placeholder",
            opacity: 0.75,
            revert: true
        }).disableSelection();

        $('#list-list').sortable({
            items: 'li:not(#inbox-list)',
            distance: 10,
            opacity: 0.75
        }).disableSelection();

        //$('#inbox-list .list').droppable(listDroppableOptions);
    },

    events: {
        'keypress #new-todo': 'createOnEnter',
        'click .todo-clear': 'clearCompleted',
        'sortupdate #todo-list': 'updateTodosAfterSort',
        'sortupdate #list-list': 'updateListsAfterSort',
        'click #add-list': 'addNewList'
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
        var view = new Yata.Views.Todos.TodoView({ model: todo, state: this.state });
        this.$('#todo-list').append(view.render().el);
    },

    addAllTodos: function() {
        this.$('#todo-list').html('');
        Todos.each(this.addOneTodo);
    },

    addOneList: function(list) {
        var view = new Yata.Views.Todos.ListView({ model: list, state: this.state });
        this.$('#list-list').append(view.render().el);
    },

    addAllLists: function() {
        Lists.each(this.addOneList);
    },

    createOnEnter: function(e) {
        var text = this.input.val();
        if (!text || e.keyCode != 13) return;
        Todos.create({ text: text, list_id: this.selectedListId });
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
        _.each(this.$('.editable-list'), function(item, idx) {
            Lists.get($(item).data('id')).save({ 'order': idx });
        });
    },

    addNewList: function () {
        Lists.create({ order: Lists.length });
    }

});