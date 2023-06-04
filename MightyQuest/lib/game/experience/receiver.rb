module Game
    module Experience
        module Receiver
            def gain_xp(xp)
                @xp += xp
                if (@xp = @xp * 10)
                    levelup
                end
            end
        
            def levelup
                @lvl += 1
            end
        end
    end
end