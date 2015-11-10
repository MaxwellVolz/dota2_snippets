require( 'physics' )

function OnStartTouch(trigger)

	print(trigger.activator)
	print(trigger.caller)

end

function jumpPad0_0(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.454,-0.940,0),1600)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad0_1(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.336,-0.942,0),1600)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad0_2(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.348,-0.938,0),1520)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad0_3(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.282,-0.959,0),1520)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad1_0(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.282,0.960,0),1900)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad1_1(trigger)
    print(trigger.activator:GetForwardVector())
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)
    doJump(trigger.activator,Vector(-0.342,0.940,0),1600)
end
function jumpPad1_2(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.347,0.938,0),1500)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad1_3(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-.0375,0.927,0),1600)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad2_0(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.410,-0.912,0),1500)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad2_1(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.345,-0.939,0),1400)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad2_2(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.383,-0.924,0),1500)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)

end
function jumpPad2_3(trigger)
    print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.288,-0.958,0),1500)
    --doJump(trigger.activator,trigger.activator:GetForwardVector(),1500)
end
function jumpPad3_0(trigger)
    --print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.367,0.93,0),1500)
end
function jumpPad3_1(trigger)
    --print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.401,0.92,0),1550)
end
function jumpPad3_2(trigger)
    --print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(-0.412,0.900,0),1500)
end
function jumpPad3_3(trigger)
    --print(trigger.activator:GetForwardVector())
    doJump(trigger.activator,Vector(0.355,0.935,0),1500)
end
 
 
function doJump(caster,direction,distance)  
     
    -- Clears any current command
    caster:Stop()
 
    -- Physics
    -- local direction = caster:GetForwardVector()
 
    -- hard coded direction
    --local direction = Vector(-0.367,0.93,0)

 
    --print(direction)
    -- local velocity = leap_speed * 1.4
    -- local end_time = leap_distance / leap_speed
    local velocity = 1600 * 1.4
    local end_time = distance / 1600
    local time_elapsed = 0
    local time = end_time/2
    local jump = end_time/0.03
 
    Physics:Unit(caster)
 
    caster:PreventDI(true)
    caster:SetAutoUnstuck(false)
    caster:SetNavCollisionType(PHYSICS_NAV_NOTHING)
    caster:FollowNavMesh(false)
    caster:SetPhysicsVelocity(direction * velocity)
 
 
    -- Move the unit
    Timers:CreateTimer(0, function()
        local ground_position = GetGroundPosition(caster:GetAbsOrigin() , caster)
        time_elapsed = time_elapsed + 0.03
        if time_elapsed < time then
            caster:SetAbsOrigin(caster:GetAbsOrigin() + Vector(0,0,jump)) -- Going up
        else
            caster:SetAbsOrigin(caster:GetAbsOrigin() - Vector(0,0,jump)) -- Going down
        end
        -- If the target reached the ground then remove physics
        if caster:GetAbsOrigin().z - ground_position.z <= 0 then
            caster:SetPhysicsAcceleration(Vector(0,0,0))
            caster:SetPhysicsVelocity(Vector(0,0,0))
            caster:OnPhysicsFrame( nil)
            caster:PreventDI( false)
            caster:SetNavCollisionType(PHYSICS_NAV_SLIDE)
            caster:SetAutoUnstuck(true)
            caster:FollowNavMesh(true)
            caster:SetPhysicsFriction(.05)
            return nil
        end
 
        return 0.03
    end)
end

