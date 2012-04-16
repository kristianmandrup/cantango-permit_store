require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::PermitMode do
	let(:name) { 'role'  }
	let(:mode) { 'cache' }
	let(:rules) do
		{:admin => {:can => {:read => ['Article', 'Post']}}}
	end

  before do
  	@permit_mode = CanTango::PermitStore::Parser::PermitMode.new name, mode, rules
  end
end
