//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require yata/yata
//= require yata/views/todos/list_view
//= require yata/templates/todos/inbox

Yata.Views.Todos = Yata.Views.Todos || {};

Yata.Views.Todos.InboxListView = Yata.Views.Todos.ListView.extend({

    template: JST["yata/templates/todos/inbox"],

    initialize: function (options) {
        $(this.el).attr('id', 'inbox-list');
        $(this.el).addClass('active');
        State.selectedListId = this.model.id;
        Todos.fetch({ data: { list_id: this.model.id } });

        this._super("initialize", [ options ]);
    },

    events: {
        'click .list': 'switchLists'
    }

});