require_relative './creature'
require_relative './game/experience'

module Game
    include Experience

    def self.fight(hero, monster)
        while hero.alive? && monster.alive?
            attack_enemy(hero, monster)
            attack_enemy(monster, hero)
        end
        if hero.alive?
            Game::Experience::Receiver.gainxp 2
        end
    end

    private def attack_enemy(player, enemy)
        damage = player.attack(enemy)
        puts("#{enemy.name} hat den Schaden #{damage} erlitten")
        unless enemy.alive?
            puts("#{player.name} has won!")
            break
        end
    end

    def self.create_monster
        names = ["Tornado", "Bionic", "Monsoon", "Rubble", "Barracuda", "Wondrous", "Sapphire", "Black Mamba", "Tanzanite", "Bumblebee"]
        r = Random.new
        index = r.rand(0...9)
        str = r.rand(1...50)
        con = r.rand(1...50)
        dex = r.rand(1...50)
        int = r.rand(1...50)
        exp = r.rand(0...50)
        hp = r.rand(1...50)
        Monster.new name: names[index], str: str, con: con, dex: dex, int: int, exp: exp, hp: hp
    end

    def self.create_monsters
        monsters = []
        i = 0
        until i > 9 do
            monsters.push create_monster
            i += 1
        end
        monsters
    end
end