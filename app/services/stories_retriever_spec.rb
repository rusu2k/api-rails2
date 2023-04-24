require './stories_retriever.rb'
require_relative '../../config/environment.rb'



describe "filter_by_status_and_date" do
    context 'when given column 5 and 2 months span input' do
        let(:column_id) {5} 
        let(:statuses) {[]}
        let(:dates) {(Date.today - 30)..(Date.today + 30)}
        let(:retriever) {StoriesRetriever.new(5)}

        it 'should return 11 columns' do
            
            expect(retriever.filter_by_status_and_date(column_id, statuses: statuses, dates: dates).count).to eq(11)
        end

    end

    context 'when given column 5 no dates and no statuses input' do
      let(:column_id) {5} 
      let(:statuses) {[]}
      let(:dates) {[]}
      let(:retriever) {StoriesRetriever.new(5)}

      it 'should return all 11 columns' do
          
          expect(retriever.filter_by_status_and_date(column_id, statuses: statuses, dates: dates).count).to eq(11)
      end

  end

    context 'when given column 5 and status 2' do
        let(:column_id) {5} 
        let(:statuses) {[2]}
        let(:dates) {[]}
        let(:retriever) {StoriesRetriever.new(5)}

        it 'should return 8 columns' do
            expect(retriever.filter_by_status_and_date(column_id, statuses: statuses, dates: dates).count).to eq(8)
        end
    end

    context 'when given column 5 and status 2 and 2 months span' do
      let(:column_id) {5} 
      let(:statuses) {[2]}
      let(:dates) {(Date.today - 30)..(Date.today + 30)}
      let(:retriever) {StoriesRetriever.new(5)}

      it 'should return 8 columns' do
          expect(retriever.filter_by_status_and_date(column_id, statuses: statuses, dates: dates).count).to eq(8)
      end
  end



end
# TODO
describe "order_by" do
    let!(:column_id) { 5 }
    let!(:stories) { StoriesRetriever.new(5).stories }
    let!(:titles) { stories.map { |story| story.title } }
    let!(:created_ats) { stories.map { |story| story.created_at } }
    let!(:statuses) { stories.map { |story| story.status } }
  

    # HERE
    it "orders stories by title in ascending order by default" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id)

      expect(ordered_stories.map { |story| story.title }).to eq(titles.sort)
    end
  
    it "orders stories by title in descending order" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id,order_column: :title, order_type: :desc)

      expect(ordered_stories.map { |story| story.title }).to eq(titles.sort { |a, b| b <=> a })
    end
  
    it "orders stories by created_at in ascending order" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id, order_column: :created_at, order_type: :asc)

      expect(ordered_stories.map { |story| story.created_at }).to eq(created_ats.sort)
    end
  
    it "orders stories by created_at in descending order" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id, order_column: :created_at, order_type: :desc)

      expect(ordered_stories.map { |story| story.created_at }).to eq(created_ats.sort { |a, b| b <=> a })
    end

    it "orders stories by status in ascending order" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id, order_column: :status, order_type: :asc)

      expect(ordered_stories.map { |story| story.status }).to eq(statuses.sort)
    end
  
    it "orders stories by status in descending order" do
      ordered_stories = StoriesRetriever.new(5).order_by(column_id, order_column: :status, order_type: :desc)

      expect(ordered_stories.map { |story| story.status }).to eq(statuses.sort { |a, b| b <=> a })
    end
  
    it "returns nil if column_id is not present" do
      ordered_stories = StoriesRetriever.new(5).order_by(nil)
      expect(ordered_stories).to be_nil
    end
end


  describe 'filter_order' do
    let(:column) { double('Column', id: 5) }
    let(:stories_retriever) { StoriesRetriever.new(column.id) }

    it 'returns filtered and ordered stories' do

      filtered_stories = stories_retriever.filter_order(
        statuses: [1,2],
        dates: [],
        order_column: :due_date,
        order_type: :desc
      )

      expect(filtered_stories.length).to eq(11)
      expect(filtered_stories.first.status).to eq(1)
      expect(filtered_stories.second.due_date).to be_between(Date.parse("2023-04-24"), Date.parse("2023-04-26"))
    end
  end



=begin

  describe 'filter_order' do
    let(:column) { instance_double('Column') }
    
    let(:story1) { instance_double('Story', id: 1, title: 'AAA', status: 1, due_date: '2023-04-30') }
    let(:story2) { instance_double('Story', id: 2, title: 'BBB', status: 2, due_date: '2023-05-15') }
    let(:story3) { instance_double('Story', id: 3, title: 'CCC', status: 1, due_date: '2023-05-01') }

    let(:stories) { [story1, story2, story3] }



    
      before do
        allow(Column).to receive(:id).and_return(1)
        allow(column).to receive(:stories).and_return([story1,story2,story3])
      end

    context 'when column_id is present' do
      it 'returns filtered and ordered stories' do
        
        #allow(column).to receive(:stories).and_return([story1,story2,story3])
        

        str = StoriesRetriever.new(5)

        allow(str).to receive(:).and_return(story1, story2, story3)

        # PROBLEM WHERE - ON INSTANCE OF ARRAY - WHERE - CLASS METHOD 

        allow(stories).to receive(:where).with(status: 1).and_return([story1, story3])
        allow(stories).to receive(:where).with(due_date: ['2023-04-30', '2023-05-01']).and_return([story1, story3])
        allow(stories).to receive(:reorder).with('due_date DESC').and_return([story3, story1])
        
        result = str.filter_order(statuses: 1, dates: ['2023-04-30', '2023-05-01', '2023-04-19', '2023-05-27'], order_column: 'due_date', order_type: 'DESC')
        
        

        expect([result[0].id, result[1].id]).to eq([story3.id, story1.id])
      end
    end

    context 'when column_id is not present' do
      it 'returns nil' do
        result = StoriesRetriever.new(5).filter_order(statuses: ['1'], dates: ['2023-04-30', '2023-05-01'], order_column: 'due_date', order_type: 'DESC')
        expect(result).to be_nil
      end
    end
  end
  
=end

