require 'active_support'
require 'active_support/core_ext'

class StoriesRetriever

    attr_reader :stories
    
    def initialize(column_id)
        raise "Column ID Missing!" if column_id.blank?
        @stories = load_stories(column_id)
    end

    def filter_order(statuses:, dates:, order_column: :title, order_type: :asc)
        return [] unless @stories.present?

        filtered_stories = @stories

        filtered_stories = filtered_stories.where(status: statuses) if statuses.present?
        filtered_stories = filtered_stories.where(due_date: dates) if dates.present?
        filtered_stories = filtered_stories.reorder(order_column => order_type) if order_column.present? && order_type.present?

        filtered_stories

    end

    def load_stories(column_id)
        Column.find_by(id: column_id).stories
    end



    def filter_by_status_and_date(column_id, statuses: , dates: )
        return [] unless column_id.present?
        
        column = Column.find(column_id)

        stories = column.stories

        stories = stories.where(status: statuses) if statuses.present?
        stories = stories.where(due_date: dates) if dates.present?

        stories
    end

    def order_by(column_id, order_column: :title , order_type: :asc)
        
        return unless column_id.present?
        
        #order_column ||= :title
        #order_type ||= :asc
        column = Column.find_by(id: column_id)
        
        stories = column.stories.reorder(order_column => order_type)

        stories
    end


    
    #def order_by(order_column) # mandatory without default value

    #def order_by() # mandatory with def value

    #def order_by(order_column = :title) # optional with def value
    #def order_by(order_column: :title) # optional with def value


end
