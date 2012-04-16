require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Rule::Relationship do
	let(:method) { :can }
	let(:action) { :read }
	let(:target) { 'Article#author' }

  before do
  	@relationship_rule = CanTango::PermitStore::Parser::Rule::Relationship.new method, action, target
  end
end
