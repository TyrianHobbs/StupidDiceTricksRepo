module Yahtzee
    import Random
    export rollPool

    """
        rollPool()

    Rolls a pool of Yahtzee dice; that is, generates five random integers between 1 and 6 inclusive. Returns a vector of the results.
    """
    rollPool() = rand(1:6, 5)
    
    """
        scoreThreeOfAKind(pool::Vec{Int})

    Calculates the score for a pool of five dice placed into the Three of a Kind box. If the pool is a three of a kind, this is the sum of the dice; otherwise, it scores 0.
    """
    function scoreThreeOfAKind(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
        p = sort(pool)
        if(p[1] == p[2] == p[3] != p[4] != p[5] || #first 3
        p[1] != p[2] == p[3] == p[4] != p[5] || #middle 3
        p[1] != p[2] != p[3] == p[4] == p[5]) #last 3
            return sum(pool)
        else
            return 0
        end
    end

    """
        scoreFourOfAKind(pool::Vec{Int})

    Calculates the score for a pool of five dice placed into the Four of a Kind box. If the pool is a four of a kind, this is the sum of the dice; otherwise, it scores 0.
    """
    function scoreFourOfAKind(pool::{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
        p = sort(pool)
        if(p[1] == p[2] == p[3] == p[4] != p[5] || #lonely die at end
        p[1] != p[2] == p[3] == p[4] == p[5]) #lonely die at beginning
            return sum(pool)
        else
            return 0
        end
    end

    """
    """
    function scoreFullHouse(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
    end

    """
    """
    function scoreLowStraight(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
    end

    """
    """
    function scoreHighStraight(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
    end

    """
    """
    function scoreYahtzee(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
    end

    """
    """
    function scoreChance(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
    end

end #Module Yahtzee