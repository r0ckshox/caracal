require 'caracal/core/models/text_field_model'
require 'caracal/errors'


module Caracal
  module Core

    # This module encapsulates all the functionality related to adding text
    # fields to the document.
    #
    module TextFields
      def self.included(base)
        base.class_eval do

          #-------------------------------------------------------------
          # Public Methods
          #-------------------------------------------------------------

          def text_field(*args, &block)
            puts "args: #{args.inspect}"

            options = Caracal::Utilities.extract_options!(args)
            options.merge!({ content: args.first }) if args.first

            model = Caracal::Core::Models::TextFieldModel.new(options, &block)
            puts "model: #{model.inspect}"
            if model.valid?
              contents << model
              puts "contents: #{contents.inspect}"
            else
              raise Caracal::Errors::InvalidModelError, 'Paragraphs and headings, which delegate to the :p command, require at least one text string.'
            end
            model
          end
        end
      end
    end

  end
end
