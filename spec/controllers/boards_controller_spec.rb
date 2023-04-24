require "rails_helper"


RSpec.describe BoardsController, type: :controller do
  before do
    allow(controller).to receive(:authorize).and_return(true)
  end
    describe "GET #index" do
      
        context "when user is not authenticated" do
            
            it "returns a 401 unauthorized status" do
                get :index
                expect(response).to have_http_status(:unauthorized)
            end
        end
        
        context "when user is authenticated" do
            let(:user) { FactoryBot.create(:user) }
            before { sign_in user }
    
            it "returns http success" do
                get :index
                expect(response).to have_http_status(:success)
            end
    
            it "returns only the boards for the current user" do
                board = FactoryBot.create(:board, user_id: user.id)
                board2 = FactoryBot.create(:board, user_id: user.id)
                get :index
                boards = JSON.parse(response.body)
                expect(boards.length).to eq(2)
                expect(boards.first["user_id"]).to eq(user.id)
            end
        end
  
      
    end
  
    describe "GET #show" do
      let(:user) { FactoryBot.create(:user) }
      let(:user1) { FactoryBot.create(:user) }
      before { sign_in user }
  
      context "when board belongs to current user" do
        let(:board) { FactoryBot.create(:board, user_id: user.id) }
  
        it "returns http success" do
          get :show, params: { id: board.id }
          expect(response).to have_http_status(:success)
        end
  
        it "returns the requested board" do
          get :show, params: { id: board.id }
          expect(JSON.parse(response.body)["id"]).to eq(board.id)
        end
      end
  
      context "when board doesn't belong to current user" do
        let(:board) { FactoryBot.create(:board, user_id: user1.id) }
  
        it "returns an error message" do
          get :show, params: { id: board.id }
          expect(JSON.parse(response.body)["error"]).to eq("Board not found!")
        end
      end
  
      context "when board is not found" do
        it "returns an error message" do
          get :show, params: { id: 999 }
          expect(JSON.parse(response.body)["error"]).to eq("Board not found!")
        end
      end
    end
  
    describe "POST #create" do
      let(:user) { FactoryBot.create(:user) }
      before { sign_in user }
  
      context "with valid params" do
        let(:board_params) { FactoryBot.attributes_for(:board) }
  
        it "creates a new board" do
          expect {
            post :create, params: { board: board_params }
          }.to change(Board, :count).by(1)
          expect(response).to have_http_status(:created)
        end
  
        
      end
  
      context "with invalid params" do
        let(:invalid_attributes) { { board: { title: nil } } }
    
        it "returns a 422 status code" do
          post :create, params: invalid_attributes
          expect(response.status).to eq(422)
        end
    
        it "returns the errors messages" do
          post :create, params: invalid_attributes
          expect(JSON.parse(response.body)["errors"]["title"]).to include("can't be blank")
        end
      end
    end
    # TEST UPDATE CU VALIDARI
end