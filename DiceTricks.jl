module DiceTricks
    import Random
    export implode, rolltrials

    """
    implode(size::Int; target=1)

    Continue rolling a die until a target is hit. Adds together the sum of all the rolls, including the final target.
    """
    function implode(size::Int; target=1)
        size > 0 || throw(ArgumentError("That size of die is not possible."))
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
    function rolltrials(f::Function, trials::Integer; size=6)
        local results = Int[]
        for i = 1:trials
            push!(results, f(size))
        end
        return results
    end
end

#Test that Mackenzie was here & can edit!