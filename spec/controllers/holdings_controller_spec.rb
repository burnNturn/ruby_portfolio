require 'rails_helper'

RSpec.describe HoldingsController, :type => :controller do
    describe "GET index" do
        it "assigns @holdings" do
            holding = Holding.create
            get :index
            expect(assigns(:holdings)).to eq([holding])
        end
        
        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end
    end
end
