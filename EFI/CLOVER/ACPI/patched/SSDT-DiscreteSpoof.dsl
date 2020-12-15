// save as SSDT-DiscreteSpoof.aml
DefinitionBlock ("", "SSDT", 2, "hack", "spoof", 0)
{

    External (RMDT, DeviceObj) 
    External (RMDT.PUSH, MethodObj)

        
    Method(_SB.PCI0.RP05.PEGP._DSM, 4)
    {
        
        \RMDT.PUSH("_SB.PCI0.RP05.PEGP._DSM")
        
        If (!Arg2) { 
            Return (Buffer() { 0x03 } ) 
        }
        
        Return (Package()
        {
            "name", Buffer() { "#display" },
            "IOName", "#display",
            "class-code", Buffer() { 0xFF, 0xFF, 0xFF, 0xFF },
            "vendor-id", Buffer() { 0xFF, 0xFF, 0,  0 },
            "device-id", Buffer() { 0xFF, 0xFF, 0, 0 },
        })
    }
}
//EOF