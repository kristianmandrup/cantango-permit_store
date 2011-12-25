require 'spec_helper'

describe CanTango::PermitStore::Compiler:StatementsBuilder do
  before do
    @rules    = CanTango::PermitStore::Permit::Rules.new 
    @builder  = CanTango::PermitStore::Compiler:StatementsBuilder.new @rules, method, actions
  end
  describe 'init' do
    
end
