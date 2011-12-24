module CanTango
  sweet_scope :ns => {:CanTango => 'cantango_ext'} do
    sweetload :Config
  end
end

require 'cantango_ext/ability/helper/permit_store'