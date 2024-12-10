module DiceTricks
    import Random, Statistics
    export implode, rolltrials, roll_die, play_shoot_your_shot, simulate_shoot_your_shot, analyze_results

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



    #Shoot Your Shot Game

    """
        roll_die(sides=6)
    Roll a dice; returns an integer between 1 and the number of sides, inclusive. Defaults to a six-sided die.
    """
    function roll_die(sides=6)
        return rand(1:sides)
    end

    function play_shoot_your_shot()
        dice_chain = [4, 6, 8, 10, 12, 20]
        total_score = 0
        
        println("Starting 'Shoot Your Shot'")
        for sides in dice_chain
            println("\nRolling a d$sides for the target...")
            target = roll_die(sides)
            println("Target roll is: $target")
            
            die_score = 0
            achieved_target = false
            
            while !achieved_target
                roll = roll_die(sides)
                die_score += roll
                println("Rolled a $roll")
                if roll == target
                    println("Target achieved!")
                    achieved_target = true
                end
            end
            
            total_score += die_score
            println("Score for d$sides: $die_score")
        end
        
        println("\nGame over! Total score: $total_score")
        return total_score
    end

    function simulate_shoot_your_shot(num_simulations::Int)
        scores = []
        
        for _ in 1:num_simulations
            score = play_shoot_your_shot()
            push!(scores, score)
        end
        
        return scores
    end

    function analyze_results(scores::Vector{Int})
        println("\nResults Summary:")
        println("Number of games: $(length(scores))")
        println("Average score: $(mean(scores))")
        println("Minimum score: $(minimum(scores))")
        println("Maximum score: $(maximum(scores))")
        println("Variance: $(var(scores))")
        println("Standard Deviation: $(std(scores))")
    end

    #Exploding Dice Game
    """
    explode(mad::Int)
    Enter max sides on single die. Roll until result is not max, add all rolls together.
    """
    function explode(max::Int)
        local sum=0
        if max<0
            throw(ArgumentError("This number on a n-sided die has to be greater than 0"))
        end
        check = max
        roll = rand(1:max)
        while roll == check
            sum += roll 
            roll = rand(1:max)
        end
        sum += roll
        return sum
    end

    """
    mutiple_explodetrials(f::Function, trials::Int, max::Int)
    Run trials on explode dice function. Returns vector of all scores.
    """
    function multiple_explodetrials(f::Function, trials::Int, max::Int)
        local results = Int[]
        for i in 1:trials 
            push!(results, f(max))
        end
        return results
    end 

end #module DiceTricks