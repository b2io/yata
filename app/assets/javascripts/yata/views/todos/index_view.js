//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require underscore
//= require backbone
//= require yata/yata
//= require yata/views/todos/todo_view
//= require yata/views/todos/inbox_list_view
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

        // TODO: Get rid of all selectedListId refs that aren't on window.State.
        // TODO: Update the count of the list when adding a todo.
        // TODO: Update the count of the list after clearing the completed todos.

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
        var view = (list.get('order') != 0) ? new Yata.Views.Todos.ListView({ model: list, state: this.state }) : new Yata.Views.Todos.InboxListView({ model: list, state: this.state });
        this.$('#list-list').append(view.render().el);
    },

    addAllLists: function() {
        this.$('#list-list').html('');
        Lists.each(this.addOneList);
    },

    createOnEnter: function(e) {
        var text = this.input.val();
        if (!text || e.keyCode != 13) return;
        Todos.create({ text: text, list_id: State.selectedListId });
        this.input.val('');
    },

    clearCompleted: function() {
        _.each(Todos.done(), function(todo) { todo.destroy(); });
        return false;
    },

    updateTodosAfterSort: function(event, ui) {
        _.each(this.$('.todo'), function(item, idx) {
            Todos.get($(item).data('id')).save({ 'order': idx });
        });
    },

    updateListsAfterSort: function(event, ui) {
        _.each(this.$('.editable-list'), function(item, idx) {
            Lists.get($(item).data('id')).save({ 'order': idx });
        });
    },

    addNewList: function () {
        Lists.create();
        // TODO: Trigger edit behavior and focus on the new list.
    }

});