require 'rails_helper'

RSpec.describe PostComment, type: :model do
  let(:post) do
    Post.create(name: "Sample Post")
  end

  subject {
    described_class.new(name: "sanchana", description: "This is com_description", post: post)
  }

  it 'is valid with com_description' do
    expect(subject).to be_valid
  end

  it 'is not valid without com_description' do
    subject.description = nil
    expect(subject).to be_invalid
  end
end
