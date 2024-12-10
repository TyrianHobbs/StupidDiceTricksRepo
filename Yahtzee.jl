module Yahtzee
    import Random
    export rollPool

    """
        rollPool()

    Rolls a pool of Yahtzee dice; that is, generates five random integers between 1 and 6 inclusive. Returns a vector of the results.
    """
    rollPool() = rand(1:6, 5)
    
    """
        val
    """
    validatePool(pool::Vec{Int}) = length(pool) == 5&& maximum(pool) <= 6 && minimum(pool) >=1 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))

    """
        scoreThreeOfAKind(pool::Vec{Int})

    Calculates the score for a pool of five dice placed into the Three of a Kind box. If the pool contains a three of a kind, this is the sum of the dice; otherwise, it scores 0.
    """
    function scoreThreeOfAKind(pool::Vec{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
        p = sort(pool)
        if(p[1] == p[2] == p[3] || #first 3
        p[2] == p[3] == p[4] || #middle 3
        p[3] == p[4] == p[5]) #last 3
            return sum(pool)
        else
            return 0
        end
    end

    """
        scoreFourOfAKind(pool::Vec{Int})

    Calculates the score for a pool of five dice placed into the Four of a Kind box. If the pool contains a four of a kind, this is the sum of the dice; otherwise, it scores 0.
    """
    function scoreFourOfAKind(pool::{Int})
        length(pool) == 5 || throw(ArgumentError("The given vector is not a valid Yahtzee pool."))
        p = sort(pool)
        if(p[1] == p[2] == p[3] == p[4] || #lonely die at end
        p[2] == p[3] == p[4] == p[5]) #lonely die at beginning
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

    function scorePool(pool::Vec{Int})
        local maxscore = 0
        local scoretype = ""
        t = scoreChance(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Chance"
        end
        local t = scoreThreeOfAKind(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Three Of A Kind"
        end
        t = scoreFourOfAKind(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Four Of A Kind"
        end
        t = scoreFullHouse(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Full House"
        end
        t = scoreLowStraight(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Low Straight"
        end
        t = scoreHighStraight(pool)
        if t > maxscore
            maxscore = t
            scoretype = "High Straight"
        end
        t = scoreYahtzee(pool)
        if t > maxscore
            maxscore = t
            scoretype = "Yahtzee"
        end
        return maxscore, scoretype
    end
end #Module Yahtzee