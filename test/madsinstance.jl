@testset "Mads algorithm : Rosenbrock function" begin

    Rosenbrock = BBProblem(x -> [(x[1] - 1)^2 + 100 * (x[2] - x[1]^2)^2],
                          2, 1, [OBJ], lvar=[-5.0; -5.0], uvar=[5.0; 5.0],
                          name="Rosenbrock")

    @test Rosenbrock.meta.name == "Rosenbrock"
    @test Rosenbrock.meta.typeoutputs == [OBJ]
    @test Rosenbrock.meta.ninputs == 2
    @test Rosenbrock.meta.noutputs == 1
    @test Rosenbrock.meta.lvar ≈ [-5.0; -5.0]
    @test Rosenbrock.meta.uvar ≈ [5.0; 5.0]
    @test eval_x(Rosenbrock, [1.0; 1.0]) ≈ [0]

    madsI = MadsInstance(Rosenbrock; neval_bb_max=1000)
    stop = solve!(madsI, [[-1.0; -4.0]])
    @test stop == MIN_MESH_REACHED
    @test length(madsI.cache.data) == 640
    @test length(madsI.barrier.bestFeasiblePoints) == 1

    println(madsI.barrier.bestFeasiblePoints)
    #println(madsI.cache.data[312])
    #print(madsI.cache.data[884])
    #println(madsI.cache.data[18])
    #saveCache(madsI.cache, "history.txt")
end

@testset "Mads algorithm : a simple example 2 objectives" begin

    SP1 = BBProblem(x -> [(x[1] - 1)^2 + (x[1] - x[2])^2;
                          (x[1] - x[2])^2 + (x[2] - 3)^2],
                    2, 2, [OBJ; OBJ], lvar=[-1.0; -1.0], uvar=[5.0; 5.0],
                    name="SP1")

    @test SP1.meta.name == "SP1"
    @test SP1.meta.typeoutputs == [OBJ; OBJ]
    @test SP1.meta.ninputs == 2
    @test SP1.meta.noutputs == 2
    @test SP1.meta.lvar ≈ [-1.0; -1.0]
    @test SP1.meta.uvar ≈ [5.0; 5.0]
    @test eval_x(SP1, [1.5; 1.5]) ≈ [0.25; 2.25]

    madsI = MadsInstance(SP1; neval_bb_max=100)
    stop = solve!(madsI, [[1.5; 1.5]])
    @test stop == MAX_BB_REACHED
    @test length(madsI.cache.data) == 100
    @test length(madsI.barrier.bestFeasiblePoints) == 15
end

@testset "Mads algorithm : a simple example 3 objectives" begin

    Viennet = BBProblem(x -> [0.5 * (x[1]^2 + x[2]^2) + sin(x[1]^2 + x[2]^2);
                          (3 * x[1] - 2 * x[2] + 4)^2 / 8 + (x[1] - x[2] + 1)^2 / 27 + 15;
                          1 / (x[1]^2 + x[2]^2 + 1) - 1.1 * exp(-(x[1]^2 + x[2]^2))],
                    2, 3, [OBJ; OBJ; OBJ], lvar=[-3.0; -3.0], uvar=[3.0; 3.0],
                    name="Viennet")

    @test Viennet.meta.name == "Viennet"
    @test Viennet.meta.typeoutputs == [OBJ; OBJ; OBJ]
    @test Viennet.meta.ninputs == 2
    @test Viennet.meta.noutputs == 3
    @test Viennet.meta.lvar ≈ [-3.0; -3.0]
    @test Viennet.meta.uvar ≈ [3.0; 3.0]
    @test eval_x(Viennet, [1.0; 1.0]) ≈ [1 + sin(2); 25 / 8 + 1 / 27 + 15; 1/3 - 1.1  * exp(-2)]

    madsI = MadsInstance(Viennet; neval_bb_max=100)
    stop = solve!(madsI, [[1.5; 1.5]])
    @test stop == MAX_BB_REACHED
    @test length(madsI.cache.data) == 100
    @test length(madsI.barrier.bestFeasiblePoints) == 7

end
