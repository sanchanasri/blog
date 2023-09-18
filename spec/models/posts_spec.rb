require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:topic) do
    Topic.create(
      name: "new topic"
    )
  end
  let(:post) do
    described_class.new(
      name: "sample",
      description: "this is sample story",
      topic: topic
    )
  end
  it"checking title to be valid" do
    expect(post).to be_valid
  end

  it"checking nil title in not valid" do
    post.name=nil
    expect(post).to_not be_valid
  end

  it"checking for title that is too long" do
    post.name='a' * 2300
    expect(post).to_not be_valid
  end

  it"checking valid length title" do
    post.name='a'*250
    expect(post).to be_valid
  end

  it"checking content to be invalid" do
    post.description=nil
    expect(post).to_not be_valid
  end

end
