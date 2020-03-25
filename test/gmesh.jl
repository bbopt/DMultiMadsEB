println("testing printing of GMesh")
print(Gmesh(2, [0.5; 6.0]))
print(Gmesh(3, [7; 1.8; 4.5]))

@testset "Initialization of mesh parameters" begin
    @test_throws(ErrorException, Gmesh(-1, [2.0; 3.0]))
    @test_throws(MethodError, Gmesh(0, []))
    @test_throws(ErrorException, Gmesh(2, [0.0; 1.0]))
    @test_throws(ErrorException, Gmesh(3, [1.0; 20.0; -1.0]))
    @test_throws(ErrorException, Gmesh(5, [1.0; 2.0; 4.0; 5.0; 10.0; 4.0]))

    m3d = Gmesh(3, [2.0 ; 0.5; 90.0])
    @test m3d.initPollSizeExp == m3d.pollSizeExp == [0; 0; 1]
    @test m3d.pollSizeMant == [2; 1; 5]

    m4d = Gmesh(4, [5.0; 1500.0; 0.02; 25.0])
    @test m4d.initPollSizeExp == m4d.initPollSizeExp == [0; 3; -1; 1]
    @test m4d.pollSizeMant == [5; 2; 1; 2]
end

@testset "Frame and poll size parameters" begin
    m1d = Gmesh(1, [4.5])
    @test m1d.initPollSizeExp == [0]
    @test m1d.pollSizeMant == [5]
    @test getFrameSizeParameter(m1d) == [5.0]
    @test getMeshSizeParameter(m1d) == [1.0]

    m3d = Gmesh(3, [16.0; 0.004; 450.0])
    @test m3d.initPollSizeExp == m3d.pollSizeExp == [1; -2; 2]
    @test m3d.pollSizeMant == [2; 1; 5]
    @test getMeshSizeParameter(m3d) == [10.0; 0.01; 100.0]
    @test getFrameSizeParameter(m3d) == [20.0; 0.01; 500.0]

end

@testset "Updating meshes" begin
    m2d = Gmesh(2, [3.5; 17.5])
    @test m2d.initPollSizeExp == m2d.pollSizeExp == [0; 1]
    @test m2d.pollSizeMant == [5; 2]

    refineFrameSize!(m2d)
    @test m2d.initPollSizeExp == [0; 1]
    @test m2d.pollSizeExp == [0; 1]
    @test m2d.pollSizeMant == [2; 1]

    dir = [1.0; 2.0; 5.0]
    @test_throws(ErrorException, enlargeFrameSize!(m2d, dir))

    dir = [1.0; 4.0]
    enlargeFrameSize!(m2d, dir)
    @test m2d.initPollSizeExp == [0;1]
    @test m2d.pollSizeExp == [0;1]
    @test m2d.pollSizeMant == [5;2]

    enlargeFrameSize!(m2d, dir)
    @test m2d.initPollSizeExp == [0;1]
    @test m2d.pollSizeExp == [1;1]
    @test m2d.pollSizeMant == [1;5]

    mlim = Gmesh(4, 10^(-7) * ones(4,), minMeshSize= 10^(-6))
    @test mlim.minMeshSize == 10^(-6)
    @test mlim.initPollSizeExp == mlim.pollSizeExp == [-7; -7; -7; -7]
    @test mlim.pollSizeMant == [1, 1, 1, 1]

    # note that as we are below the tolerance for the mesh, we return the min mesh size
    @test getMeshSizeParameter(mlim) == [10^(-6), 10^(-6), 10^(-6), 10^(-6)]

    refineFrameSize!(mlim)
    @test mlim.initPollSizeExp == mlim.pollSizeExp == [-7; -7; -7; -7]
    @test mlim.pollSizeMant == [1, 1, 1, 1]

end

@testset "Projections on the mesh" begin
    m2d = Gmesh(2, [1.0; 1.0])

    @test_throws(ErrorException, projectOnMesh(m2d, [1.5; 3.4; 6.0], [2.4; 3.0]))
    @test_throws(ErrorException, projectOnMesh(m2d, [1.5; 2.0], [-4.5]))

    proj = projectOnMesh(m2d, [1.5; -13.4], [-1.0; 2.4])
    @test proj ≈ [1.0; -13.6]

end

@testset "Directions generation" begin
    m2d = Gmesh(2, [1.0; 1.0])
    @test m2d.initPollSizeExp == m2d.pollSizeExp == [0;0]
    @test m2d.pollSizeMant == [1;1]

    rng = MersenneTwister(1234)
    pBase1 = generateDirections(m2d, rng)
    @test pBase1[:,1:2] == -pBase1[:,3:4]

    pBase2 = generateDirections(m2d, rng)
    @test pBase2[:,1:2] == -pBase2[:,3:4]
    @test pBase1 != pBase2 

    refineFrameSize!(m2d)
    rng = MersenneTwister(1234)
    pBase3 = generateDirections(m2d, rng) 
    @test pBase3[:,1:2] == -pBase3[:,3:4]
    @test norm(pBase3[:,1], Inf) == norm(getFrameSizeParameter(m2d), Inf) 
end


