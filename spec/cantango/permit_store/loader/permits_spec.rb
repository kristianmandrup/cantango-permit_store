require 'spec_helper'
require 'shared'

describe CanTango::PermitStore::Loader::Permits do
  let (:type) { :user }
  let (:permits_hash) do
    Hashie::Mash.new {'admin' => {'can' => {'read', 'Article'}} }
  end
  let (:loader) { CanTango::PermitStore::Loader::Permits.new type, permits_hash }
  
  subject { loader }
  
  it 'should load' do
    subject.load
  end
end