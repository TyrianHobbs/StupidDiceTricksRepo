module Yahtzee
import Random.rand, StatsBase.mode, StatsBase.modes
export rollPool, validatePool, fillPool, scoreThreeOfAKind, scoreFourOfAKind, scoreFullHouse, scoreLowStraight, scoreHighStraight, scoreYahtzee, scoreChance, scorePool, rerollForStraight, rerollForYahtzee, rerollForFullHouse

"""
    rollPool()

Rolls a pool of Yahtzee dice; that is, generates five random integers between 1 and 6 inclusive. Returns a vector of the results.
"""
rollPool() = sort(rand(1:6, 5))

"""
    validatePool(pool::Vector{Int})
Checks that the given vector of integers is a valid Yahtzee pool: that is, 5 integers from 1 to 6 inclusive, sorted lowest to highest.
Throws an argument error otherwise.
"""
validatePool(pool::Vector{Int}) = length(pool) == 5 && maximum(pool) <= 6 && minimum(pool) >=1 && issorted(pool) || throw(ArgumentError("The given vector is not a valid Yahtzee pool (or is unsorted)."))

function fillPool(pool::Vector{Int})
    while length(pool) < 5
        push!(pool, rand(1:6))
    end
    return sort(pool)
end

"""
    scoreThreeOfAKind(pool::Vector{Int})

Calculates the score for a pool of five dice placed into the Three of a Kind box. If the pool contains a three of a kind, this is the sum of the dice; otherwise, it scores 0.
"""
function scoreThreeOfAKind(p::Vector{Int})
    validatePool(p)
    if p[1] == p[2] == p[3] || #first 3
    p[2] == p[3] == p[4] || #middle 3
    p[3] == p[4] == p[5] #last 3
        return sum(p)
    else
        return 0
    end
end

"""
    scoreFourOfAKind(pool::Vector{Int})

Calculates the score for a pool of five dice placed into the Four of a Kind box. If the pool contains a four of a kind, this is the sum of the dice; otherwise, it scores 0.
"""
function scoreFourOfAKind(p::Vector{Int})
    validatePool(p)
    if p[1] == p[2] == p[3] == p[4] || #lonely die at end
    p[2] == p[3] == p[4] == p[5] #lonely die at beginning
        return sum(p)
    else
        return 0
    end
end

"""
"""
function scoreFullHouse(p::Vector{Int})
    validatePool(p)
    if p[1] == p[2] != p[3] == p[4] == p[5] || #pair at beginning
        p[1] == p[2] == p[3] != p[4] == p[5] #pair at end
        return 25 
    else
        return 0
    end
end

"""
"""
function scoreLowStraight(p::Vector{Int})
    validatePool(p)
    if p[2] == p[1]+1 && p[3] == p[2]+1 && p[4] == p[3]+1 || #First 4 numbers are a run 
        p[3] == p[2]+1 && p[4] == p[3]+1 && p[5] == p[4]+1 #Last 5 numbers are a run
        return 30
    else
        return 0
    end
end

"""
"""
function scoreHighStraight(p::Vector{Int})
    validatePool(p)
    if p[2] == p[1]+1 && p[3] == p[2]+1 && p[4] == p[3]+1 && p[5] == p[4]+1
        return 40
    else
        return 0
    end
end

"""
"""
function scoreYahtzee(p::Vector{Int})
    validatePool(p)
    if p[1] == p[2] == p[3] == p[4] == p[5] 
        return 50
    else
        return 0
    end
end

"""
"""
function scoreChance(p::Vector{Int})
    validatePool(p)
    return sum(p)
end

function scorePool(pool::Vector{Int})
    local maxscore = 0
    local scoretype = ""
    t = scoreChance(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Chance"
    end
    local t = scoreThreeOfAKind(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Three Of A Kind"
    end
    t = scoreFourOfAKind(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Four Of A Kind"
    end
    t = scoreFullHouse(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Full House"
    end
    t = scoreLowStraight(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Low Straight"
    end
    t = scoreHighStraight(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "High Straight"
    end
    t = scoreYahtzee(pool)
    if t >= maxscore
        maxscore = t
        scoretype = "Yahtzee"
    end
    return maxscore, scoretype
end

function rerollForStraight(pool::Vector{Int})
    validatePool(pool)
    local p = pool #So things aren't occuring 'in place'. (May not actually work.)
    if p[1] == 1 && p[5] == 6
        popfirst!(p) #If both a 1 and 6 are present, get rid of the 1.
    end
    unique!(p)
    fillPool(p)
end

function rerollForYahtzee(pool::Vector{Int})
    validatePool(pool)
    local p = pool
    t = mode(reverse(p)) #If all the numbers are unique or if multiple modes exist, take the highest.
    p = filter(isequal(t), p)
    sort(fillPool(p))
end

function rerollForFullHouse(pool::Vector{Int})
    validatePool(pool)
    local p = pool
    t = modes(reverse(p)) #Keeps multiple modes!
    if length(t) == 1
        p = filter(isequal(t[1]), p)
        return sort(fillPool(p))
    elseif length(t) == 2
        p = filter(x -> x==t[1]||x==t[2], p)
        return sort(fillPool(p))
    else 
        q = Int[]
        push!(q, p[5])
        return sort(fillPool(q))
    end
end

end #Module Yahtzee