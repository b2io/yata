//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require bootstrap/2.0.1/bootstrap
//= require json2/json2
//= require underscore
//= require backbone
//= require yata/yata
//= require yata/models/todo_model
//= require yata/models/list_model
//= require yata/routers/todos_router

$(function() {
    window.Dispatcher = _.extend({}, Backbone.Events);
    window.Todos = new Yata.Collections.Todos();
    window.Lists = new Yata.Collections.Lists();
    window.Router = new Yata.Routers.TodosRouter();
    Backbone.history.start();
});