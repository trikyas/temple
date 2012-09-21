unless Object.const_defined?(:Rails)
  raise "Rails is not loaded - Temple::Templates::Rails cannot be used"
end

if ::Rails::VERSION::MAJOR < 3
  raise "Temple supports only Rails 3.x and greater, your Rails version is #{::Rails::VERSION::STRING}"
end

module Temple
  module Templates
    if ::Rails::VERSION::MAJOR == 3 && ::Rails::VERSION::MINOR < 1
      class Rails < ActionView::TemplateHandler
        include ActionView::TemplateHandlers::Compilable
        extend Mixins::Template

        def compile(template)
          self.class.compile(template.source,
                             ImmutableHash.new({ :file => template.identifier, :streaming => false },  # Overwrite option: No streaming support in Rails < 3.1
                                               self.class.default_options).without(:engine, :register_as))
        end

        def self.register_as(name)
          ActionView::Template.register_template_handler name.to_sym, self
        end
      end
    else
      class Rails
        extend Mixins::Template

        def call(template)
          self.class.compile(template.source,
                             ImmutableHash.new({ :file => template.identifier },
                                               self.class.default_options).without(:engine, :register_as))
        end

        def supports_streaming?
          self.class.default_options[:streaming]
        end

        def self.register_as(name)
          ActionView::Template.register_template_handler name.to_sym, new
        end
      end
    end
  end
end
