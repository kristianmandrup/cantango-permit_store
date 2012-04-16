require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Permits do
  before do
    @permits = CanTango::PermitStore::Parser::Permits.new rules
  end
    
  subject do
    @permits
  end
  
  describe '#parse' do
    it 'should parse block' do
      @permits.parse do
        # block
      end
    end
  end
end
