require_relative '../lib/creature.rb'

RSpec.describe Creature do
  describe 'constructor' do
    it 'takes one optional parameter "options={}"' do
      expect(Creature.method(:new).arity).to eq -1
      expect {Creature.new}.not_to raise_error
      expect {Creature.new {}}.not_to raise_error
      expect {Creature.new :foo, {}}.to raise_error(ArgumentError, 'wrong number of arguments (given 2, expected 0..1)')
    end
  end

  describe 'instance variables' do
    before do
      @creature = Creature.new
    end

    it ' @name, @str, @con, @dex, @int, @lvl, @exp, @hp are defined and not nil' do
      instance_variables = %w(@name @str @con @dex @int @lvl @exp @hp)
      expect(@creature.instance_variables).to match(instance_variables.map(&:to_sym))
      instance_variables.each do |variable|
        expect(@creature.instance_variable_get(variable)).not_to be_nil
      end
    end

    it ' to have standard values' do
      {
        name: 'Anonymous Creature',
        str: 1, con: 1, dex: 1, int: 1,
        lvl: 1, exp: 0, hp: 3
      }.each do |key, value|
        expect(@creature.instance_variable_get("@#{key}".to_sym)).to eq(value)
      end
    end
  end

  describe 'instance methods' do
    before do
      @creature = Creature.new
    end

    it ' name, lvl, exp to be defined' do
      %w(name lvl exp).each do |method|
        expect(@creature.respond_to?(method.to_sym)).to be_truthy
        expect(@creature.send(method.to_sym)).not_to be_nil
      end
    end

    it ' alive? is true if @hp > 0' do
      expect(@creature.instance_variable_get(:@hp)).to be > 0
      expect(@creature.alive?).to be_truthy
    end

    it ' wound decreases @hp' do
      @creature.instance_variable_set(:@hp, 4)
      expect {@creature.wound(4)}.to change{@creature.instance_variable_get(:@hp)}.from(4).to(0)
    end

    it ' attack wounds enemy' do
      enemy = Creature.new
      expect {@creature.attack(enemy)}.to change{enemy.instance_variable_get(:@hp)}
      expect {@creature.attack(@creature)}.to raise_error(ArgumentError, "self attack not allowed")
      expect {@creature.attack("My little Pony")}.to raise_error(ArgumentError, "wrong type of enemy")
    end
  end

  describe 'heroes and monsters' do
    before do
      require_relative '../lib/hero'
      require_relative '../lib/monster'

      @creature = Creature.new
      @hero = Hero.new
      @monster = Monster.new
    end

    it 'have a class' do
      expect(defined? Hero).to be_truthy
      expect(defined? Monster).to be_truthy
    end

    it 'have a superclass' do
      expect(Hero.superclass).to eq(Creature)
      expect(Monster.superclass).to eq(Creature)
    end

    it 'print all common information' do
      anon_creature = <<-EOF.chop
Anonymous Creature Level 1
HP = 3
EXP = 0
STR = 1
CON = 1
DEX = 1
INT = 1
      EOF
      anon_hero = "Hero\n" << anon_creature
      anon_monster = "Monster\n" << anon_creature

      expect(@creature.to_s).to eq(anon_creature)
      expect(@hero.to_s).to eq(anon_hero)
      expect(@monster.to_s).to eq(anon_monster)
    end
  end
end
