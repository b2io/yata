//=require application
//=require todos

describe("Yata.Views.Todos.Todos.TodoView", function() {

    beforeEach(function(){
        gon = new Object();

        this.model = new Yata.Models.Todo({
            "id": 1,
            "text": "This is a todo"
        });

        this.view = new Yata.Views.Todos.Todos.TodoView({
            "model": this.model
        });
    });


    it("renders a todo list item", function() {
        this.view.render();
        expect(this.view.$el).toBe("li");
    });

    it("renders todo.text in .todo-label and .todo-input", function() {
        this.view.render();
        expect(this.view.$el.find('.todo-label')).toHaveText('This is a todo');
        expect(this.view.$el.find('.todo-input')).toHaveValue('This is a todo');
    });

    it("todo is unchecked by default", function() {
        this.view.render();
        expect(this.view.$el.find('.todo-check')).toBeUnchecked();
    });

    it("todo is checked when marked checked", function() {
        this.model.set('done', true);
        this.view.render();
        expect(this.view.$el.find('.todo-check')).toBeChecked();
    });
});
