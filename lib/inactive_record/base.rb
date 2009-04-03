require 'active_record'
require 'active_record/base'

module InactiveRecord
  
  class Base
      
    def initialize( attributes={} )
      unless attributes.nil?
        # Fix any dates/times from rails date_select
        keys = attributes.keys
        date_keys = keys.grep(/(1i)/)
        time_keys = keys.grep(/(4i)/)
        date_keys.each do |date_key|
          key = date_key.to_s.gsub( /\(1i\)/, '' )
          num = keys.grep( /#{key.to_s}/ ).size
          if num == 3
            # Date
            attributes[key.to_sym] = Date.civil( attributes.delete( "#{key}(1i)".to_sym ).to_i,
              attributes.delete( "#{key}(2i)".to_sym ).to_i, attributes.delete( "#{key}(3i)".to_sym ).to_i )
          elsif num == 5
            #DateTime
            attributes[key.to_sym] = DateTime.civil( attributes.delete( "#{key}(1i)".to_sym ).to_i,
              attributes.delete( "#{key}(2i)".to_sym ).to_i, attributes.delete( "#{key}(3i)".to_sym ).to_i,
              attributes.delete( "#{key}(4i)".to_sym ).to_i, attributes.delete( "#{key}(5i)".to_sym ).to_i )
          elsif num == 6
            #DateTime
            attributes[key.to_sym] = DateTime.civil( attributes.delete( "#{key}(1i)".to_sym ).to_i,
              attributes.delete( "#{key}(2i)".to_sym ).to_i, attributes.delete( "#{key}(3i)".to_sym ).to_i,
              attributes.delete( "#{key}(4i)".to_sym ).to_i, attributes.delete( "#{key}(5i)".to_sym ).to_i,
              attributes.delete( "#{key}(6i)".to_sym ).to_i )
          end
        end

        attributes.each do |key, value|
          self.instance_variable_set("@#{key}", value)
        end
      end
      yield self if block_given?
    end

    def [](key)
      instance_variable_get("@#{key}")
    end

    def method_missing( method_id, *args )
      if md = /_before_type_cast$/.match(method_id.to_s)
        attr_name = md.pre_match
        return self[attr_name] if self.respond_to?(attr_name)
      end
      super
    end

    # Instructions on how to build xml for an object.
    #
    # *options*
    # :only - A symbol or array of symbols of instance variable names to include in the xml.
    # :except - A symbol or array of symbols of instance variable names to exclude in the xml.
    # :skip_instruct - If true, output the document type, otherwise do not.
    # :skip_types - (not yet) If true, do not output types of variables that are not strings.
    # :include - (not yet) First level associations to include.
    # :dasherize - If true, convert underscored variable names to dasherized variable names.
    #
    def to_xml( options={} )
      options[:indent] ||= 2
      except = options[:except]
      only = options[:only]
      throw 'Both the :except and :only options cannot be used simultaneously.' if !except.nil? && !only.nil?

      except = Array.new << except.to_sym if except.is_a?( String )
      except = Array.new << except if except.is_a?( Symbol )
      only = Array.new << only.to_sym if only.is_a?( String )
      only = Array.new << only if only.is_a?( Symbol )

      dasherize = options[:dasherize]
      dasherize = true unless !dasherize.nil?

      xml = options[:builder] ||= Builder::XmlMarkup.new( :indent => options[:indent] )
      xml.instruct! unless options[:skip_instruct]
      xml.tag!( self.class.to_s.underscore ) do
        self.instance_variables.each do |var|
          var_name = var.to_s.gsub( /@/, '' )
          var_name = var_name.dasherize if dasherize
          if only
            xml.tag!( var_name, self.instance_variable_get( var ) ) if only.include?( var_name ) || only.include?( var_name.to_sym )
          elsif except
            xml.tag!( var_name, self.instance_variable_get( var ) ) unless except.include?( var_name ) || except.include?( var_name.to_sym )
          else
            xml.tag!( var_name, self.instance_variable_get( var ) )
          end
        end
      end
    end

    def new_record?
      true
    end

    def self.self_and_descendents_from_active_record
      [self]
    end

    def self.self_and_descendants_from_active_record
      [self]
    end

    def self.human_name
    
    end

    protected

    def raise_not_implemented_error(*params)
      ValidatingModel.raise_not_implemented_error(*params)
    end

    def self.human_attribute_name(attribute_key_name)
      attribute_key_name.humanize
    end

    alias save raise_not_implemented_error
    alias update_attribute raise_not_implemented_error
    alias save! raise_not_implemented_error

    public
    include ActiveRecord::Validations

    class << self
      def raise_not_implemented_error(*params)
        raise NotImplementedError
      end

      alias validates_uniqueness_of raise_not_implemented_error
      alias create! raise_not_implemented_error
      alias validate_on_create raise_not_implemented_error
      alias validate_on_update raise_not_implemented_error
      alias save_with_validation raise_not_implemented_error
    end

  end
end