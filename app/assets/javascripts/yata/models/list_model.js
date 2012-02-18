//= require underscore
//= require backbone
//= require yata/yata

Yata.Models.List = Backbone.Model.extend({
    defaults: function() {
        return {
            id: null,
            text: 'New List',
            order: Lists.length,
            count: 0
        };
    }
});

Yata.Collections.Lists = Backbone.Collection.extend({
    model: Yata.Models.List,
    url: '/lists/',

    nextOrder: function() {
        return this.length;
    },

    comparator: function(list) {
        return list.get('order');
    }
});