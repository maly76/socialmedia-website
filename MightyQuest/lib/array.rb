class Array
    def rand
        r = Random.new
        self[r.rand(0...size)].clone
    end
end