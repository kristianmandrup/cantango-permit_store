require 'spec_helper'

def permit_fixture
  group = 'bloggers'
  rules = Hashie::Mash.new({"can"=>{"read"=>["Article", "Comment"]}, "cannot"=>{"write"=>["Article", "Post"]}})
  CanTango::PermitStore::Parser::Permissions.new.parse(group, rules) do |permit|
    return permit
  end
end

describe CanTango::PermitStore::Execute::Compiler do
  let (:permit) { permit_fixture }

  let(:compiler) do 
    compiler = CanTango::PermitStore::Execute::Compiler.new
    compiler.compile! permit
  end

  it 'should raise if permission contains not-valid actions' do
    expect {compiler.can_eval}.not_to raise_error
    # Replacing static_rules with rule that has not-valid action:
    permit.static_rules.can = Hashie::Mash.new({'edit' => ["Article"]})
    expect {compiler.can_eval}.to raise_error
  end

  it 'should produce cancan statements' do
    compiler.can_eval do |statements|
      statements.should == %|can(:read, Article)\ncan(:read, Comment)|
    end
  end

  it 'should produce cancan statements' do
    compiler.cannot_eval do |statements|
      statements.should == %|cannot(:write, Article)\ncannot(:write, Post)|
    end
  end
end
