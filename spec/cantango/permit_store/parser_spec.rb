require 'spec_helper'
require 'fixtures/models'

describe CanTango::PermitStore::Parser do
  context 'simple targets without categories' do
    let (:parser) do
      CanTango::PermitStore::Parser.new
    end

    let :targets do
      ['all', 'Article', 'Comment']
    end

    it 'should parse targets' do
      pending
      #puts parser.parse(targets)
    end
  end

  context 'targets using categories' do
    let (:categories) do
      cats = {:articles => ['Comment', 'Post']}
      CanTango::Config::Categories.new :my_categories, cats
    end

    let (:parser) do
      CanTango::PermitStore::Parser.new categories
    end

    let :targets do
      ['all', '@articles']
    end

    it 'should parse targets' do
      pending
    end
  end
end

