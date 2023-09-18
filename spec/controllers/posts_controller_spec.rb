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

    describe 'POST #create' do
      context 'with valid attributes and tags' do
        let(:topic) { FactoryBot.create(:topic) }
        let(:valid_post_params) do
            {
              name: 'Sample Post',
              description: 'This is a sample post description',
              topic_id: topic.id,
              new_tag_name: 'Tag1, Tag2'
            }
          end

          it 'creates a new post with tags' do
            expect {
              post :create, params: { post: valid_post_params }
            }.to change(Post, :count).by(1)

            post = Post.last
            expect(response).to redirect_to(topic_post_path(topic, post))
          end
        end

        end

    end