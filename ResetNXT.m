function [] = ResetNXT( )
%RESETNXT Summary of this function goes here
%   Detailed explanation goes here
try
   COM_CloseNXT(COM_GetDefaultNXT());
end

h = COM_OpenNXT();
COM_SetDefaultNXT(h);

end

