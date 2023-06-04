require_relative '../lib/game'
require_relative '../lib/creature'
require_relative '../lib/hero'
require_relative '../lib/monster'

RSpec.describe Game do
  describe 'the game' do
    it 'defines a module' do
      expect(defined? Game).to be_truthy
      expect(Game.is_a? Module).to be_truthy
    end

    it 'defines a method fight' do
      expect(Game.respond_to?(:fight)).to be_truthy
      expect(Game.method(:fight).arity).to eq 2
    end

    it 'will cage fight two opponents until one gives the spoon away' do
      hero = Hero.new name: 'Deadpool', con: 9001
      monster = Monster.new name: 'Jar Jar Binks'

      Game.fight(hero, monster)
      expect(hero.alive? && monster.alive?).to be_falsy
    end
  end

  describe 'methods of the game' do
    it 'can create a random monster' do
      monster = Game.create_monster
      expect(monster).to be_a(Monster)
    end

    it 'creates a bunch of monsters' do
      bunch_o_monsters = Game.create_monsters
      expect(bunch_o_monsters).to be_a(Array)
      bunch_o_monsters.each do |monster|
        expect(monster).to be_a(Monster)
      end
    end

    it 'returns a random monster' do
      require_relative '../lib/array'
      expect(Game.create_monsters.rand).to be_a(Monster)
    end
  end

  describe 'level system' do
    it 'defines levelup modules' do
      require_relative '../lib/game/experience'
      expect(defined? Game::Experience).to be_truthy
      expect(defined? Game::Experience::Source).to be_truthy
      expect(defined? Game::Experience::Receiver).to be_truthy
    end

    it 'defines xp method for xp source' do
      require_relative '../lib/game/experience'

      class Source
        include Game::Experience::Source
        attr_reader :exp
        def initialize
          @exp = 5
        end
      end

      source = Source.new
      expect(source.xp).to eq(source.exp)
    end

    it 'defines gain_xp method for xp receivers' do
      require_relative '../lib/game/experience'
      class Receiver
        include Game::Experience::Receiver
        attr_accessor :exp, :lvl
        def initialize
          @exp = 0
          @lvl = 1
        end
      end

      receiver = Receiver.new
      expect{receiver.gain_xp(5)}.to change{receiver.exp}.from(0).to(5)
      expect{receiver.gain_xp(5)}.to change{receiver.lvl}.from(1).to(2)
      expect{receiver.gain_xp(10)}.to change{receiver.lvl}.from(2).to(3)
    end

    describe 'makes the monsters stronger' do
      it 'supervises the heroes levelup' do
        require_relative '../lib/game/experience'
        class Receiver
          include Game::Experience::Receiver
          attr_accessor :exp, :lvl
          def initialize
            @exp = 0
            @lvl = 1
          end
        end

        receiver = Receiver.new
        expect(receiver.gain_xp(5)).to be_falsy
        expect(receiver.gain_xp(5)).to be_truthy
      end

      it 'upgrades the moster' do
        monster = Monster.new
        expect(monster).to respond_to(:upgrade)

        expect{monster.upgrade}.to change{monster.lvl}.from(1).to(2)
      end
    end
  end
end
