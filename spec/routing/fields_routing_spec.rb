require "spec_helper"

describe FieldsController do
  describe "routing" do

    it "routes to #index" do
      get("/fields").should route_to("fields#index")
    end

    it "routes to #new" do
      get("/fields/new").should route_to("fields#new")
    end

    it "routes to #show" do
      get("/fields/1").should route_to("fields#show", :id => "1")
    end

    it "routes to #edit" do
      get("/fields/1/edit").should route_to("fields#edit", :id => "1")
    end

    it "routes to #create" do
      post("/fields").should route_to("fields#create")
    end

    it "routes to #update" do
      put("/fields/1").should route_to("fields#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/fields/1").should route_to("fields#destroy", :id => "1")
    end

    it "routes to #accept" do
      put("/fields/1/accept").should route_to("fields#accept", :id => "1")
    end

    it "routes to #reject" do
      put("/fields/1/reject").should route_to("fields#reject", :id => "1")
    end

    it "routes to #reset" do
      put("/fields/1/reset").should route_to("fields#reset", :id => "1")
    end

    it "routes to #pending" do
      get("/fields/pending").should route_to("fields#pending")
    end

    it "routes to #accepted" do
      get("/fields/accepted").should route_to("fields#accepted")
    end

    it "routes to #rejected" do
      get("/fields/rejected").should route_to("fields#rejected")
    end

    it "routes to #homepage" do
      get("/fields/homepage").should route_to("fields#homepage")
    end

  end
end
