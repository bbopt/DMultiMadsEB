println("Testing printing of OVector")
print(OVector([2.0; 3.0], 23.1))

@testset "Initialization of ovector parameters" begin
    @test_throws(ErrorException, OVector([], 2.3))
    @test_throws(ErrorException, OVector([1.2], -0.6))
    
    v = OVector([1.5; Inf], Inf)
    @test v.f == [1.5 ; Inf]
    @test v.h == Inf
end

@testset "feasibility detection" begin
    @test isFeasible(OVector([12.1], 22.8)) == false
    @test isFeasible(OVector([-2.5; 3.4], 0)) == true
end

@testset "strict dominance relation" begin
    @test (OVector([12.1], 0) < OVector([12.4; 2], 1.5)) == false
    @test (OVector([-45.3; 10.5], 0) < OVector([-46.4; 11.7], 2.5)) == false
    @test (OVector([-46.4; 11.7], 2.5) < OVector([-48.3; 12.5], 0) ) == false

    @test (OVector([Inf], Inf) < OVector([Inf], Inf)) == false
    
    v1f = OVector([12.1; -10.5; 1.2], 0)
    v2f = OVector([12.1; -4.5; 1.28], 0)
    @test (v1f < v2f) == false

    v1f.f[1] = 11.6;
    @test (v1f < v2f) == true
    
    v1f.f[1] = Inf
    @test (v1f < v2f) == false
    
    v1i = OVector([2.5; 4.1], 2.6)
    v2i = OVector([Inf; 4.1], 2.7)
    @test (v1i < v2i) == false
    
    v2i.f[2] = 4.6;
    @test (v1i < v2i) == true
    
    v2i = OVector([Inf; 4.1], 2.4)
    @test (v1i < v2i) == false

end


@testset "weak dominance relation" begin
    @test (OVector([12.1], 0) ≦ OVector([12.1; 2], 1.5)) == false
    @test (OVector([-45.3; 10.5], 0) ≦ OVector([-46.4; 11.5], 2.5)) == false
    @test (OVector([-48.3; 12.5], 2.5) ≦ OVector([-48.3; 12.5], 0) ) == false

    @test (OVector([Inf], Inf) ≦ OVector([Inf], Inf)) == true

    v1f = OVector([12.1; -10.5; 1.2], 0)
    v2f = OVector([12.1; -11.5; 1.28], 0)
    @test (v1f ≦ v2f) == false

    v1f.f[2] = -11.5;
    @test (v1f ≦ v2f) == true

    v1f.f[1] = Inf
    @test (v1f ≦ v2f) == false
    
    v1i = OVector([2.5; 4.1], 2.6)
    v2i = OVector([Inf; 4.1], 2.7)
    @test (v1i ≦ v2i) == true
    
    v1i.f[1] = Inf;
    @test (v1i ≦ v2i) == true
    
    v2i = OVector([Inf; 4.1], 2.6)
    @test (v1i ≦ v2i) == true

    @test (OVector([2.1; 4.5; 67.1; -12.3], 0) ≦ OVector([2.1; 4.5; 67.1; -12.3], 0)) == true

end

@testset "Dominance relation" begin
    @test (OVector([12.1], 0) <= OVector([12.1; 2], 1.5)) == false
    @test (OVector([-45.3; 10.5], 0) <= OVector([-46.4; 11.5], 2.5)) == false
    @test (OVector([-48.3; 12.5], 2.5) <= OVector([-48.3; 12.5], 0) ) == false

    @test (OVector([Inf], Inf) <= OVector([Inf], Inf)) == false
    
    v1f = OVector([1.3; -4.5; 2.6], 0)
    v2f = OVector([2.1; 4.6; 3.7], 0)
    @test (v1f <= v2f) == true
    
    v1f.f[2] = 4.8
    @test (v1f <= v2f) == false
    
    v1f.f[1] = 2.1;
    v1f.f[2] = 4.6
    @test (v1f <= v2f) == true
   
    v1i = OVector([1.67; -4.0], 2.8)
    v2i = OVector([1.67; 2.8], 2.8)
    @test (v1i <= v2i) == true
    
    v2i.f[2] = -4.0
    @test (v1i <= v2i) == false
    
    v2i.f[2] = -5.0
    @test (v1i <= v2i) == false
    
    v2i = OVector([1.67; -4.0], 2.7)
    @test (v1i <= v2i) == false
    @test (v2i <= v1i) == true

end

@testset "Incomparabily and equality relation" begin
    v1f = OVector([1.0; -5.0; 2.0], 0)
    v2f = OVector([2.0; -6.0; 2.5], 0)
    @test (!(v1f <= v2f) && !(v2f <= v1f)) == true

    v2f.f[1:3] = [1.0; -5.0; 2.0]
    @test isEqual(v1f, v2f) == true

    v1i = OVector([1.0], 2.7)
    v2i = OVector([2.6], 1.4)
    @test (!(v1f <= v2f) && !(v2f <= v1f)) == true
    
    v2i = OVector([1.0], 2.7)
    @test isEqual(v2i, v1i) == true
end

