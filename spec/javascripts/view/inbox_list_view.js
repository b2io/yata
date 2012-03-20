//=require application
//=require todos

describe("Yata.Views.Todos.Lists.InboxListView", function() {

    beforeEach(function(){
        gon = new Object();
        gon['user_id'] = 1;

        this.model = new Yata.Models.List({
            "id": 1,
            "text": "A List"
        });

        Proxy = new Yata.Proxies.TodosProxy();

        this.view = new Yata.Views.Todos.Lists.InboxListView({
            "model": this.model
        });
    });

    it("renders a list anchor element", function() {
        this.view.render();
        expect(this.view.$el).toBe("li");
    });

    it("is the selected list when a user logs in", function() {
        this.view.render();
        expect(Proxy.get('selectedList')).toBe(this.model);
    });
});