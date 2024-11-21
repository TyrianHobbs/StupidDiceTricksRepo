import Random

"""
implode(size::Int; target=1)

Continue rolling a die until a target is hit. Adds together the sum of all the rolls, including the final target.
"""
function implode(size::Int; target=1)
    target > 0 && target <= size || throw(ArgumentError("The given target is not possible on that size die."))
    local sum = 0
    local check = -1
    while check != target
        check = rand(1:size)
        sum += check
    end
    return sum
end

##Still figuring out how to make this more general
"""
Run trials on a certain dice function, and return a vector of all the results.
"""
function rolltrials(f::Function, size::Integer, trials::Integer)
local results = Int[]
    for i = 1:trials
        push!(results, f(size))
    end
    return results
end

#Test that Mackenzie was here & can edit!