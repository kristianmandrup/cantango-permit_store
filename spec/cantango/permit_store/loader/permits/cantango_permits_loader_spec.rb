require 'spec_helper'
require 'shared'

describe 'Load Permit Store file' do
  let (:file) do
    File.join(config_folder, 'permits.yml')
  end

  let (:loader) { CanTango::PermitStore::Loader::Permits.new file }

  it_behaves_like "Permits Loader"

  it 'load roles group' do
    loader.permits(:roles).admin.static_rules.can.manage.first.should == 'all'
  end

  it 'load role_groups group' do
    loader.permits(:role_groups).bloggers.static_rules.can.read.first.should == 'Article'
  end

  it 'load licenses group' do
    loader.permits(:licenses).editors.static_rules.can.manage.should == ['all']
  end

end
