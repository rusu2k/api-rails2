class ColumnsController < ApplicationController
    before_action :get_board
    before_action :set_column, only: [:show, :update, :destroy, :reorder]
  
    def index
      columns = @board.columns
      render json: columns, status: :ok
    end
  
  
  
    def show
      if Column.find_by(id: params[:id])
        column = Column.find_by(id: params[:id])
        render json: column, status: :ok
      else
        render json: {
          error: 'Column Not Found'
        }
      end
    end
  
    def create
      column = @board.columns.build(column_params)
  
      if column.save
        render json: column, status: :created
      else
        render json: column.errors, status: :unprocessable_entity
      end
    end
  
    def update
      column = Column.find_by(id: params[:id])
      if column
        column.update(title: params[:title], position: params[:position])
        render json: 'Column Record Updated Successfully'
      else
        render json: {
          error: 'Column Not Found'
        }
      end
    end
  
    def destroy
      column = Column.find_by(id: params[:id])
      if column
        column.destroy
        render json: 'Column has been Destroyed'
      else
        render json: {
          error: 'Column Not Found'
        }
      end
    end
  
    def reorder
      column = @board.columns.find_by(id: params[:id])
      if column
        column.update(title: column.title, position: params[:position])
        render json: 'Column Position Updated Successfully'
      else
        render json: {
          error: 'Column Not Found'
        }
      end
    end
  
    private
    def column_params
      params.require(:column).permit([
        :title,
        :position
      ])
    end
  
    def get_board
      @board = Board.find_by(id: params[:board_id])
    end
  
    def set_column
      @column = @board.columns.find_by(id: params[:id])
    end
  end
  
