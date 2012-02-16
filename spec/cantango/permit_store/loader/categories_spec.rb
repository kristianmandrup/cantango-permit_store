require 'spec_helper'

describe 'Load Categories rules' do
  let (:file) do
    File.join(config_folder, 'categories.yml')
  end

  it "should load a categories file" do
    loader = CanTango::PermitStore::Loader::Categories.new file
   
    loader.categories['user_models'].should include('Admin')
    loader.categories['articles'].should include('Article')
  end 
end
