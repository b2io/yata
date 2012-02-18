//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require yata/yata
//= require yata/templates/todos/list

Yata.Views.Todos = Yata.Views.Todos || {};

Yata.Views.Todos.ListView = Backbone.View.extend({

    tagName: 'li',
    template: JST["yata/templates/todos/list"],

    initialize: function(options) {
        this.state = options.state;

        this.dropOptions = {
            accept: '#todo-list li',
            drop: this.onDrop,
            hoverClass: 'ui-state-active'
        };

        // Ensure all methods of this object are called with correct scope.
        _.bindAll(this);

        this.model.on('change', this.render);
        this.model.on('destroy', this.remove);
    },

    events: {
        'click .list': 'switchLists',
        'click .list-destroy': 'clear',
        'dblclick .list': 'edit',
        'keypress .list-input': 'updateOnEnter',
        'blur .list-input': 'close'
    },

    render: function() {
        $(this.el).html(this.template(this.model.toJSON()));
        $(this.el).children('.list').droppable(this.dropOptions);

        return this;
    },

    remove: function() {
        $(this.el).remove();
    },

    switchLists: function() {
        $('#list-list li.active').removeClass('active');
        $(this.el).addClass('active');
        $('.list.editing').removeClass('editing');

        var listId = $(this.el).children('.list').data('id');

        Todos.fetch({ data: { list_id: listId } });

        State.selectedListId = listId || null;
    },

    clear: function() {
        // TODO: Implement modal confirmation behavior.

        // Remove the list.
        $(this.el).remove();

        // Send them back to the inbox.
        $('#inbox-list').click();

        // Stop default behavior.
        return false;
    },

    edit: function() {
        this.$('.list').addClass('editing');
        this.$('.list-input').focus();
    },

    updateOnEnter: function(e) {
        if (e.keyCode == 13) this.close();
    },

    close: function() {
        this.$('.list').removeClass('editing');
        this.model.save({ text: this.$('.list-input').val() });
    },

    onDrop: function (event, ui) {
        var todoId = $(ui.draggable).children('.todo').data('id');
        var listId = $(this).data('id');

        var todo = Todos.get(todoId);

        if (todo.get('list_id') != listId) {
            todo.save({ 'list_id': listId || null });
            Todos.remove(todo);

            // Update the two lists in question.
            Lists.get(State.selectedListId).fetch();
            Lists.get(listId).fetch();
        }
    }

});