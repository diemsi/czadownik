//---------------------------------------------------------------------------
// Delphi VCL Extensions (RX)
// Copyright (c) 1999 Master-Bank
//---------------------------------------------------------------------------
//---------------------------------------------------------------------------
#include <vcl.h>
#pragma hdrstop
USEPACKAGE("vcl50.bpi");
USEPACKAGE("vcldb50.bpi");
USEPACKAGE("dcldb50.bpi");
USEPACKAGE("dclrx5.bpi");
USEPACKAGE("rxctl5.bpi");
USEPACKAGE("rxdb5.bpi");
USEUNIT("RxDBReg.pas");
USEFORMNS("SelDSFrm.pas", Seldsfrm, SelectDataSetForm);
//---------------------------------------------------------------------------
#pragma package(smart_init)
//---------------------------------------------------------------------------
//   Package source.
//---------------------------------------------------------------------------
int WINAPI DllEntryPoint(HINSTANCE hinst, unsigned long reason, void*)
{
    return 1;
}
//---------------------------------------------------------------------------
