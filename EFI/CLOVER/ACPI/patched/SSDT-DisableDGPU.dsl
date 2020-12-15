// Acrescenta o method _INI qeu chama o _OFF caso ele exista

DefinitionBlock("SSDT-DisableDGPU", "SSDT", 2, "hack", "_DDGPU", 0)
{
    External (_SB.PCI0.RP05.PEGP, DeviceObj) 
    External (_SB.PCI0.RP05.PEGP._OFF, MethodObj)
    
    External (RMDT, DeviceObj) 
    External (RMDT.PUSH, MethodObj)
    
    Scope (\_SB.PCI0.RP05.PEGP)
    {
        Method (_INI, 0, NotSerialized)
        {
            \RMDT.PUSH("Disable dGPU. Call _SB.PCI0.RP05.PEGP._OFF")
            
            // disable discrete graphics (Nvidia/Radeon) if it is present
            If (CondRefOf(\_SB.PCI0.RP05.PEGP._OFF))
            {
                \_SB.PCI0.RP05.PEGP._OFF()
            }
        }
    }
}