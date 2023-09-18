require 'rails_helper'

RSpec.describe TagsController, type: :controller do
  let(:topic) { FactoryBot.create(:topic) }
  let(:post) { FactoryBot.create(:post, topic: topic) }
  let(:tag) { FactoryBot.create(:tag) }

  describe 'GET #index' do
    it 'returns a list of tags' do
      # Assuming you have some tags created with FactoryBot

      get :index, params: { topic_id: topic.id, post_id: post.id }

      expect(response).to be_successful
      expect(assigns(:tags)).to_not be_nil
    end
  end

  describe 'GET #show' do
    it 'returns the details of a tag' do
      post.tags << tag

      get :show, params: { topic_id: topic.id, post_id: post.id, id: tag.id }

      expect(response).to be_successful
      expect(assigns(:tag)).to eq(tag)
    end
  end
end
