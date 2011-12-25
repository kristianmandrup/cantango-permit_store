require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::PermitsFactory do
  before do
    @user     = User.new 'kris'
    @ability  = CanTango::Ability::Base.new @user
    @factory  = CanTango::PermitStore::PermitsFactory.new @ability
  end

  subject { @factory }
  
  describe 'init' do
    its(:ability) { should == @ability }
  end 
end