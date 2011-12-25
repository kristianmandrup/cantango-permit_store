require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Evaluator do
  before do
    @user = User.new 'kris'
    @ability = CanTango::Ability::Base.new @user
    @rule = Hashie::Mash.new 'can' => { 'read' => ['Article', 'Comment'] }
    @evaluator = CanTango::PermitStore::Execute::Evaluator.new @ability, @rule
  end

  subject { @evaluator }
  
  describe 'init' do  
    its(:ability)     { should == @ability }
    its(:rule)        { should == @rule }
  end
  
  describe '#evaluate!' do
    it 'should evaluate' do
      subject.evaluate!.rules.should_not be_empty
    end
  end
end
