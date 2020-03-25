@testset "Initialization of barrier" begin
    @test_throws(ErrorException, Barrier(0))
    @test_throws(ErrorException, Barrier(-3))

    b = Barrier(2)
    @test b.nb_obj == 2
    @test isempty(b.bestFeasiblePoints) == true

end

@testset "Insertion for two objectives" begin
    b2obj = Barrier(2)

    @test_throws(ErrorException, addFeasible!(b2obj,(1,1, false) , OVector([1.0; -4.0; 6.0], 0)))

    insert = addFeasible!(b2obj, (1, 1, false), OVector([2.0; 3.0], 0))
    @test insert == true
    @test length(b2obj.bestFeasiblePoints) == 1
    @test getkey(b2obj.bestFeasiblePoints, (1,1,true), 0) == 0
    @test b2obj.bestFeasiblePoints[(1,1,false)].f ≈ [2.0; 3.0]
    
    @test_throws(ErrorException, addFeasible!(b2obj, (1, 1, false), OVector([1.0; 0.0], 0)))

    # first tentative
    @test isDominated(b2obj, OVector([3.0; 3.0], 0)) == true
    @test dominates(b2obj, OVector([3.0; 3.0], 0)) == false
    @test extends(b2obj, OVector([3.0; 3.0], 0)) == false
    insert = addFeasible!(b2obj, (2, 1, false), OVector([3.0; 3.0], 0))
    @test insert == false
    @test length(b2obj.bestFeasiblePoints) == 1

    # second tentative
    @test isDominated(b2obj, OVector([3.0; 2.0], 0)) == false
    @test dominates(b2obj, OVector([3.0; 2.0], 0)) == false
    @test extends(b2obj, OVector([3.0; 2.0], 0)) == true
    insert = addFeasible!(b2obj, (2, 1, false), OVector([3.0; 2.0], 0))
    @test insert == true
    @test length(b2obj.bestFeasiblePoints) == 2

    # third point
    @test isDominated(b2obj, OVector([5.0; 1.0], 0)) == false
    @test dominates(b2obj, OVector([5.0; 1.0], 0)) == false
    @test extends(b2obj, OVector([5.0; 1.0], 0)) == true
    insert = addFeasible!(b2obj, (3, 1, false), OVector([5.0; 1.0], 0))
    @test insert == true
    @test length(b2obj.bestFeasiblePoints) == 3

    # last point
    @test isDominated(b2obj, OVector([-1.0; 0.0], 0)) == false
    @test dominates(b2obj, OVector([-1.0; 0.0], 0)) == true
    @test extends(b2obj, OVector([-1.0; 0.0], 0)) == true
    insert = addFeasible!(b2obj, (4, 1, false), OVector([-1.0; 0.0], 0))
    @test insert == true
    @test length(b2obj.bestFeasiblePoints) == 1
    @test b2obj.bestFeasiblePoints[(4, 1, false)].f ≈ [-1.0; 0.0]

end

@testset "Insertion for three objectives" begin
    b3obj = Barrier(3)

    @test_throws(ErrorException, addFeasible!(b3obj,(1, 1, false), OVector([1.0; -4.0], 0)))

    insert = addFeasible!(b3obj, (1, 1, false), OVector([2.0; 3.0 ; 1.0], 0))
    @test insert == true
    @test length(b3obj.bestFeasiblePoints) == 1
    @test getkey(b3obj.bestFeasiblePoints, (2, 1, false), 0) == 0
    @test b3obj.bestFeasiblePoints[(1, 1, false)].f ≈ [2.0; 3.0 ; 1.0]

    @test_throws(ErrorException, addFeasible!(b3obj, (1, 1, false), OVector([1.0; 0.0 ; 0.0], 0)))

    # first tentative
    @test isDominated(b3obj, OVector([4.0; 3.0; 1.0], 0)) == true
    @test dominates(b3obj, OVector([4.0; 3.0; 1.0], 0)) == false
    @test extends(b3obj, OVector([4.0; 3.0; 1.0], 0)) == false
    insert = addFeasible!(b3obj, (2, 1, false), OVector([4.0; 3.0; 1.0], 0))
    @test insert == false
    @test length(b3obj.bestFeasiblePoints) == 1

    # second tentative
    @test isDominated(b3obj, OVector([3.0; 2.0; 1.0], 0)) == false
    @test dominates(b3obj, OVector([3.0; 2.0; 1.0], 0)) == false
    @test extends(b3obj, OVector([3.0; 2.0; 1.0], 0)) == true
    insert = addFeasible!(b3obj, (2, 1, false), OVector([3.0; 2.0; 1.0], 0))
    @test insert == true
    @test length(b3obj.bestFeasiblePoints) == 2

    # third point
    @test isDominated(b3obj, OVector([5.0; 1.0 ; 0.0], 0)) == false
    @test dominates(b3obj, OVector([5.0; 1.0; 0.0], 0)) == false
    @test extends(b3obj, OVector([5.0; 1.0 ; 0.0], 0)) == true
    insert = addFeasible!(b3obj, (3, 1, false), OVector([5.0; 1.0 ; 0.0], 0))
    @test insert == true
    @test length(b3obj.bestFeasiblePoints) == 3

    # last point
    @test isDominated(b3obj, OVector([-10; 0.0; -4.0], 0)) == false
    @test dominates(b3obj, OVector([-10; 0.0; -4.0], 0)) == true
    @test extends(b3obj, OVector([-10; 0.0; -4.0], 0)) == true
    insert = addFeasible!(b3obj, (4, 1, false), OVector([-10; 0.0; -4.0], 0))
    @test insert == true
    @test length(b3obj.bestFeasiblePoints) == 1
    @test b3obj.bestFeasiblePoints[(4,1,false)].f ≈ [-10; 0.0; -4.0]

end

@testset "Saving barrier values" begin
    b3obj = Barrier(3)

    @test addFeasible!(b3obj, (1, 1, false), OVector([2.0; 3.0; 1.0], 0)) == true
    @test addFeasible!(b3obj, (2, 1, false), OVector([3.0; 2.0; 1.0], 0)) == true
    @test addFeasible!(b3obj, (4, 1, false), OVector([5.0; 1.0; 0.0], 0)) == true

    saveparetofront(b3obj ,"simple-barrier-test.txt")
    counter = 0
    open("simple-barrier-test.txt", "r") do io
        for ln in eachline(io)
            counter += 1
        end
    end
    @test counter == 3
    rm("simple-barrier-test.txt")

end
