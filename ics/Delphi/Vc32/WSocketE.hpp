// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'WSocketE.pas' rev: 6.00

#ifndef WSocketEHPP
#define WSocketEHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <SysUtils.hpp>	// Pascal unit
#include <DesignEditors.hpp>	// Pascal unit
#include <DesignIntf.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Wsockete
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS TWSocketLineEndProperty;
class PASCALIMPLEMENTATION TWSocketLineEndProperty : public Designeditors::TStringProperty 
{
	typedef Designeditors::TStringProperty inherited;
	
public:
	AnsiString __fastcall GetLineEnd(const AnsiString Value);
	AnsiString __fastcall SetLineEnd(const AnsiString Value);
	virtual AnsiString __fastcall GetValue();
	virtual void __fastcall SetValue(const AnsiString Value);
public:
	#pragma option push -w-inl
	/* TPropertyEditor.Create */ inline __fastcall virtual TWSocketLineEndProperty(const Designintf::_di_IDesigner ADesigner, int APropCount) : Designeditors::TStringProperty(ADesigner, APropCount) { }
	#pragma option pop
	#pragma option push -w-inl
	/* TPropertyEditor.Destroy */ inline __fastcall virtual ~TWSocketLineEndProperty(void) { }
	#pragma option pop
	
};


//-- var, const, procedure ---------------------------------------------------
extern PACKAGE void __fastcall Register(void);

}	/* namespace Wsockete */
using namespace Wsockete;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// WSocketE
