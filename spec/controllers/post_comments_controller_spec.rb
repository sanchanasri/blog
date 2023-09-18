require 'rails_helper'

RSpec.describe PostCommentsController, type: :controller do
  describe 'comment creation' do
    it 'renders new successfully' do
      topic = FactoryBot.create(:topic)
      post = FactoryBot.create(:post, topic: topic)
      get :new, params: { :topic_id => topic.id, :post_id => post.id }
      expect(response).to be_successful
    end
  end

  context 'with invalid attributes' do
    it 'does not create a new comment' do
      topic = FactoryBot.create(:topic)
      post = FactoryBot.create(:post, topic: topic)

      expect {
        post :create, params: { :topic_id => topic.id, :post_id => post.id, :post_comment => { :name => '', :description => '' } }
      }.not_to change(PostComment, :count)
    end
  end
end
