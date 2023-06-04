class NotEnoughWaterLeftError < Exception
    def message
        "Es gibt nicht genügend Wasser!"
    end
end

class NotOnlineError < Exception
    def message
        "Die Kaffeemaschine ist nicht eingeschaltet!"
    end
end

class DrinkNotAvailable < Exception
    def message
        "Das gewünschte Getränk ist zurzeit leider nicht verfügbar!"
    end
end