require_relative './lib/game'
require_relative './lib/creature'
require_relative './lib/hero'
require_relative './lib/monster'
require_relative './lib/array'

monsters = Game.create_monsters
hero = Hero.new name: "Conan", con: 9001, str: 10
until hero.alive? do
    monster = monsters.rand
    Game.fight(hero, monster) 
end