require 'spec_helper'

describe Todo do
  describe "GET /todos" do
    it "displays text" do
      Todo.create(:text => "This is a todo")
      get todos_path
      response.body.should include("This is a todo")
    end
  end
end
