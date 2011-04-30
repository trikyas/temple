require 'helper'

module BasicGrammar
  extend Temple::GrammarDSL

  Expression <<
    Symbol |
    Answer |
    [:zero_or_more, 'Expression*'] |
    [:one_or_more,  'Expression+'] |
    [:zero_or_one,  'Expression?'] |
    nil

  Answer << Value(42)

end

module ExtendedGrammar
  extend BasicGrammar

  Expression << [:extended, Expression]
end

describe Temple::GrammarDSL do
  it 'should support class types' do
    BasicGrammar.should.match :symbol
    BasicGrammar.should.not.match 'string'
  end

  it 'should support value types' do
    BasicGrammar.should.match 42
    BasicGrammar.should.not.match 43
  end

  it 'should support nesting' do
    BasicGrammar.should.match [:zero_or_more, [:zero_or_more]]
  end

  it 'should support *' do
    BasicGrammar.should.match [:zero_or_more]
    BasicGrammar.should.match [:zero_or_more, nil, 42]
  end

  it 'should support +' do
    BasicGrammar.should.not.match [:one_or_more]
    BasicGrammar.should.match     [:one_or_more, 42]
    BasicGrammar.should.match     [:one_or_more, 42, nil]
  end

  it 'should support ?' do
    BasicGrammar.should.not.match [:zero_or_one, nil, 42]
    BasicGrammar.should.match     [:zero_or_one]
    BasicGrammar.should.match     [:zero_or_one, 42]
  end

  it 'should support extended grammars' do
    ExtendedGrammar.should.match [:extended, [:extended, 42]]
    BasicGrammar.should.not.match [:multi, [:extended, nil]]
    BasicGrammar.should.not.match [:extended, [:extended, 42]]
  end
end
