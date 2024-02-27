require 'rails_helper'

RSpec.describe Post, type: :model do
  include FactoryBot::Syntax::Methods
  let(:user) { create(:user) }
  let(:category) { create(:category) }
  subject { Post.new(name: "Cleaning",description: "For 2 days",vacancy: 2,salary: 2000,qualification: "12th pass",user_id: user.id,category_id: category.id)}
  it "is valid with valid attributes" do
    expect(subject).to be_valid
  end
  
  it "is not valid without a name" do
    subject.name=nil
    expect(subject).to_not be_valid
  end 
  
  it "is not valid without a description" do
    subject.description=nil
    expect(subject).to_not be_valid
  end  

  it "is not valid without a vacancy" do
    subject.vacancy=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a salary" do
    subject.salary=nil
    expect(subject).to_not be_valid
  end

  it "is not valid without a qualification" do
    subject.qualification=nil
    expect(subject).to_not be_valid
  end

  it "is not valid if the vacancy is not digit" do
    expect( (subject.vacancy).to_s.match?(/\A\d+\Z/) ).to eq(true)
  end  

  it "is not valid if the salary is not digit" do
    expect( (subject.salary).to_s.match?(/\A\d+\Z/) ).to eq(true)
  end 
end
