require 'rails_helper'

RSpec.describe PortfoliosController, :type => :controller do
    fixtures :users, :portfolios
    
    describe "GET index" do
        
        it "assigns @portfolios" do
            get :index
            expect(assigns(:portfolios)).not_to be_nil
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
    
    describe "CREATES Portfolio" do
        let(:valid_params) { {:portfolio => {cash_balance: 20.00, 
            equities_value: 320, name: "test portfolio"} }}
        before :each do     
            @request.env["devise.mapping"] = Devise.mappings[:user]
            sign_in users(:one)
        end
        it "adds an entry to the database" do
            expect{ 
                post :create, valid_params
                }.to change(Portfolio, :count).by(1)
        end
        it "renders the user to their modules page" do
            post :create, valid_params
            expect(response).to redirect_to modules_path()
        end
    end
    
    describe "SHOW portfolio" do
        it "shows the portfolio page" do
            get :show, id: portfolios(:one)
            expect(response).to render_template("show")
        end
    end
    
    describe "Edit portfolio" do
       it "renders the edit page for a holding" do
          get :edit, id: portfolios(:one)
          expect(response).to render_template("edit")
       end
    end
    
    describe "UPDATE portfolio" do
       it "it successfully updates the holding" do
          patch :update, id: portfolios(:one), portfolio: {cash_balance: 200}
          expect(response).to redirect_to(portfolio_path(assigns(:portfolio)))
       end
    end
    
    describe "DESTROY portfolio" do
       it "successfully destroys the portfolio" do
          expect{
              delete :destroy, id: portfolios(:one)
          }.to change(Portfolio, :count).by(-1)
       end
       it "redirects to portfolios_path after destroy" do
          delete :destroy, id: portfolios(:one)
          expect(response).to redirect_to(portfolios_path)
       end
    end
end