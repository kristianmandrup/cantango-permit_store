require 'spec_helper'

describe 'Load Permits from a Hash' do
  let (:permits_hash) do
    Hashie::Mash.new :user => {'admin' => {'can' => {'read' => 'Article'}} }
  end
  
  before do        
    @loader = CanTango::PermitStore::Loader::Hash.new permits_hash
    @loader.load
  end
  
  it 'load licenses group' do
    @loader.permits(:user).admin.static_rules.can.read.should == ['Article']
  end
end
