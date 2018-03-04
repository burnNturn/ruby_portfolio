require 'rails_helper'

RSpec.describe HoldingsController, :type => :controller do
    fixtures :users, :holdings, :portfolios
    # @request.env["devise.mapping"] = Devise.mappings[:user]
    # user = sign_in users(:one)
    before :each do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_user = sign_in users(:one)
        @invalid_user = sign_in users(:two)
        @valid_user = FactoryGirl.create(:user_with_valid_credentials)
    end
    
    describe "GET index" do
        
        it "assigns @holdings" do
            get :index
            expect(assigns(:holdings)).not_to be_nil
        end
        
        it "renders the index template" do
            get :index
            expect(response).to render_template("index")
        end
    end
    
    describe "GET new" do
        it "renders the new template" do
            get :new
            expect(response).to render_template("new")
         end 
    end
    
    describe "CREATES holding" do
        let(:valid_params) { {:holding => {symbol: 'AAPL', quantity: 3, 
                avg_price: 25.30, portfolio_id: portfolios(:one)} }}
        before :each do     
            @request.env["devise.mapping"] = Devise.mappings[:user]
            sign_in users(:one)
        end
        it "adds an entry to the database" do
            expect{ 
                post :create, valid_params
                }.to change(Holding, :count).by(1)
        end
        it "renders the user to their modules page" do
            post :create, valid_params
            expect(response).to redirect_to modules_path()
        end
    end
    
    describe "SHOW holding" do
        it "shows the holding page" do
            get :show, id: holdings(:one)
            expect(response).to render_template("show")
        end
    end
    
    describe "Edit holding" do
       it "renders the edit page for a holding" do
          get :edit, id: holdings(:one)
          expect(response).to render_template("edit")
       end
    end
    
    describe "UPDATE holding" do
       it "it successfully updates the holding" do
          patch :update, id: holdings(:one), holding: {quantity: 200}
          expect(response).to redirect_to(holding_path(assigns(:holding)))
       end
    end
    
    describe "DESTROY holding" do
       it "successfully destroys the holding" do
          expect{
              delete :destroy, id: holdings(:one)
          }.to change(Holding, :count).by(-1)
       end
       it "redirects to holdings_path after destroy" do
          delete :destroy, id: holdings(:one)
          expect(response).to redirect_to(holdings_path)
       end
    end
end

