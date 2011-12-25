require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Collector do
  before do
    @user = User.new 'kris'
    @ability = CanTango::Ability::Base.new @user
    @permits = []
    @type = :user_type
    @collector = CanTango::PermitStore::Execute::Collector.new @ability, @permits, @type
  end
  
  subject { @collector }
  
  describe 'init' do
    its(:ability) { should == @ability }
    its(:permits) { should == @permits }
    its(:type)    { should == @type }
  end
  
  describe 'build' do
  end
end
