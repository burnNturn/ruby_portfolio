require "rails_helper"

RSpec.describe HoldingsController, :type => :controller do
    
    
    before(:each) do 
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_user = sign_in create(:user)
        @valid_user = create(:user)
        @holding1 = create(:holding)
        @holding2 = create(:holding, symbol: "FCAU", quantity: 10, 
            date_opened: "2017-10-31", cost_basis: 11.5, avg_price: 20.5)
    end
    
    describe "GET index" do
        it "has a 200 status code" do
           get :index
           expect(response.status).to eq(200)
        end
        
        it "populates an array of holdings" do
            get :index
            expect(assigns(:holdings)).to eq([@holding1, @holding2])
        end
    end
    
    describe "GET #show" do
        it "assigns the requested holding to @holding" do
            get :show, id: @holding1
            expect(assigns(:holding)).to eq(@holding1)
        end
        
        it "renders the #show view" do
            get :show, id: @holding1
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
        it "assigns the requested holding to @holding" do
            get :edit, id: @holding1
            expect(assigns(:holding)).to eq(@holding1)
        end
        
        it "renders the #edit view" do
            get :edit, id: @holding1
            expect(response).to render_template :edit
        end
    end
    
    describe "POST #create" do
        context "with valid attributes" do
            it "creates a new holding" do
                expect{
                    post :create, holding: attributes_for(:holding)
                }.to change(Holding, :count).by(1)
            end
            
            it "redirects to the new holding" do
                post :create, holding: attributes_for(:holding)
                expect(response).to redirect_to modules_path
            end
        end
        
        context "with invalid attributes" do
            xit "does not save the new holding" do
                expect{
                    post :create, holding: attributes_for(:invalid_holding)
                }.to_not change(Holding, :count)
            end
            
            xit "re-renders the new method" do
                post :create, holding: attributes_for(:invalid_holding)
                expect(response).to render_template :new
            end
        end
    end
    
    describe "PUT update" do
        context "valid attributes" do
            it "located the requested @holding" do
               put :update, id: @holding1, holding: attributes_for(:holding)
               expect(assigns(:holding)).to eq(@holding1)
           end
           
            it "changes @holding's attributes" do
                put :update, id: @holding1,
                    holding: attributes_for(:holding, quantity: 12, avg_price: 45.00)
                @holding1.reload
                expect(@holding1.quantity).to eq(12)
                expect(@holding1.avg_price).to eq(45)
            end
            
            it "redirect to the updated holding" do
                put :update, id: @holding1, holding: attributes_for(:holding)
                expect(response).to redirect_to @holding1
            end
        end
        
        context "invalid attributes" do
            it "locates the requested @holding" do
                put :update, id: @holding1, holding: attributes_for(:invalid_holding)
                expect(assigns(:holding)).to eq(@holding1)
            end
            
            xit "does not change @ holding's attributes" do
                put :update, id: @holding1,
                    holding: attributes_for(:holding, quantity: 25, symbol: nil)
                @holding1.reload
                expect(@holding1.quantity).to_not eq(25)
                expect(@holding1.symbol).to eq("AAPL")
            end
            
            xit "re-renders the edit method" do
                put :update, id: @holding1, holding: attributes_for(:invalid_holding)
                expect(response).to render_template :edit
            end
        end
    end
    
    describe "DELETE destroy" do
        it "deletes the holding" do
            expect{
                delete :destroy, id: @holding1
            }.to change(Holding, :count).by(-1)
        end
        
        it "redirects to holdings#index" do
            delete :destroy, id: @holding1
            expect(response).to redirect_to holdings_url
        end
    end
            
            
end