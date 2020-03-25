println("testing printing of EvalPoint")
print(EvalPoint([0.5; 10], [1.4], Gmesh(2, [5.0; 6.0]) ))

@testset "Initialization of eval point parameters" begin
    m2d = Gmesh(2, [0.75; 2.5])
    @test_throws(ErrorException, EvalPoint([], [4.0; -38.0], m2d))
    @test_throws(ErrorException, EvalPoint([-2.0; 1.5], [], m2d))
    @test_throws(ErrorException, EvalPoint([1.5; 2.0; 4.0], [1.0], m2d))

    x = EvalPoint([1.5; -7.4], [2.4; -1.4; Inf], m2d)
    @test x.inputs == [1.5; -7.4]
    @test x.outputs == [2.4; -1.4; Inf]
end

@testset "Mesh updating" begin
    m2d = Gmesh(2, [3.5; 17.5])
    @test m2d.initPollSizeExp == m2d.pollSizeExp == [0; 1]
    @test m2d.pollSizeMant == [5; 2]

    x = EvalPoint([2.0; -6.0], [-67], m2d)
    refineFrameSize!(x.mesh)
    @test x.mesh.initPollSizeExp == [0; 1]
    @test x.mesh.pollSizeExp == [0; 1]
    @test x.mesh.pollSizeMant == [2; 1]

    # test deep copy
    @test m2d.initPollSizeExp == [0; 1]
    @test m2d.pollSizeExp == [0; 1]
    @test m2d.pollSizeMant == [5; 2]


end

@testset "Cache testing" begin
    @test_throws(ErrorException, Cache((-1, 2)))
    @test_throws(ErrorException, Cache((1, 0)))
    cache = Cache((3, 1))
    @test length(cache.data) == 0

    m3d = Gmesh(3, [3.5; 4; 15.1])
    x1 = EvalPoint([2.4; -5.3; 2.1], [10], m3d)

    isInserted = insertInCache!(cache, x1)
    @test isInserted == true
    @test length(cache.data) == 1

    xcandidate = [1.0; 2.0; -2.0; 6.0]
    @test isInCache(cache, xcandidate) == false

    xcandidate = [1.0; 2.0; 3.0]
    @test isInCache(cache, xcandidate) == false

    xcandidate = [2.4; -5.3; 2.1]
    @test isInCache(cache, xcandidate) == true

    @test insertInCache!(cache, x1) == false
    @test length(cache.data) == 1

    x2 = EvalPoint([-22; 32; 15.5], [10; 5], m3d)
    @test insertInCache!(cache, x2) == false

    x3 = EvalPoint([-22; 32; 15.5], [-23], m3d)
    @test insertInCache!(cache, x3) == true
    @test length(cache.data) == 2

    # robustness when inserting two times the same eval point
    @test insertInCache!(cache, x3) == false
    @test length(cache.data) == 2

    x4 = EvalPoint([-22; 32; 15.5], [-23], m3d)
    @test insertInCache!(cache, x4) == false
    @test length(cache.data) == 2

    # special case
    x5 = EvalPoint([-5.0; 4.0], [1.5], Gmesh(2, [1.3; 4.1]))
    @test insertInCache!(cache, x5) == false
    @test length(cache.data) == 2

    # writing in file
    saveCache(cache, "simple-cache-example.txt")
    counter = 0
    open("simple-cache-example.txt", "r") do io
        for ln in eachline(io)
            counter += 1
        end
    end
    @test counter == 3
    rm("simple-cache-example.txt")

end

