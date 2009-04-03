$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'inactive_record/base'

module InactiveRecord
  VERSION = '1.0.0'
end