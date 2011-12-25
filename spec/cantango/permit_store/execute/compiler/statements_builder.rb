require 'spec_helper'

describe CanTango::PermitStore::Execute::Compiler:StatementsBuilder do
  before do
    static = ''
    method = :can
    actions = [:edit]
    @rules    = CanTango::PermitStore::Permit::Rules.new :static => static
    @builder  = CanTango::PermitStore::Execute::Compiler:StatementsBuilder.new @rules, method, actions
  end

  describe 'init' do
  end
end
