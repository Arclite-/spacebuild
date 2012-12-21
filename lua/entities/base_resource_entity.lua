AddCSLuaFile( )

DEFINE_BASECLASS( "base_anim" )

ENT.PrintName		= "Base Resource Entity"
ENT.Author			= "SnakeSVx"
ENT.Contact			= ""
ENT.Purpose			= "Testing"
ENT.Instructions	= ""

ENT.Spawnable 		= false
ENT.AdminOnly 		= false

function ENT:Initialize()
    sb.registerDevice(self, sb.RDTYPES.STORAGE)
end


function ENT:OnRemove()
    sb.removeDevice(self)
end

if ( CLIENT ) then

    function ENT:BeingLookedAtByLocalPlayer()

        if ( LocalPlayer():GetEyeTrace().Entity ~= self ) then return false end
        if ( EyePos():Distance( self:GetPos() ) > 256 ) then return false end

        return true

    end

    function ENT:Draw()
        if self:BeingLookedAtByLocalPlayer() and self.rdobject then
            local resources = self.rdobject:getResources()
            local full_string = self.PrintName .. "\nResources:\n"
            for _, v in pairs(resources) do
                full_string = full_string ..v:getName().." = "..tostring(self.rdobject:getResourceAmount(v:getName())).."/"..tostring(self.rdobject:getMaxResourceAmount( v:getName())).."\n"
            end
            AddWorldTip(self:EntIndex(), full_string, 0.5, self:GetPos(), self)
        end
        self:DrawModel()

    end

end

