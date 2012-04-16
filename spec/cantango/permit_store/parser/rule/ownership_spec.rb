require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Rule::Ownership do
	let(:method) { :can }
	let(:action) { :read }
	let(:target) { 'Article' } # see ownership

  before do
  	@ownership_rule = CanTango::PermitStore::Parser::Rule::Ownership.new method, action, target
  end
end
