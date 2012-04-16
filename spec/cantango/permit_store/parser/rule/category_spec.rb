require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser::Rule::Category do
	let(:method) { :can }
	let(:action) { :read }
	let(:target) { '@articles' }

	let(:bad_target) { '@unknown' }

  before do
  	# register category!
  	CanTango.config.permits.categories do
  		categories.register :unknown => ['Article', 'Post']
  	end
  end

  describe 'Resolve registered category' do
	  before do
	  	# register category!
	  	@category_rule = CanTango::PermitStore::Parser::Rule::Category.new method, action, target
	  end
  end

  describe 'Handle category not registered' do
  	before do
  		@bad_category_rule = CanTango::PermitStore::Parser::Rule::Category.new method, action, bad_target
  	end

  	it 'should ignore category rule' do

  	end

  	it 'should silently add an error' do
  		CanTango.errors.last.should == 'Uknown category: @unknown'
  	end
  end
end