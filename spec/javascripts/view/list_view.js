//=require application
//=require todos

describe("Yata.Views.Todos.Lists.ListView", function() {

    beforeEach(function(){
        gon = new Object();
        gon['user_id'] = 1;

        this.model = new Yata.Models.List({
            "id": 1,
            "text": "A List"
        });

        this.view = new Yata.Views.Todos.Lists.ListView({
            "model": this.model
        });
    });

    it("renders a list anchor element", function() {
        this.view.render();
        expect(this.view.$el).toBe("li");
    });
});