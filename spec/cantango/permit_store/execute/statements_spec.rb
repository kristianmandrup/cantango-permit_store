require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Statements do
  before do
    @method = :can
    @actions = :edit
    @targets = ['Project']
    
    @statements = CanTango::PermitStore::Execute::Statements.new @method, @actions, @targets
  end

  subject { @statements }
  
  describe 'init' do  
    its(:method)    { should == @method }
    its(:actions)   { should == @actions }
    its(:targets)   { should == @targets }
  end

  describe '#to_code' do
    it 'should generate statements' do
      @statements.to_code.should == "can(#{@actions.inspect}, #{@targets.first})"
    end
  end
end
