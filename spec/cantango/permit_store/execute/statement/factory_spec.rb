require 'spec_helper'

describe CanTango::PermitStore::Execute::Statement::Factory do
  before do
    @rules = CanTango::PermitStore::Permit::Rules.new
    @targets = ['Project']
    rules.static = {:can => {:edit => ['Project'] } }
    @method = :can
    @actions = [:edit]
    @factory = CanTango::PermitStore::Execute::Statement::Factory.new @rules, @method, @actions
  end
  
  subject { @factory }
  
  describe 'init' do
    its(:rules)   { should == @rules }
    its(:method)  { should == @method }
    its(:actions) { should == @actions }
  end
  
  describe 'targets' do
    its(:targets) { should == @targets }
end