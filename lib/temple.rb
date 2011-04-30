require 'temple/version'

module Temple
  autoload :InvalidExpression, 'temple/generators'
  autoload :Generator,         'temple/generators'
  autoload :Generators,        'temple/generators'
  autoload :Engine,            'temple/engine'
  autoload :Utils,             'temple/utils'
  autoload :Mixins,            'temple/mixins'
  autoload :Filter,            'temple/filter'
  autoload :Templates,         'temple/templates'
  autoload :Grammar,           'temple/grammar'
  autoload :GrammarDSL,        'temple/grammar_dsl'

  module ERB
    autoload :Engine,          'temple/erb/engine'
    autoload :Parser,          'temple/erb/parser'
    autoload :Trimming,        'temple/erb/trimming'
  end

  module Filters
    autoload :ControlFlow,     'temple/filters/control_flow'
    autoload :MultiFlattener,  'temple/filters/multi_flattener'
    autoload :StaticMerger,    'temple/filters/static_merger'
    autoload :DynamicInliner,  'temple/filters/dynamic_inliner'
    autoload :Escapable,       'temple/filters/escapable'
    autoload :Eraser,          'temple/filters/eraser'
    autoload :Validator,       'temple/filters/validator'
  end

  module HTML
    autoload :Dispatcher,      'temple/html/dispatcher'
    autoload :Filter,          'temple/html/filter'
    autoload :Fast,            'temple/html/fast'
    autoload :Pretty,          'temple/html/pretty'
  end
end
