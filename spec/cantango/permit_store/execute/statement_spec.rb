require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Statement do
  before do
    @method = :can
    @actions = :edit
    @conditions = 'Project'
    @statement = CanTango::PermitStore::Execute::Statement.new @method, @actions, @conditions
  end

  subject { @statement }
  
  describe 'init' do
    its(:method)      { should == @method }
    its(:actions)     { should == @actions }
    its(:conditions)  { should == @conditions }
  end
end
