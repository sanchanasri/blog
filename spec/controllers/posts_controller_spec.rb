require "rails_helper"
describe PostsController, type: :controller do


    it 'returns a success response' do
      topic=create(:topic)
      post = create(:post, topic: topic)
      get :show, params: { topic_id: topic.id, id: post.id }
      expect(response).to be_successful
    end

    it"returns the index page" do
      topic=create(:topic)
      post=create(:post, topic: topic)
      get :index, params: {topic_id: topic.id, id: post.id}
      expect(response).to be_successful
    end


end