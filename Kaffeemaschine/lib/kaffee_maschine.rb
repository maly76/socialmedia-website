require_relative './exceptions.rb'

class KaffeeMaschine
    CupSize = 1
    @wasserfuellstand
    @eingeschaltet

    def initialize()
        @wasserfuellstand = 3
        @eingeschaltet = false
    end

    def einschalten()
        @eingeschaltet = true
        puts("Kaffeemaschine ist eingeschaltet!")
    end

    def koche_kaffee(n, drink:) # options
        raise NotOnlineError if !@eingeschaltet
        i = 0
        until i > n-1 do
            case drink          # options[:drink]
                when :kaffee
                    print("☕ ")
                when :tee
                    print("🍵 ")
                when :himbeer
                    print("🍺 ")
                else
                    raise DrinkNotAvailable
            end
            i += 1;
            raise NotEnoughWaterLeftError if @wasserfuellstand < CupSize
            @wasserfuellstand -= CupSize
        end
    end
end