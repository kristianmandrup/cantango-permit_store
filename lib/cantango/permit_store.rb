require 'sugar-high/array'
require 'sugar-high/blank'
require 'hashie'
require 'sweetloader'

SweetLoader.namespaces = {:CanTango => 'cantango'}
SweetLoader.mode = :require

module CanTango
  module PermitStore
    sweetload :Base, :Yaml, :Moneta
    sweetload :Execute, :Loader, :PermitsFactory, :Permit, :Parser
  end
end

require 'cantango_ext/permit_store'


