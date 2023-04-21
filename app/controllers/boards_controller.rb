class BoardsController < ApplicationController
#before_action :authenticate_user!


def index

    #check_auth

    boards = Board.all
    render json: boards, status: :ok

  end

  
  def show

    #check_auth

    board = Board.find_by(id: params[:id])
    if board
      render json: board, status: :ok
    else
      render json: {
        error: "Board not found"
      }
    end
  end

  def create

    #check_auth

    board = Board.new(board_params)
    #board.user_id = current_user.id
    
    if board.save
      render json: board, status: :created
    else
      render json: board.errors, status: :unprocessable_entity
    end
  end

  def update

    #check_auth

    board = Board.find_by(id: params[:id])
    if board
      board.update(title: params[:title])
      render json: "Board Record Updated Successfully"
    else
      render json: {
        error: "Board Not Found"
      }
    end
  end

  def destroy

    #check_auth

    board = Board.find_by(id: params[:id])
    if board
      board.destroy
      render json: "Board Has Been Deleted"
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



  # def check_auth
  #   if user_signed_in? == false
  #     render json: {
  #       message: "User not authenticated"
  #     }
  #   end
  # end
end

