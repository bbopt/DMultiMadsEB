println("Testing printing of BBProblemMeta")
print(BBProblem(x->2, 1, 1, [OBJ],name="Inconstrained Example").meta)
print(BBProblem(x -> [2, -10], 3, 2, [OBJ; CSTR], lvar=[-3.0; 2.0; 1.0], name="Constrained Example").meta)

@testset "Wrong number of arguments" begin 
    @test_throws(ErrorException, BBProblemMeta(0, 2, [OBJ; OBJ]))
    @test_throws(ErrorException, BBProblemMeta(1, 0, [OBJ; OBJ]))
end

@testset "Bound variables errors" begin
    @test_throws(ErrorException, BBProblemMeta(2, 1, [OBJ], lvar=[1.0; 1.0], uvar=[-Inf; 2.0]))
    @test_throws(ErrorException, BBProblemMeta(2, 1, [OBJ], lvar=[1.0; 0.0], uvar=[Inf; 0.0]))
end

@testset "Starting point errors" begin
    @test_throws(ErrorException, eval_x(BBProblem(x -> 2 * x[1] - x[2], 2, 1, [OBJ]), [2.0; 3.0; 4.0]))
    @test_throws(ErrorException, eval_x(BBProblem(x -> 2 * x[1] + x[2]^2, 3, 1, [OBJ], 
                                                  lvar=[1.0; -0.5; 5]), [-1.0; 4.0; 5.0]))
    @test_throws(ErrorException, eval_x(BBProblem(x -> sqrt(x[1]) - 3 * x[2], 3, 1, [OBJ], 
                                                  uvar=[1.0; -0.5; 5]), [-1.0; 4.0; 2.0]))
end

@testset "Simple bbproblem test" begin
    dumbBB = BBProblem(x -> [2 * x[1] - 3 * x[2] + 3; x[3]^2], 3, 2, [OBJ, CSTR], name="testProb") 
    @test dumbBB.meta.name == "testProb"
    @test dumbBB.meta.lvar == [-Inf; -Inf; -Inf]
    @test dumbBB.meta.uvar == [Inf; Inf; Inf]

    result = eval_x(dumbBB, [1.0; 3.0; -2.0])
    @test result[1] ≈ -4.0
    @test result[2] ≈ 4.0
end

