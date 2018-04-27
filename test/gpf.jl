function check_voltage_status(sol)
    for (idx,val) in sol["bus"]
        @test val["vm"] >= 0.8 && val["vm"] <= 1.2 
    end
end

function check_pressure_status(sol)
    for (idx,val) in sol["junction"]
        @test val["p"] >= 0.0
    end
end

#Check the qp gas and power flow model
@testset "test qp gf pf" begin
    @testset "IEEE 14 Belgian case" begin
        result = run_gpf("../test/data/belgian-ieee14.json", "../test/data/case14.m", "../test/data/belgian.json", QPGasGridModel, SOCWRPowerModel, MISOCPGasModel, misocp_solver)
        @test result["status"] == :LocalOptimal || result["status"] == :Optimal
        @test isapprox(result["objective"], 0; atol = 1e-6)
        check_voltage_status(result["solution"])
        check_pressure_status(result["solution"])                    
    end      
end




