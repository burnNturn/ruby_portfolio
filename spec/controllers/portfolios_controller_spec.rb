require "rails_helper"

RSpec.describe PortfoliosController, :type => :controller do
    
    
    before(:each) do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_user = sign_in create(:user)
        @valid_user = create(:user)
        @portfolio1 = create(:portfolio)
        @portfolio2 = create(:portfolio, name: "portfolio_test2", 
            equities_value: 655.5, cash_balance: 177.33)
    end
    
    describe "GET index" do
        it "has a 200 status code" do
           get :index
           expect(response.status).to eq(200)
        end
        
        it "populates an array of portfolioss" do
            get :index
            expect(assigns(:portfolios)).to eq([@portfolio1, @portfolio2])
        end
    end
    
    describe "GET #show" do
        it "assigns the requested portfolio to @portfolio" do
            get :show, id: @portfolio1
            expect(assigns(:portfolio)).to eq(@portfolio1)
        end
        
        it "renders the #show view" do
            get :show, id: @portfolio1
            expect(response).to render_template :show
        end
    end
    
    describe "GET #new" do
        it "renders the #new view" do
            get :new
            expect(response).to render_template :new
        end
    end
    
    describe "GET #edit" do
        it "assigns the requested portfolio to @portfolio" do
            get :edit, id: @portfolio1
            expect(assigns(:portfolio)).to eq(@portfolio1)
        end
        
        it "renders the #edit view" do
            get :edit, id:@portfolio1
            expect(response).to render_template :edit
        end
    end
    
    describe "POST #create" do
       context "with valid attributes" do
           it "creates a new portfolio" do
               expect{
                   post :create, portfolio: attributes_for(:portfolio)
               }.to change(Portfolio, :count).by(1)
           end
           
           it "redirects to the new portfolio" do
               post :create, portfolio: attributes_for(:portfolio)
               expect(response).to redirect_to modules_path
           end
       end
       
       context "with invalid attributes" do
           xit "does not save the new portfolio" do
               expect{
                   post :create, portfolio: attributes_for(:portfolio)
               }.to_not change(Portfolio, :count)
           end
           
           xit "re-renders the new method" do
               post :create, portfolio: attributes_for(:portfolio)
               expect(response).to render_template :new
           end
       end
    end
    
    describe "PUT #update" do
        context "with valid attributes" do
            it "locates the requested @portfolio" do
                put :update, id: @portfolio1, portfolio: attributes_for(:portfolio)
                expect(assigns(:portfolio)).to eq(@portfolio1)
            end
            
            it "changes @portfolio1's attributes" do
                put :update, id: @portfolio1, 
                    portfolio: attributes_for(:portfolio, name: "name_change", 
                    equities_value: 642.5)
                @portfolio1.reload
                expect(@portfolio1.name).to eq("name_change")
                expect(@portfolio1.equities_value).to eq(642.5)
            end
            
            it "redirects to the updated portfolio" do
                put :update, id: @portfolio1, portfolio: attributes_for(:portfolio)
                expect(response).to redirect_to @portfolio1
            end
        end
        
        context "with invalid attributes" do
            it "locates the requested @portfolio1" do
                put :update, id: @portfolio1, portfolio: attributes_for(:invalid_holding)
                expect(assigns(:portfolio)).to eq(@portfolio1)
            end
            
            xit "does not change @portfolio1's attributes" do
                put :update, id: @portfolio1,
                portfolio: attributes_for(:portfolio, name: nil, quantity: 0)
                expect(@portfolio1.name).to_not eq(nil)
                expect(@portfolio.quantity).to_not eq(0)
            end
            
            xit "re-renders the edit method" do
                put :update, id: @portfolio1, portfolio: attributes_for(:invalid_holding)
                expect(response).to render_template :edit
            end
        end
    end
    
    describe "DELETE destroy" do
        it "deletes the portfolio" do
            expect{
                delete :destroy, id: @portfolio1
            }.to change(Portfolio, :count).by(-1)
        end
        
        it "redirects to portfolio#index" do
            delete :destroy, id: @portfolio1
            expect(response).to redirect_to portfolios_url
        end
    end
                
end