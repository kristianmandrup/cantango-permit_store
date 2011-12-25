require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Execute::Selector do
  before
    @type = :licenses
    # @collector = CanTango::PermitStore::Execute::Collector.new ability, permits, type
  end
  
  describe 'create' do
    before do
      # @selector = CanTango::PermitStore::Execute::Selector.create @type, @collector
    end

    it 'should create a selector' do
      # @selector.create type, collector
    end
  end
end
