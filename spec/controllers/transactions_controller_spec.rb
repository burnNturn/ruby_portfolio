require "rails_helper"

RSpec.describe TransactionsController, :type => :controller do
    
    before(:each) do
        @request.env["devise.mapping"] = Devise.mappings[:user]
        @valid_user = sign_in create(:user)
        @valid_user = create(:user)
        @holding = create(:holding)
        @transaction = create(:transaction)
        @transaction.holding = @holding
    end
    
    describe "GET index" do
        it "has a 200 status code" do
            get :index
            expect(response.status).to eq(200)
        end
        
        it "populates an array of transactions" do
            get :index
            expect(assigns(:transactions)).to eq([@transaction])
        end
    end
    
    describe "GET #show" do
        it "assigns the requested transaction to @transaction" do
            get :show, id: @transaction
            expect(assigns(:transaction)).to eq(@transaction)
        end
        
        it "renders the #show view" do
            get :show, id: @transaction
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
        it "assigns the requested transaction to @transaction" do
            get :edit, id: @transaction
            expect(assigns(:transaction)).to eq(@transaction)
        end
        
        it "renders the #edit view" do
            get :edit, id: @transaction
            expect(response).to render_template :edit
        end
    end
    
    describe "POST #create" do
        context "with Valid attributes" do
            it "creates a new transaction" do
                expect{
                    post :create, transaction: attributes_for(:transaction)
                }.to change(Transaction, :count).by(1)
            end
            
            it "redirects to the new transaction" do
                post :create, transaction: attributes_for(:transaction)
                expect(response).to redirect_to Transaction.last
            end
        end
        
        context "with invalid attributes" do
            xit "does not save the new transaction" do
                expect{
                    post :create, transaction: attributes_for(:invalid_transaction)
                }.to_not change(Transaction, :count)
            end
            
            xit "re-renders the new method" do
                post :create, transaction: attributes_for(:invalid_transaction)
                expect(response).to render_template :new
            end
        end
    end
    
    describe "PUT update" do
        context "with valid attributes" do
            it "locates the requested @transaction" do
                put :update, id: @transaction, transaction: attributes_for(:transaction)
                expect(assigns(:transaction)).to eq(@transaction)
            end
            
            it "changes @transaction's attributes" do
                put :update, id: @transaction, transaction: attributes_for(:transaction, 
                    symbol: "BA", price: 312.0)
                @transaction.reload
                expect(@transaction.symbol).to eq("BA")
                expect(@transaction.price).to eq(312)
            end
            
            it "redirects to the updated transaction" do
                put :update, id: @transaction, transaction: attributes_for(:transaction)
                expect(response).to redirect_to @transaction
            end
        end
        
        context "with invalid attributes" do
            it "locates the requested @transaction" do
                put :update, id: @transaction, transaction: attributes_for(:invalid_transaction)
                expect(assigns(:transaction)).to eq(@transaction)
            end
            
            xit "does not change @transaction's attributes" do
                put :update, id: @transaction, transaction: attributes_for(:transaction,
                    symbol: nil, price: 1.25)
                    @transaction.reload
                expect(@transaction.symbol).to_not eq(nil)
                expect(@transaction.price).to_not eq(1.25)
            end
            
            xit "re-renders the edit method" do
                put :update, id: @transaction, transaction: attributes_for(:invalid_transaction)
                expect(response).to render_template :edit
            end
        end
    end
    
    describe "DELETE destroy" do
        it "deletes the transaction" do
            expect{
                delete :destroy, id: @transaction
            }.to change(Transaction, :count).by(-1)
        end
        
        it "redirects to transactions#index" do
            delete :destroy, id: @transaction
            expect(response).to redirect_to transactions_url
        end
    end
end