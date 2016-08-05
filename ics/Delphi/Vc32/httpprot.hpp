// Borland C++ Builder
// Copyright (c) 1995, 2002 by Borland Software Corporation
// All rights reserved

// (DO NOT EDIT: machine generated header) 'HttpProt.pas' rev: 6.00

#ifndef HttpProtHPP
#define HttpProtHPP

#pragma delphiheader begin
#pragma option push -w-
#pragma option push -Vx
#include <WSocket.hpp>	// Pascal unit
#include <Controls.hpp>	// Pascal unit
#include <Forms.hpp>	// Pascal unit
#include <Classes.hpp>	// Pascal unit
#include <SysUtils.hpp>	// Pascal unit
#include <Messages.hpp>	// Pascal unit
#include <Windows.hpp>	// Pascal unit
#include <SysInit.hpp>	// Pascal unit
#include <System.hpp>	// Pascal unit

//-- user supplied -----------------------------------------------------------

namespace Httpprot
{
//-- type declarations -------------------------------------------------------
class DELPHICLASS EHttpException;
class PASCALIMPLEMENTATION EHttpException : public Sysutils::Exception 
{
	typedef Sysutils::Exception inherited;
	
public:
	Word ErrorCode;
	__fastcall EHttpException(const AnsiString Msg, Word ErrCode);
public:
	#pragma option push -w-inl
	/* Exception.CreateFmt */ inline __fastcall EHttpException(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size) : Sysutils::Exception(Msg, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateRes */ inline __fastcall EHttpException(int Ident)/* overload */ : Sysutils::Exception(Ident) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmt */ inline __fastcall EHttpException(int Ident, const System::TVarRec * Args, const int Args_Size)/* overload */ : Sysutils::Exception(Ident, Args, Args_Size) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateHelp */ inline __fastcall EHttpException(const AnsiString Msg, int AHelpContext) : Sysutils::Exception(Msg, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateFmtHelp */ inline __fastcall EHttpException(const AnsiString Msg, const System::TVarRec * Args, const int Args_Size, int AHelpContext) : Sysutils::Exception(Msg, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResHelp */ inline __fastcall EHttpException(int Ident, int AHelpContext)/* overload */ : Sysutils::Exception(Ident, AHelpContext) { }
	#pragma option pop
	#pragma option push -w-inl
	/* Exception.CreateResFmtHelp */ inline __fastcall EHttpException(System::PResStringRec ResStringRec, const System::TVarRec * Args, const int Args_Size, int AHelpContext)/* overload */ : Sysutils::Exception(ResStringRec, Args, Args_Size, AHelpContext) { }
	#pragma option pop
	
public:
	#pragma option push -w-inl
	/* TObject.Destroy */ inline __fastcall virtual ~EHttpException(void) { }
	#pragma option pop
	
};


#pragma option push -b-
enum THttpEncoding { encUUEncode, encBase64, encMime };
#pragma option pop

#pragma option push -b-
enum THttpRequest { httpAbort, httpGET, httpPOST, httpHEAD };
#pragma option pop

#pragma option push -b-
enum THttpState { httpReady, httpNotConnected, httpConnected, httpDnsLookup, httpDnsLookupDone, httpWaitingHeader, httpWaitingBody, httpAborting };
#pragma option pop

typedef void __fastcall (__closure *TOnCommand)(System::TObject* Sender, AnsiString &S);

typedef void __fastcall (__closure *TDocDataEvent)(System::TObject* Sender, void * Buffer, int Len);

typedef void __fastcall (__closure *TCookieRcvdEvent)(System::TObject* Sender, const AnsiString Data, bool &Accept);

typedef void __fastcall (__closure *THttpRequestDone)(System::TObject* Sender, THttpRequest RqType, Word Error);

typedef void __fastcall (__closure *TBeforeHeaderSendEvent)(System::TObject* Sender, const AnsiString Method, Classes::TStrings* Headers);

class DELPHICLASS THttpCli;
class PASCALIMPLEMENTATION THttpCli : public Classes::TComponent 
{
	typedef Classes::TComponent inherited;
	
protected:
	Wsocket::TWSocket* FCtrlSocket;
	HWND FWindowHandle;
	bool FMultiThreaded;
	THttpState FState;
	AnsiString FLocalAddr;
	AnsiString FHostName;
	AnsiString FTargetHost;
	AnsiString FPort;
	AnsiString FProxy;
	AnsiString FProxyPort;
	AnsiString FUsername;
	AnsiString FPassword;
	AnsiString FProxyUsername;
	AnsiString FProxyPassword;
	AnsiString FLocation;
	bool FConnected;
	AnsiString FDnsResult;
	char FSendBuffer[8193];
	THttpRequest FRequestType;
	char FReceiveBuffer[8193];
	int FReceiveLen;
	AnsiString FLastResponse;
	int FHeaderLineCount;
	int FBodyLineCount;
	bool FAllowedToSend;
	AnsiString FURL;
	AnsiString FPath;
	AnsiString FDocName;
	AnsiString FSender;
	AnsiString FReference;
	AnsiString FAgent;
	AnsiString FAccept;
	AnsiString FAcceptLanguage;
	System::TDateTime FModifiedSince;
	bool FNoCache;
	int FStatusCode;
	AnsiString FReasonPhrase;
	int FContentLength;
	AnsiString FContentType;
	Classes::TStringList* FDoAuthor;
	AnsiString FContentPost;
	AnsiString FContentRangeBegin;
	AnsiString FContentRangeEnd;
	AnsiString FAcceptRanges;
	AnsiString FCookie;
	bool FLocationFlag;
	bool FHeaderEndFlag;
	Classes::TStrings* FRcvdHeader;
	Classes::TStream* FRcvdStream;
	int FRcvdCount;
	int FSentCount;
	Classes::TStream* FSendStream;
	Classes::TMemoryStream* FReqStream;
	int FRequestDoneError;
	void __fastcall (__closure *FNext)(void);
	Classes::TNotifyEvent FOnStateChange;
	Classes::TNotifyEvent FOnSessionConnected;
	Classes::TNotifyEvent FOnRequestHeaderBegin;
	Classes::TNotifyEvent FOnRequestHeaderEnd;
	Classes::TNotifyEvent FOnHeaderBegin;
	Classes::TNotifyEvent FOnHeaderEnd;
	Classes::TNotifyEvent FOnHeaderData;
	Classes::TNotifyEvent FOnDocBegin;
	Classes::TNotifyEvent FOnDocEnd;
	TDocDataEvent FOnDocData;
	Classes::TNotifyEvent FOnSendBegin;
	Classes::TNotifyEvent FOnSendEnd;
	TDocDataEvent FOnSendData;
	Classes::TNotifyEvent FOnTrace;
	TOnCommand FOnCommand;
	TCookieRcvdEvent FOnCookie;
	Wsocket::TDataAvailable FOnDataAvailable;
	THttpRequestDone FOnRequestDone;
	Classes::TNotifyEvent FOnLocationChange;
	Wsocket::TSessionConnected FOnSocksConnected;
	Wsocket::TSocksAuthStateEvent FOnSocksAuthState;
	Wsocket::TSocksErrorEvent FOnSocksError;
	Classes::TNotifyEvent FOnSocketError;
	TBeforeHeaderSendEvent FOnBeforeHeaderSend;
	void __fastcall DoSocksConnected(System::TObject* Sender, Word Error);
	void __fastcall DoSocksAuthState(System::TObject* Sender, Wsocket::TSocksAuthState AuthState);
	void __fastcall DoSocksError(System::TObject* Sender, int Error, AnsiString Msg);
	void __fastcall SocketErrorTransfer(System::TObject* Sender);
	void __fastcall SetSocksServer(AnsiString value);
	void __fastcall SetSocksLevel(AnsiString value);
	void __fastcall SetSocksPort(AnsiString value);
	void __fastcall SetSocksUsercode(AnsiString value);
	void __fastcall SetSocksPassword(AnsiString value);
	void __fastcall SetSocksAuthentication(Wsocket::TSocksAuthentication value);
	AnsiString __fastcall GetSocksServer();
	AnsiString __fastcall GetSocksLevel();
	AnsiString __fastcall GetSocksPort();
	AnsiString __fastcall GetSocksUsercode();
	AnsiString __fastcall GetSocksPassword();
	Wsocket::TSocksAuthentication __fastcall GetSocksAuthentication(void);
	void __fastcall SendRequest(const AnsiString method, const AnsiString Version);
	virtual void __fastcall GetHeaderLineNext(void);
	virtual void __fastcall GetBodyLineNext(void);
	virtual void __fastcall SendCommand(const AnsiString Cmd);
	virtual void __fastcall Login(void);
	virtual void __fastcall Logout(void);
	virtual void __fastcall InternalClear(void);
	virtual void __fastcall SocketDNSLookupDone(System::TObject* Sender, Word Error);
	virtual void __fastcall SocketSessionClosed(System::TObject* Sender, Word Error);
	virtual void __fastcall SocketSessionConnected(System::TObject* Sender, Word Error);
	virtual void __fastcall SocketDataSent(System::TObject* Sender, Word Error);
	virtual void __fastcall SocketDataAvailable(System::TObject* Sender, Word Error);
	virtual void __fastcall LocationSessionClosed(System::TObject* Sender, Word Error);
	virtual void __fastcall DoRequestAsync(THttpRequest Rq);
	virtual void __fastcall DoRequestSync(THttpRequest Rq);
	virtual void __fastcall SetMultiThreaded(bool newValue);
	virtual void __fastcall StateChange(THttpState NewState);
	virtual void __fastcall TriggerStateChange(void);
	virtual void __fastcall TriggerCookie(const AnsiString Data, bool &bAccept);
	virtual void __fastcall TriggerSessionConnected(void);
	virtual void __fastcall TriggerBeforeHeaderSend(const AnsiString Method, Classes::TStrings* Headers);
	virtual void __fastcall TriggerRequestHeaderBegin(void);
	virtual void __fastcall TriggerRequestHeaderEnd(void);
	virtual void __fastcall TriggerHeaderBegin(void);
	virtual void __fastcall TriggerHeaderEnd(void);
	virtual void __fastcall TriggerDocBegin(void);
	virtual void __fastcall TriggerDocData(void * Data, int Len);
	virtual void __fastcall TriggerDocEnd(void);
	virtual void __fastcall TriggerSendBegin(void);
	virtual void __fastcall TriggerSendData(void * Data, int Len);
	virtual void __fastcall TriggerSendEnd(void);
	virtual void __fastcall TriggerRequestDone(void);
	void __fastcall WndProc(Messages::TMessage &MsgRec);
	virtual void __fastcall SetReady(void);
	virtual void __fastcall AdjustDocName(void);
	virtual HWND __fastcall HTTPCliAllocateHWnd(Wsocket::TWndMethod Method);
	virtual void __fastcall HTTPCliDeallocateHWnd(HWND WHandle);
	MESSAGE void __fastcall WMHttpRequestDone(Messages::TMessage &msg);
	MESSAGE void __fastcall WMHttpSetReady(Messages::TMessage &msg);
	MESSAGE void __fastcall WMHttpLogin(Messages::TMessage &msg);
	
public:
	__fastcall virtual THttpCli(Classes::TComponent* Aowner);
	__fastcall virtual ~THttpCli(void);
	void __fastcall Get(void);
	void __fastcall Post(void);
	void __fastcall Head(void);
	void __fastcall GetASync(void);
	void __fastcall PostASync(void);
	void __fastcall HeadASync(void);
	void __fastcall Abort(void);
	__property Wsocket::TWSocket* CtrlSocket = {read=FCtrlSocket};
	__property HWND Handle = {read=FWindowHandle, nodefault};
	__property THttpState State = {read=FState, nodefault};
	__property AnsiString LastResponse = {read=FLastResponse};
	__property int ContentLength = {read=FContentLength, nodefault};
	__property AnsiString ContentType = {read=FContentType};
	__property int RcvdCount = {read=FRcvdCount, nodefault};
	__property int SentCount = {read=FSentCount, nodefault};
	__property int StatusCode = {read=FStatusCode, nodefault};
	__property AnsiString ReasonPhrase = {read=FReasonPhrase};
	__property AnsiString DnsResult = {read=FDnsResult};
	__property Classes::TStringList* AuthorizationRequest = {read=FDoAuthor};
	__property AnsiString DocName = {read=FDocName};
	__property AnsiString Location = {read=FLocation, write=FLocation};
	__property Classes::TStream* RcvdStream = {read=FRcvdStream, write=FRcvdStream};
	__property Classes::TStream* SendStream = {read=FSendStream, write=FSendStream};
	__property Classes::TStrings* RcvdHeader = {read=FRcvdHeader};
	__property AnsiString Hostname = {read=FHostName};
	
__published:
	__property AnsiString URL = {read=FURL, write=FURL};
	__property AnsiString LocalAddr = {read=FLocalAddr, write=FLocalAddr};
	__property AnsiString Proxy = {read=FProxy, write=FProxy};
	__property AnsiString ProxyPort = {read=FProxyPort, write=FProxyPort};
	__property AnsiString Sender = {read=FSender, write=FSender};
	__property AnsiString Agent = {read=FAgent, write=FAgent};
	__property AnsiString Accept = {read=FAccept, write=FAccept};
	__property AnsiString AcceptLanguage = {read=FAcceptLanguage, write=FAcceptLanguage};
	__property AnsiString Reference = {read=FReference, write=FReference};
	__property AnsiString Username = {read=FUsername, write=FUsername};
	__property AnsiString Password = {read=FPassword, write=FPassword};
	__property AnsiString ProxyUsername = {read=FProxyUsername, write=FProxyUsername};
	__property AnsiString ProxyPassword = {read=FProxyPassword, write=FProxyPassword};
	__property bool NoCache = {read=FNoCache, write=FNoCache, nodefault};
	__property System::TDateTime ModifiedSince = {read=FModifiedSince, write=FModifiedSince};
	__property AnsiString Cookie = {read=FCookie, write=FCookie};
	__property AnsiString ContentTypePost = {read=FContentPost, write=FContentPost};
	__property AnsiString ContentRangeBegin = {read=FContentRangeBegin, write=FContentRangeBegin};
	__property AnsiString ContentRangeEnd = {read=FContentRangeEnd, write=FContentRangeEnd};
	__property AnsiString AcceptRanges = {read=FAcceptRanges};
	__property bool MultiThreaded = {read=FMultiThreaded, write=SetMultiThreaded, nodefault};
	__property Classes::TNotifyEvent OnTrace = {read=FOnTrace, write=FOnTrace};
	__property Classes::TNotifyEvent OnSessionConnected = {read=FOnSessionConnected, write=FOnSessionConnected};
	__property Classes::TNotifyEvent OnHeaderData = {read=FOnHeaderData, write=FOnHeaderData};
	__property TOnCommand OnCommand = {read=FOnCommand, write=FOnCommand};
	__property Classes::TNotifyEvent OnHeaderBegin = {read=FOnHeaderBegin, write=FOnHeaderBegin};
	__property Classes::TNotifyEvent OnHeaderEnd = {read=FOnHeaderEnd, write=FOnHeaderEnd};
	__property Classes::TNotifyEvent OnRequestHeaderBegin = {read=FOnRequestHeaderBegin, write=FOnRequestHeaderBegin};
	__property Classes::TNotifyEvent OnRequestHeaderEnd = {read=FOnRequestHeaderEnd, write=FOnRequestHeaderEnd};
	__property Classes::TNotifyEvent OnDocBegin = {read=FOnDocBegin, write=FOnDocBegin};
	__property TDocDataEvent OnDocData = {read=FOnDocData, write=FOnDocData};
	__property Classes::TNotifyEvent OnDocEnd = {read=FOnDocEnd, write=FOnDocEnd};
	__property Classes::TNotifyEvent OnSendBegin = {read=FOnSendBegin, write=FOnSendBegin};
	__property TDocDataEvent OnSendData = {read=FOnSendData, write=FOnSendData};
	__property Classes::TNotifyEvent OnSendEnd = {read=FOnSendEnd, write=FOnSendEnd};
	__property Classes::TNotifyEvent OnStateChange = {read=FOnStateChange, write=FOnStateChange};
	__property THttpRequestDone OnRequestDone = {read=FOnRequestDone, write=FOnRequestDone};
	__property Classes::TNotifyEvent OnLocationChange = {read=FOnLocationChange, write=FOnLocationChange};
	__property TCookieRcvdEvent OnCookie = {read=FOnCookie, write=FOnCookie};
	__property AnsiString SocksServer = {read=GetSocksServer, write=SetSocksServer};
	__property AnsiString SocksLevel = {read=GetSocksLevel, write=SetSocksLevel};
	__property AnsiString SocksPort = {read=GetSocksPort, write=SetSocksPort};
	__property AnsiString SocksUsercode = {read=GetSocksUsercode, write=SetSocksUsercode};
	__property AnsiString SocksPassword = {read=GetSocksPassword, write=SetSocksPassword};
	__property Wsocket::TSocksAuthentication SocksAuthentication = {read=GetSocksAuthentication, write=SetSocksAuthentication, nodefault};
	__property Wsocket::TSessionConnected OnSocksConnected = {read=FOnSocksConnected, write=FOnSocksConnected};
	__property Wsocket::TSocksAuthStateEvent OnSocksAuthState = {read=FOnSocksAuthState, write=FOnSocksAuthState};
	__property Wsocket::TSocksErrorEvent OnSocksError = {read=FOnSocksError, write=FOnSocksError};
	__property Classes::TNotifyEvent OnSocketError = {read=FOnSocketError, write=FOnSocketError};
	__property TBeforeHeaderSendEvent OnBeforeHeaderSend = {read=FOnBeforeHeaderSend, write=FOnBeforeHeaderSend};
};


//-- var, const, procedure ---------------------------------------------------
static const Byte HttpCliVersion = 0x93;
extern PACKAGE AnsiString CopyRight;
#define DefaultProxyPort "80"
static const Word HTTP_RCV_BUF_SIZE = 0x2001;
static const Word HTTP_SND_BUF_SIZE = 0x2001;
static const Word WM_HTTP_REQUEST_DONE = 0x401;
static const Word WM_HTTP_SET_READY = 0x402;
static const Word WM_HTTP_LOGIN = 0x403;
static const Shortint httperrNoError = 0x0;
static const Shortint httperrBusy = 0x1;
static const Shortint httperrNoData = 0x2;
static const Shortint httperrAborted = 0x3;
static const Shortint httperrOverflow = 0x4;
extern PACKAGE void __fastcall Register(void);
extern PACKAGE AnsiString __fastcall RFC1123_Date(System::TDateTime aDate);
extern PACKAGE void __fastcall ReplaceExt(AnsiString &FName, const AnsiString newExt);
extern PACKAGE void __fastcall ParseURL(const AnsiString URL, AnsiString &Proto, AnsiString &User, AnsiString &Pass, AnsiString &Host, AnsiString &Port, AnsiString &Path);
extern PACKAGE AnsiString __fastcall EncodeStr(THttpEncoding Encoding, const AnsiString Value);
extern PACKAGE AnsiString __fastcall EncodeLine(THttpEncoding Encoding, char * SrcData, int Size);
extern PACKAGE int __fastcall Posn(const AnsiString s, const AnsiString t, int count);
extern PACKAGE bool __fastcall IsDigit(char Ch);
extern PACKAGE bool __fastcall IsXDigit(char Ch);
extern PACKAGE int __fastcall XDigit(char Ch);
extern PACKAGE int __fastcall htoin(char * value, int len);
extern PACKAGE int __fastcall htoi2(char * value);
extern PACKAGE AnsiString __fastcall UrlEncode(AnsiString S);
extern PACKAGE AnsiString __fastcall UrlDecode(AnsiString S);

}	/* namespace Httpprot */
using namespace Httpprot;
#pragma option pop	// -w-
#pragma option pop	// -Vx

#pragma delphiheader end.
//-- end unit ----------------------------------------------------------------
#endif	// HttpProt
