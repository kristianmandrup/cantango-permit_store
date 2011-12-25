require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Evaluator do
  before do
    @user = User.new 'kris'
    @ability = CanTango::Ability::Base.new @user
    @statement = CanTango::PermitStore::Execute::Statement::Single.new :can, [:edit], [:Project]
    @evaluator = CanTango::PermitStore::Execute::Evaluator.new @ability, @statement
  end

  subject { @evaluator }
  
  describe 'init' do  
    its(:ability)       { should == @ability }
    its(:statement)     { should == @statement }
  end
  
  describe '#evaluate!' do
    it 'should evaluate' do
      subject.evaluate!.rules.should_not be_empty
    end
  end
end
