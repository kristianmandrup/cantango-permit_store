require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Statement do
  before do
    @method = :can
    @actions = :edit
    @conditions = 'Project'
    @statement = CanTango::PermitStore::Execute::Statement.new @method, @actions, @conditions
  end
  
  describe 'init' do
    subject { @statement }
    
    its(:method)      { should == @method }
    its(:actions)     { should == @actions }
    its(:conditions)  { should == @conditions }
  end

  context 'no conditions' do
    describe '#to_code' do
      subject { @statement }    
      before do
        @statement.conditions = nil
      end
      
      it 'should not generate full statement' do
        @statement.to_code.should_not match /:.+,.+/
      end

      it 'should generate simple statement' do
        @statement.to_code.should match /:.+/
      end
    end
  end

  context 'with conditions' do
    describe '#to_code' do
      subject { @statement }    
      before do
        @statement.conditions = @conditions
      end
      
      it 'should generate full statement' do
        @statement.to_code.should match /:.+,.+/
      end
    end
  end
end
