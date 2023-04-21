class StoriesController < ApplicationController

    before_action :get_board
    before_action :get_column
    before_action :set_story, only: [:show, :update, :destroy]
    
  
    def index
      stories = @column.stories
  
      status = []
      date = []
      column = :title
      type = :asc
  
    #   if params[:status].present?
    #     status = params[:status].split(',')
    #   end
  
    #   if params[:due_date].present?
    #     date = params[:due_date].split(',')
    #   end
  
    #   if params[:order_column].present?
    #     column = params[:column]
    #   end
  
    #   if params[:order_type].present?
    #     type = params[:order_type]
    #   end
  
      # stories = StoriesRetriever.new.filter_order(
      #   params[:column_id],
      #   statuses: status,
      #   dates: date,
      #   order_column: column,
      #   order_type: type
      # )
  
      # stories = StoriesRetriever.new.order_by(
      #   params[:column_id],
      #   order_column: :status,
      #   order_type: :desc
      #   )
  
      # stories = StoriesRetriever.new.filter_by_status_and_date(
      #   params[:column_id],
      #   statuses: 1,
      #   dates: []#(Date.today - 30)..(Date.today + 30)
      # )
  
      render json: stories, status: :ok
    end
  
    def filtered
      stories = @column.stories
  
  
      if params[:status].present?
        statuses = params[:status].split(',')
        stories = stories.where(status: statuses)
      end
  
      if params[:due_date].present?
        due_dates = params[:due_date].split(',')
        stories = stories.where(due_date: due_dates)
      end
  
      render json: stories, status: :ok
    end
  
    def show
      story = Story.find_by(id: params[:id])
      if story
        render json: story, status: :ok
      else
        render json: {
          error: "Story not found"
        }
      end
    end
  
    def create
      story = @column.stories.build(story_params)
      if story.save
        render json: story, status: :created
      else
        render json: story.errors, status: :unprocessable_entity
      end
    end
  
    def update
      story = Story.find_by(id: params[:id])
      if story
        story.update(title: params[:title], content: params[:content], status: params[:status], due_date: params[:due_date])
        render json: 'Story Record Updated Successfully'
      else
        render json: {
          error: 'Story Not Found'
        }
      end
    end
  
    def destroy
      story = Story.find_by(id: params[:id])
      if story
        story.destroy
        render json: 'Story Has Been Deleted'
      else
        render json: {
          error: 'Story Not Found'
        }
      end
    end
  
    private
    def story_params
      params.require(:story).permit([
        :title,
        :content,
        :status,
        :due_date
      ])
    end
  
    def get_board
      @board = Board.find_by(id: params[:board_id])
    end
  
    def get_column
      @column = @board.columns.find_by(id: params[:column_id])
    end
  
    def set_story
      @story = @column.stories.find_by(id: params[:id])
    end
  
  end
  