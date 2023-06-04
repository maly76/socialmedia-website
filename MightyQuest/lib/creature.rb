class Creature
    @name
    @str
    @con
    @dex
    @int
    @lvl
    @exp
    @hp

    attr_reader :name
    attr_reader :lvl
    attr_reader :exp

    attr_reader :hp
    attr_writer :hp

    def hp
        @hp
    end

    def hp=(hp)
        @hp = hp
    end

    def name
        @name
    end

    def lvl
        @lvl
    end

    def exp
        @exp
    end

    def initialize options = {}
        @name = "Anonymous Creature"
        @str = 1
        @con = 1
        @dex = 1
        @int = 1
        @lvl = 1
        @exp = 0
        @hp = 2 * @con + 1 * @str
        options.each do |key, value|
            case key
                when :name
                    @name = value
                when :str
                    @str = value
                when :con
                    @con = value
                when :dex
                    @dex = value
                when :int
                    @int = value
                when :lvl
                    @lvl = value
                when :exp
                    @exp = value
                when :hp
                    @hp = value
            end
        end
    end

    def alive?
        @hp > 0
    end

    def wound(damage)
        @hp -= damage
    end

    def attack(enemy)
        raise ArgumentError.new "wrong type of enemy" unless enemy.is_a? Creature
        raise ArgumentError.new "self attack not allowed" if enemy == self
        
        damage = @str + @str * rand(3)
        enemy.hp -= damage
        return damage
    end

    def to_s
        "#{@name} Level #{@lvl}\nHP = #{@hp}\nEXP = #{@exp}\nSTR = #{@str}\nCON = #{@con}\nDEX = #{@dex}\nINT = #{@int}"
    end
end