require 'active_support'
require 'active_support/core_ext'

class StoriesRetriever

    def filter_order(stories, statuses:, dates:, order_column: :title, order_type: :asc)
        return unless stories.present?

        #stories = load_stories(column_id)

        puts stories.inspect
        stories = stories.where(status: statuses) if statuses.present?
        stories = stories.where(due_date: dates) if dates.present?

        order_column ||= :title
        order_type ||= :asc

        stories = stories.reorder(order_column => order_type)

        stories

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
