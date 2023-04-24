
class BoardsController < ApplicationController
before_action :authenticate_user!


def index

    check_auth

    #boards = Board.all
    

    # Only render the boards for the current user
    boards = Board.where(user_id: current_user.id)
    render json: boards, status: :ok

  end

  
  def show

    check_auth

    if !params[:id].nil?
    
      board = Board.find_by(id: params[:id], user_id: current_user.id)
      authorize board
    end


    if board
      
        render json: board, status: :ok
      
    else
      render json: {
        error: "Board not found!"
      }
    end
  end

  def create

    check_auth

    board = current_user.boards.build(board_params)
    #board = Board.new(board_params)
    #board.user_id = current_user.id

    authorize board
    
    if board.save
      render json: board, status: :created
    else
      render json: {errors: board.errors}, status: :unprocessable_entity
    end
  end

  def update

    check_auth

    board = Board.find_by(id: params[:id])

    
    
    if board
      # Check
      if board.user_id == current_user.id
        begin
          authorize board
          success = board.update(title: params[:title])

          if success
            render json: "Board Record Updated Successfully"
          elsif board.errors.present?
            render json: {errors: board.errors}, status: :unprocessable_entity
          end

        rescue Pundit::NotAuthorizedError => e
          render json: { error: e.message }, status: :unauthorized
        end
        

      else
        render json: {
        error: "Board not yours!"
      }
      end

    else
      render json: {
        error: "Board Not Found"
      }
    end
  end

  def destroy

    check_auth

    board = Board.find_by(id: params[:id])

    
    if board
      # Check
      if board.user_id == current_user.id
        begin
          authorize board
          board.destroy
          render json: "Board Has Been Deleted"
        rescue Pundit::NotAuthorizedError => e
          render json: { error: e.message }, status: :unauthorized
        end
        
        
        
      else
        render json: {
        error: "Board not yours!"
      }
      end 
    else
      render json: {
        error: "Board not Found"
      }
    end
  end

  private
  def board_params
    params.require(:board).permit(  # permit - important security feature : makes so that it accepts only the specified number of parameters
      :title)
  end



  def check_auth
    if !user_signed_in?
      render json: {
        message: "User not authenticated"
      }
    end
  end
end

