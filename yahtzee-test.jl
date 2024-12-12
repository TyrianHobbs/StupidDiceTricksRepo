using Test
using.Yahtzee
import Base.==

#analyze_results does not work for me!


#test valid pools
rollPool() = rand(1:6, 5)
roll_invalidpool = [1,2,3]
roll_validpool = [1,2,3,4,5]
roll_invalidpool2 = [1,2,3,4,5,6,7,8]

@testset "Valid Pool test" begin
    @test validatePool(roll_validpool)
    @test_throws ArgumentError validatePool(roll_invalidpool)
    @test_throws ArgumentError validatePool(roll_invalidpool2)
end;


#test yahtzee hands 
roll_threeofkind = [1,1,1,2,3] #sum is 8
roll_fourofkind = [1,1,1,1,2] #sum is 6
roll_fullhouse = [2,2,4,4,4] 
roll_lowstraight = [3,4,4,5,6]
roll_highstraight = [1,2,3,4,5] 
roll_yahtzee = [3,3,3,3,3] 
roll_chance = [1,1,3,3,5] #sum is 25

@testset "Rght Hand Tests" begin
    @test scoreThreeOfAKind(roll_threeofkind)==8
    @test scoreFourOfAKind(roll_fourofkind)==6
    @test scoreFullHouse(roll_fullhouse)==25
    @test scoreLowStraight(roll_lowstraight)==30
    @test scoreHighStraight(roll_highstraight)==40
    @test scoreYahtzee(roll_yahtzee)==50
    @test scoreChance(roll_chance)==25
end;

@testset "Wrong Hand Tests" begin
    @test scoreThreeOfAKind(roll_fourofkind)==6
    @test scoreFourOfAKind(roll_threeofkind) == 0
    @test scoreFullHouse(roll_threeofkind)==0
    @test scoreLowStraight(roll_threeofkind)==0
    @test scoreHighStraight(roll_threeofkind)==0
    @test scoreYahtzee(roll_threeofkind)==0
    @test scoreChance(roll_threeofkind)==0
end;

@testset "Score Pool Test" begin
    @test scorePool(roll_threeofkind) == (8,"Three Of A Kind")
    @test scorePool(roll_fourofkind) == (6,"Three Of A Kind")
    @test scorePool(roll_fullhouse) == (16,"Full House")
    @test scorePool(roll_lowstraight) == (22,"Low Straight")
    @test scorePool(roll_highstraight) == (15,"High Straight")
    @test scorePool(roll_yahtzee) == (15,"Yahtzee")
    @test scorePool(roll_chance) == (25,"Chance")
end; 