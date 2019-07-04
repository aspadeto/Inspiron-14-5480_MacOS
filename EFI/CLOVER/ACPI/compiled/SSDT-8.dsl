/*
 * Intel ACPI Component Architecture
 * AML/ASL+ Disassembler version 20161210-64(RM)
 * Copyright (c) 2000 - 2016 Intel Corporation
 * 
 * Disassembling to non-symbolic legacy ASL operators
 *
 * Disassembly of SSDT-8.aml, Wed Jul  3 01:06:19 2019
 *
 * Original Table Header:
 *     Signature        "SSDT"
 *     Length           0x000005B8 (1464)
 *     Revision         0x02
 *     Checksum         0xA2
 *     OEM ID           "SgRef"
 *     OEM Table ID     "SgRpSsdt"
 *     OEM Revision     0x00001000 (4096)
 *     Compiler ID      "INTL"
 *     Compiler Version 0x20160527 (538314023)
 */
DefinitionBlock ("", "SSDT", 2, "SgRef", "SgRpSsdt", 0x00001000)
{
    External (_SB_.GGOV, MethodObj)    // 1 Arguments (from opcode)
    External (_SB_.PCI0, DeviceObj)    // (from opcode)
    External (_SB_.PCI0.RP05._ADR, MethodObj)    // 0 Arguments (from opcode)
    External (_SB_.PR00, UnknownObj)    // Warning: Unknown object
    External (_SB_.PR00.DGFF, UnknownObj)    // (from opcode)
    External (_SB_.PR01, UnknownObj)    // (from opcode)
    External (_SB_.PR02, UnknownObj)    // (from opcode)
    External (_SB_.PR03, UnknownObj)    // (from opcode)
    External (_SB_.PR04, UnknownObj)    // (from opcode)
    External (_SB_.PR05, UnknownObj)    // (from opcode)
    External (_SB_.PR06, UnknownObj)    // (from opcode)
    External (_SB_.PR07, UnknownObj)    // (from opcode)
    External (_SB_.SGOV, MethodObj)    // 2 Arguments (from opcode)
    External (DLHR, UnknownObj)    // (from opcode)
    External (DLPW, UnknownObj)    // (from opcode)
    External (EECP, UnknownObj)    // (from opcode)
    External (GBAS, UnknownObj)    // (from opcode)
    External (HRA0, UnknownObj)    // (from opcode)
    External (HRE0, UnknownObj)    // (from opcode)
    External (HRG0, UnknownObj)    // (from opcode)
    External (OSYS, UnknownObj)    // (from opcode)
    External (PWA0, UnknownObj)    // (from opcode)
    External (PWE0, UnknownObj)    // (from opcode)
    External (PWG0, UnknownObj)    // (from opcode)
    External (RPA5, UnknownObj)    // (from opcode)
    External (RPIN, UnknownObj)    // (from opcode)
    External (SGGP, UnknownObj)    // (from opcode)
    External (SGMD, UnknownObj)    // (from opcode)
    External (XBAS, UnknownObj)    // (from opcode)

    Scope (\_SB.PCI0)
    {
        Name (IVID, 0xFFFF)
        Name (ELCT, Zero)
        Name (HVID, Zero)
        Name (HDID, Zero)
        Name (LTRE, Zero)
        OperationRegion (RPCF, SystemMemory, Add (Add (\XBAS, ShiftLeft (ShiftRight (And (\_SB.PCI0.RP05._ADR (), 0x00FF0000), 0x10), 0x0F)), ShiftLeft (And (\RPA5, 0x0F), 0x0C)), 0x1000)
        Field (RPCF, DWordAcc, NoLock, Preserve)
        {
            PVID,   16, 
            PDID,   16, 
            Offset (0x18), 
            PRBN,   8, 
            SCBN,   8, 
            Offset (0x4A), 
            CEDN,   1, 
            Offset (0x50), 
            ASPN,   2, 
                ,   2, 
            LKDN,   1, 
            Offset (0x52), 
                ,   13, 
            LASX,   1, 
            Offset (0x69), 
                ,   2, 
            LREN,   1, 
            Offset (0xE2), 
                ,   2, 
            L23E,   1, 
            L23R,   1, 
            Offset (0x328), 
                ,   19, 
            LNKS,   4
        }

        OperationRegion (RTPN, SystemMemory, Add (\XBAS, ShiftLeft (SCBN, 0x14)), 0xF0)
        Field (RTPN, AnyAcc, Lock, Preserve)
        {
            DVID,   16, 
            Offset (0x0B), 
            CBCN,   8, 
            Offset (0x2C), 
            SVID,   16, 
            SDID,   16
        }

        OperationRegion (PCAN, SystemMemory, Add (Add (\XBAS, ShiftLeft (SCBN, 0x14)), \EECP), 0x14)
        Field (PCAN, DWordAcc, NoLock, Preserve)
        {
            Offset (0x10), 
            LCTR,   16
        }

        OperationRegion (PCBN, SystemMemory, Add (Add (Add (\XBAS, ShiftLeft (SCBN, 0x14)), 0x1000), \EECP), 0x14)
        Field (PCBN, DWordAcc, NoLock, Preserve)
        {
            Offset (0x10), 
            LCTZ,   16
        }

        Method (HGON, 0, Serialized)
        {
            If (LEqual (CCHK (One), Zero))
            {
                Return (Zero)
            }

            SGPO (PWE0, PWG0, PWA0, One)
            Sleep (DLPW)
            SGPO (HRE0, HRG0, HRA0, Zero)
            Sleep (DLHR)
            Store (One, \_SB.PR00.DGFF)
            Notify (\_SB.PR00, 0x81)
            Notify (\_SB.PR01, 0x81)
            Notify (\_SB.PR02, 0x81)
            Notify (\_SB.PR03, 0x81)
            Notify (\_SB.PR04, 0x81)
            Notify (\_SB.PR05, 0x81)
            Notify (\_SB.PR06, 0x81)
            Notify (\_SB.PR07, 0x81)
            Store (Zero, LKDN)
            While (LLess (LNKS, 0x07))
            {
                Sleep (One)
            }

            Store (HVID, SVID)
            Store (HDID, SDID)
            Or (And (ELCT, 0x43), And (LCTR, 0xFFBC), LCTR)
            Or (And (ELCT, 0x43), And (LCTZ, 0xFFBC), LCTZ)
            While (LLess (\_SB.PCI0.LNKS, 0x07))
            {
                Sleep (One)
            }

            Store (LTRE, LREN)
            Store (One, CEDN)
            SGPO (Zero, 0x04060001, One, One)
            Return (Zero)
        }

        Method (HGOF, 0, Serialized)
        {
            If (LEqual (CCHK (Zero), Zero))
            {
                Return (Zero)
            }

            SGPO (Zero, 0x04060001, One, Zero)
            Store (LCTR, ELCT)
            Store (SVID, HVID)
            Store (SDID, HDID)
            Store (LREN, LTRE)
            Store (One, LKDN)
            While (LNotEqual (LNKS, Zero))
            {
                Sleep (One)
            }

            SGPO (HRE0, HRG0, HRA0, One)
            SGPO (PWE0, PWG0, PWA0, Zero)
            Sleep (DLHR)
            Store (Zero, \_SB.PR00.DGFF)
            Notify (\_SB.PR00, 0x81)
            Notify (\_SB.PR01, 0x81)
            Notify (\_SB.PR02, 0x81)
            Notify (\_SB.PR03, 0x81)
            Notify (\_SB.PR04, 0x81)
            Notify (\_SB.PR05, 0x81)
            Notify (\_SB.PR06, 0x81)
            Notify (\_SB.PR07, 0x81)
            Return (Zero)
        }

        Method (SGPO, 4, Serialized)
        {
            If (LEqual (Arg2, Zero))
            {
                Not (Arg3, Arg3)
                And (Arg3, One, Arg3)
            }

            If (LEqual (SGGP, One))
            {
                If (CondRefOf (\_SB.SGOV))
                {
                    \_SB.SGOV (Arg1, Arg3)
                }
            }
        }

        Method (SGPI, 4, Serialized)
        {
            If (LEqual (Arg0, One))
            {
                If (CondRefOf (\_SB.GGOV))
                {
                    Store (\_SB.GGOV (Arg2), Local0)
                }
            }

            If (LEqual (Arg3, Zero))
            {
                Not (Local0, Local0)
            }

            And (Local0, One, Local0)
            Return (Local0)
        }

        Method (CCHK, 1, NotSerialized)
        {
            If (LEqual (PVID, IVID))
            {
                Return (Zero)
            }

            If (LEqual (Arg0, Zero))
            {
                If (LEqual (SGPI (SGGP, PWE0, PWG0, PWA0), Zero))
                {
                    Return (Zero)
                }
            }
            ElseIf (LEqual (Arg0, One))
            {
                If (LEqual (SGPI (SGGP, PWE0, PWG0, PWA0), One))
                {
                    Return (Zero)
                }
            }

            Return (One)
        }
    }
}

