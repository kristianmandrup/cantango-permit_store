require 'spec_helper'
require 'cantango/permit_store/loader/shared_ex'

describe 'Load Permit Store file' do
  let (:file) do
    File.join(config_folder, 'permits.yml')
  end

  let (:loader) { CanTango::PermitStore::Loader::Yaml.new file }

  it_behaves_like "Permits Loader"

  it 'load licenses group' do
    loader.permits(:licenses).editors.static_rules.can.manage.should == ['all']
  end
end
