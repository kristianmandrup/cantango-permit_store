require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Rule::Regex do
	let(:method) { :can }
	let(:action) { :read }
	let(:target) { '/Art/' }

  before do
  	@regex_rule = CanTango::PermitStore::Parser::Rule::Regex.new method, action, target
  end
end
