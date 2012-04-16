require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Permit do
	let(:name) { 'role' }
	let(:permit_rules) do
		{:admin => {:can => {:read => ['Article', 'Post']}}}
	end
  
  before do
  	@permit = CanTango::PermitStore::Parser::Permit.new name, permit_rules
  end

  subject { @permit }

  describe '#parse' do
  	it 'should parse a block' do
  		@permit.parse do
  		end
  	end
  end
end
