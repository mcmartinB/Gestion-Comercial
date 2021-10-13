unit wgssSTU_TLB;

// ************************************************************************ //
// WARNING                                                                    
// -------                                                                    
// The types declared in this file were generated from data read from a       
// Type Library. If this type library is explicitly or indirectly (via        
// another type library referring to this type library) re-imported, or the   
// 'Refresh' command of the Type Library Editor activated while editing the   
// Type Library, the contents of this file will be regenerated and all        
// manual modifications will be lost.                                         
// ************************************************************************ //

// PASTLWTR : 1.2
// File generated on 12/08/2013 9:47:10 from Type Library described below.

// ************************************************************************  //
// Type Lib: C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll (1)
// LIBID: {20007867-2524-410F-A904-CF6A6A976D89}
// LCID: 0
// Helpfile: 
// HelpString: Wacom STU SDK 1.0 Type Library
// DepndLst: 
//   (1) v2.0 stdole, (C:\Windows\SysWOW64\stdole2.tlb)
// Errors:
//   Hint: Member 'Interface' of 'IProtocol' changed to 'Interface_'
//   Hint: Member 'set' of 'IInterface' changed to 'set_'
//   Error creating palette bitmap of (TUsbInterface) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TSerialInterface) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TUsbDevices) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TJScript) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TProtocolHelper) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TReportHandler) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TTablet) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
//   Error creating palette bitmap of (TComponent) : Server C:\Program Files (x86)\Wacom STU SDK\COM\bin\Win32\wgssSTU.dll contains no icons
// ************************************************************************ //
// *************************************************************************//
// NOTE:                                                                      
// Items guarded by $IFDEF_LIVE_SERVER_AT_DESIGN_TIME are used by properties  
// which return objects that may need to be explicitly created via a function 
// call prior to any access via the property. These items have been disabled  
// in order to prevent accidental use from within the object inspector. You   
// may enable them by defining LIVE_SERVER_AT_DESIGN_TIME or by selectively   
// removing them from the $IFDEF blocks. However, such items must still be    
// programmatically created via a method of the appropriate CoClass before    
// they can be used.                                                          
{$TYPEDADDRESS OFF} // Unit must be compiled without type-checked pointers. 
{$WARN SYMBOL_PLATFORM OFF}
{$WRITEABLECONST ON}
{$VARPROPSETTER ON}
interface

uses Windows, ActiveX, Classes, Graphics, OleServer, StdVCL, Variants;
  

// *********************************************************************//
// GUIDS declared in the TypeLibrary. Following prefixes are used:        
//   Type Libraries     : LIBID_xxxx                                      
//   CoClasses          : CLASS_xxxx                                      
//   DISPInterfaces     : DIID_xxxx                                       
//   Non-DISP interfaces: IID_xxxx                                        
// *********************************************************************//
const
  // TypeLibrary Major and minor versions
  wgssSTUMajorVersion = 1;
  wgssSTUMinorVersion = 0;

  LIBID_wgssSTU: TGUID = '{20007867-2524-410F-A904-CF6A6A976D89}';

  IID_IProtocol: TGUID = '{20003973-823A-4431-A479-3AA86D58A633}';
  IID_IInterface: TGUID = '{200016D1-CBE2-4625-9F64-9685A2C09838}';
  IID_IInterfaceQueue: TGUID = '{20001FFA-3449-4592-8772-C7C00D46499B}';
  IID_IPredicate: TGUID = '{20008863-5B2A-40BE-8E69-4D2F20303732}';
  IID_IStatus: TGUID = '{2000F706-6451-4F84-BA53-EA90D9BD52DB}';
  IID_IInformation: TGUID = '{200021D5-E224-4C70-A8CB-A62E90183DA9}';
  IID_ICapability: TGUID = '{200028BD-1A2E-4C77-BEBB-EBEF8989EFEA}';
  IID_IInkThreshold: TGUID = '{20003425-E218-45D6-B3E2-961C74364617}';
  IID_IHandwritingThicknessColor: TGUID = '{20004323-9CF7-4375-B7C3-DEFDF8588FAD}';
  IID_IHandwritingDisplayArea: TGUID = '{2000518C-05F0-4D88-B867-C5C9D58C04C5}';
  IID_IUsbDevice: TGUID = '{20006935-F639-4B1E-845F-5B6A6E590E7F}';
  IID_IUsbDevices: TGUID = '{20008CC2-6576-4665-8411-99291CF18387}';
  IID_IErrorCode: TGUID = '{20001A79-3839-4E67-9855-075A7312AA0D}';
  IID_IUsbInterface: TGUID = '{2000C1D7-8270-490B-A8F3-766258E6BAB9}';
  IID_ISerialInterface: TGUID = '{20003D0C-A047-4487-8FE0-0CF9AB05E48C}';
  IID_IPenData: TGUID = '{20003BCE-8DD9-43AD-819B-F746171CA1EC}';
  IID_IPenDataOption: TGUID = '{200041E8-CBEC-4414-A64D-B6600A4D3FF6}';
  IID_IPenDataEncrypted: TGUID = '{20007929-8A2A-49DF-8B6D-38B71F8991AB}';
  IID_IPenDataEncryptedOption: TGUID = '{200088A2-DC76-4716-8879-6E6115A1BBE8}';
  IID_IProtocolHelper: TGUID = '{2000550B-EFC5-4D5F-8969-45C9A67CC93C}';
  IID_IReport: TGUID = '{2000122F-B55F-40DE-9284-277D32AEE77F}';
  IID_IDecrypt: TGUID = '{20007FDA-B1C5-44F2-A8F8-AFCD4E6A76C2}';
  IID_IReportHandler: TGUID = '{2000446E-736E-4513-9751-A9B69648863E}';
  IID_ITabletEncryptionHandler: TGUID = '{2000B2ED-AEDA-4E86-8A69-BB987FA3B238}';
  IID_ITablet: TGUID = '{20005C27-7729-492F-8106-540F2E04DC66}';
  IID_IJScript: TGUID = '{200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}';
  IID_IComponentFile: TGUID = '{20005C8A-5280-4C4D-8565-DED24A3672F5}';
  IID_IComponentFiles: TGUID = '{2000A6E2-D773-4829-9B61-78DAC3CCAD82}';
  IID_IComponent: TGUID = '{20001D33-3D2C-4E4D-AFE8-5E5D446637FD}';
  DIID_IInterfaceEvents: TGUID = '{2000A1EE-8F0B-4027-B84E-A8172950CF0C}';
  DIID_IReportHandlerEvents: TGUID = '{20004D65-E291-4B63-8062-7E99EBD21BDF}';
  IID_ITabletEventsException: TGUID = '{20005380-DA13-492A-A97F-EE5811B49B1C}';
  DIID_ITabletEvents: TGUID = '{2000C72A-E338-477E-B359-D6D00006D29E}';
  CLASS_UsbInterface: TGUID = '{2000BC66-5735-45C7-9521-93FAAFE8C3BB}';
  CLASS_SerialInterface: TGUID = '{20001CFF-184E-4E32-9FC4-A617533D342E}';
  CLASS_UsbDevices: TGUID = '{2000D7A5-64F7-4826-B56E-85ACC618E4D6}';
  CLASS_JScript: TGUID = '{2000D408-6AFE-4CBA-BDB1-DA087DA66B05}';
  CLASS_ProtocolHelper: TGUID = '{2000CF89-E182-40AD-A8C2-5694987EA5DF}';
  CLASS_ReportHandler: TGUID = '{20008BA5-8133-45BA-91A5-AB54A1F70E13}';
  CLASS_Tablet: TGUID = '{20002178-1165-4D38-A7F5-B169DE2045C1}';
  CLASS_Component: TGUID = '{20000000-5D96-46B0-895F-B0CC7295E44D}';

// *********************************************************************//
// Declaration of Enumerations defined in Type Library                    
// *********************************************************************//
// Constants for enum statusCode
type
  statusCode = TOleEnum;
const
  StatusCode_Ready = $00000000;
  StatusCode_Image = $00000001;
  StatusCode_Capture = $00000002;
  StatusCode_Calculation = $00000003;

// Constants for enum ErrorCode
type
  ErrorCode = TOleEnum;
const
  ErrorCode_None = $00000000;
  ErrorCode_WrongReportId = $00000001;
  ErrorCode_WrongState = $00000002;
  ErrorCode_CRC = $00000003;
  ErrorCode_GraphicsWrongEncodingType = $00000010;
  ErrorCode_GraphicsImageTooLong = $00000011;
  ErrorCode_GraphicsZlibError = $00000012;

// Constants for enum resetFlag
type
  resetFlag = TOleEnum;
const
  ResetFlag_Software = $00000000;
  ResetFlag_Hardware = $00000001;

// Constants for enum inkingMode
type
  inkingMode = TOleEnum;
const
  InkingMode_Off = $00000000;
  InkingMode_On = $00000001;

// Constants for enum ReportId
type
  ReportId = TOleEnum;
const
  ReportId_PenData = $00000001;
  ReportId_Status = $00000003;
  ReportId_Reset = $00000004;
  ReportId_Information = $00000008;
  ReportId_Capability = $00000009;
  ReportId_Uid = $0000000A;
  ReportId_PenDataEncrypted = $00000010;
  ReportId_HostPublicKey = $00000013;
  ReportId_DevicePublicKey = $00000014;
  ReportId_StartCapture = $00000015;
  ReportId_EndCapture = $00000016;
  ReportId_DHprime = $0000001A;
  ReportId_DHbase = $0000001B;
  ReportId_ClearScreen = $00000020;
  ReportId_InkingMode = $00000021;
  ReportId_InkThreshold = $00000022;
  ReportId_StartImageData = $00000025;
  ReportId_ImageDataBlock = $00000026;
  ReportId_EndImageData = $00000027;
  ReportId_HandwritingThicknessColor = $00000028;
  ReportId_BackgroundColor = $00000029;
  ReportId_HandwritingDisplayArea = $0000002A;
  ReportId_BacklightBrightness = $0000002B;
  ReportId_PenDataOption = $00000030;
  ReportId_PenDataEncryptedOption = $00000031;
  ReportId_PenDataOptionMode = $00000032;
  ReportId_GetReport = $00000080;
  ReportId_SetResult = $00000081;

// Constants for enum encodingMode
type
  encodingMode = TOleEnum;
const
  EncodingMode_Raw = $00000000;
  EncodingMode_Zlib = $00000001;
  EncodingMode_16bit_565 = $00000002;
  EncodingMode_Bulk = $00000010;

// Constants for enum penDataOptionMode
type
  penDataOptionMode = TOleEnum;
const
  PenDataOptionMode_None = $00000000;
  PenDataOptionMode_TimeCount = $00000001;
  PenDataOptionMode_SequenceNumber = $00000002;

// Constants for enum Scale
type
  Scale = TOleEnum;
const
  Scale_Stretch = $00000000;
  Scale_Fit = $00000001;
  Scale_Clip = $00000002;

// Constants for enum Clip
type
  Clip = TOleEnum;
const
  Clip_Left = $00000000;
  Clip_Center = $00000001;
  Clip_Right = $00000002;
  Clip_Top = $00000000;
  Clip_Middle = $00000010;
  Clip_Bottom = $00000020;

// Constants for enum OpDirection
type
  OpDirection = TOleEnum;
const
  OpDirection_Get = $00000100;
  OpDirection_Set = $00000200;

type

// *********************************************************************//
// Forward declaration of types defined in TypeLibrary                    
// *********************************************************************//
  IProtocol = interface;
  IProtocolDisp = dispinterface;
  IInterface = interface;
  IInterfaceDisp = dispinterface;
  IInterfaceQueue = interface;
  IInterfaceQueueDisp = dispinterface;
  IPredicate = interface;
  IPredicateDisp = dispinterface;
  IStatus = interface;
  IStatusDisp = dispinterface;
  IInformation = interface;
  IInformationDisp = dispinterface;
  ICapability = interface;
  ICapabilityDisp = dispinterface;
  IInkThreshold = interface;
  IInkThresholdDisp = dispinterface;
  IHandwritingThicknessColor = interface;
  IHandwritingThicknessColorDisp = dispinterface;
  IHandwritingDisplayArea = interface;
  IHandwritingDisplayAreaDisp = dispinterface;
  IUsbDevice = interface;
  IUsbDeviceDisp = dispinterface;
  IUsbDevices = interface;
  IUsbDevicesDisp = dispinterface;
  IErrorCode = interface;
  IErrorCodeDisp = dispinterface;
  IUsbInterface = interface;
  IUsbInterfaceDisp = dispinterface;
  ISerialInterface = interface;
  ISerialInterfaceDisp = dispinterface;
  IPenData = interface;
  IPenDataDisp = dispinterface;
  IPenDataOption = interface;
  IPenDataOptionDisp = dispinterface;
  IPenDataEncrypted = interface;
  IPenDataEncryptedDisp = dispinterface;
  IPenDataEncryptedOption = interface;
  IPenDataEncryptedOptionDisp = dispinterface;
  IProtocolHelper = interface;
  IProtocolHelperDisp = dispinterface;
  IReport = interface;
  IReportDisp = dispinterface;
  IDecrypt = interface;
  IDecryptDisp = dispinterface;
  IReportHandler = interface;
  IReportHandlerDisp = dispinterface;
  ITabletEncryptionHandler = interface;
  ITabletEncryptionHandlerDisp = dispinterface;
  ITablet = interface;
  ITabletDisp = dispinterface;
  IJScript = interface;
  IJScriptDisp = dispinterface;
  IComponentFile = interface;
  IComponentFileDisp = dispinterface;
  IComponentFiles = interface;
  IComponentFilesDisp = dispinterface;
  IComponent = interface;
  IComponentDisp = dispinterface;
  IInterfaceEvents = dispinterface;
  IReportHandlerEvents = dispinterface;
  ITabletEventsException = interface;
  ITabletEventsExceptionDisp = dispinterface;
  ITabletEvents = dispinterface;

// *********************************************************************//
// Declaration of CoClasses defined in Type Library                       
// (NOTE: Here we map each CoClass to its Default Interface)              
// *********************************************************************//
  UsbInterface = IUsbInterface;
  SerialInterface = ISerialInterface;
  UsbDevices = IUsbDevices;
  JScript = IJScript;
  ProtocolHelper = IProtocolHelper;
  ReportHandler = IReportHandler;
  Tablet = ITablet;
  Component = IComponent;


// *********************************************************************//
// Declaration of structures, unions and aliases.                         
// *********************************************************************//
  PPSafeArray1 = ^PSafeArray; {*}
  PWordBool1 = ^WordBool; {*}


// *********************************************************************//
// Interface: IProtocol
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003973-823A-4431-A479-3AA86D58A633}
// *********************************************************************//
  IProtocol = interface(IDispatch)
    ['{20003973-823A-4431-A479-3AA86D58A633}']
    function Get_Interface_: IInterface; safecall;
    function getStatus: IStatus; safecall;
    procedure setReset(resetFlag: Byte); safecall;
    function getInformation: IInformation; safecall;
    function getCapability: ICapability; safecall;
    function getUid: SYSUINT; safecall;
    procedure setUid(uid: SYSUINT); safecall;
    function getHostPublicKey: PSafeArray; safecall;
    procedure setHostPublicKey(publicKey: PSafeArray); safecall;
    function getDevicePublicKey: PSafeArray; safecall;
    procedure setStartCapture(sessionId: SYSUINT); safecall;
    procedure setEndCapture; safecall;
    function getDHprime: PSafeArray; safecall;
    procedure setDHprime(dhPrime: PSafeArray); safecall;
    function getDHbase: PSafeArray; safecall;
    procedure setDHbase(dhBase: PSafeArray); safecall;
    procedure setClearScreen; safecall;
    function getInkingMode: Byte; safecall;
    procedure setInkingMode(inkingMode: Byte); safecall;
    function getInkThreshold: IInkThreshold; safecall;
    procedure setInkThreshold(const inkThreshold: IInkThreshold); safecall;
    procedure setStartImageData(encodingMode: Byte); safecall;
    procedure setImageDataBlock(imageDataBlock: PSafeArray); safecall;
    procedure setEndImageData; safecall;
    function getHandwritingThicknessColor: IHandwritingThicknessColor; safecall;
    procedure setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor); safecall;
    function getBackgroundColor: Word; safecall;
    procedure setBackgroundColor(backgroundColor: Word); safecall;
    function getHandwritingDisplayArea: IHandwritingDisplayArea; safecall;
    procedure setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea); safecall;
    function getBacklightBrightness: Word; safecall;
    procedure setBacklightBrightness(backlightBrightness: Word); safecall;
    function getPenDataOptionMode: Byte; safecall;
    procedure setPenDataOptionMode(penDataOptionMode: Byte); safecall;
    property Interface_: IInterface read Get_Interface_;
  end;

// *********************************************************************//
// DispIntf:  IProtocolDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003973-823A-4431-A479-3AA86D58A633}
// *********************************************************************//
  IProtocolDisp = dispinterface
    ['{20003973-823A-4431-A479-3AA86D58A633}']
    property Interface_: IInterface readonly dispid 2305;
    function getStatus: IStatus; dispid 2306;
    procedure setReset(resetFlag: Byte); dispid 2307;
    function getInformation: IInformation; dispid 2308;
    function getCapability: ICapability; dispid 2309;
    function getUid: SYSUINT; dispid 2310;
    procedure setUid(uid: SYSUINT); dispid 2311;
    function getHostPublicKey: {??PSafeArray}OleVariant; dispid 2312;
    procedure setHostPublicKey(publicKey: {??PSafeArray}OleVariant); dispid 2313;
    function getDevicePublicKey: {??PSafeArray}OleVariant; dispid 2314;
    procedure setStartCapture(sessionId: SYSUINT); dispid 2315;
    procedure setEndCapture; dispid 2316;
    function getDHprime: {??PSafeArray}OleVariant; dispid 2317;
    procedure setDHprime(dhPrime: {??PSafeArray}OleVariant); dispid 2318;
    function getDHbase: {??PSafeArray}OleVariant; dispid 2319;
    procedure setDHbase(dhBase: {??PSafeArray}OleVariant); dispid 2320;
    procedure setClearScreen; dispid 2321;
    function getInkingMode: Byte; dispid 2322;
    procedure setInkingMode(inkingMode: Byte); dispid 2323;
    function getInkThreshold: IInkThreshold; dispid 2324;
    procedure setInkThreshold(const inkThreshold: IInkThreshold); dispid 2325;
    procedure setStartImageData(encodingMode: Byte); dispid 2326;
    procedure setImageDataBlock(imageDataBlock: {??PSafeArray}OleVariant); dispid 2327;
    procedure setEndImageData; dispid 2328;
    function getHandwritingThicknessColor: IHandwritingThicknessColor; dispid 2329;
    procedure setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor); dispid 2330;
    function getBackgroundColor: {??Word}OleVariant; dispid 2331;
    procedure setBackgroundColor(backgroundColor: {??Word}OleVariant); dispid 2332;
    function getHandwritingDisplayArea: IHandwritingDisplayArea; dispid 2333;
    procedure setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea); dispid 2334;
    function getBacklightBrightness: {??Word}OleVariant; dispid 2335;
    procedure setBacklightBrightness(backlightBrightness: {??Word}OleVariant); dispid 2336;
    function getPenDataOptionMode: Byte; dispid 2337;
    procedure setPenDataOptionMode(penDataOptionMode: Byte); dispid 2338;
  end;

// *********************************************************************//
// Interface: IInterface
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200016D1-CBE2-4625-9F64-9685A2C09838}
// *********************************************************************//
  IInterface = interface(IDispatch)
    ['{200016D1-CBE2-4625-9F64-9685A2C09838}']
    procedure disconnect; safecall;
    function isConnected: WordBool; safecall;
    procedure get(data: PSafeArray); safecall;
    procedure set_(data: PSafeArray); safecall;
    function supportsWrite: WordBool; safecall;
    procedure write(data: PSafeArray); safecall;
    function interfaceQueue: IInterfaceQueue; safecall;
    procedure queueNotifyAll; safecall;
    function getReportCountLengths: PSafeArray; safecall;
    function Get_Protocol: IProtocol; safecall;
    property Protocol: IProtocol read Get_Protocol;
  end;

// *********************************************************************//
// DispIntf:  IInterfaceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200016D1-CBE2-4625-9F64-9685A2C09838}
// *********************************************************************//
  IInterfaceDisp = dispinterface
    ['{200016D1-CBE2-4625-9F64-9685A2C09838}']
    procedure disconnect; dispid 769;
    function isConnected: WordBool; dispid 770;
    procedure get(data: {??PSafeArray}OleVariant); dispid 771;
    procedure set_(data: {??PSafeArray}OleVariant); dispid 772;
    function supportsWrite: WordBool; dispid 773;
    procedure write(data: {??PSafeArray}OleVariant); dispid 774;
    function interfaceQueue: IInterfaceQueue; dispid 775;
    procedure queueNotifyAll; dispid 776;
    function getReportCountLengths: {??PSafeArray}OleVariant; dispid 777;
    property Protocol: IProtocol readonly dispid 778;
  end;

// *********************************************************************//
// Interface: IInterfaceQueue
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001FFA-3449-4592-8772-C7C00D46499B}
// *********************************************************************//
  IInterfaceQueue = interface(IDispatch)
    ['{20001FFA-3449-4592-8772-C7C00D46499B}']
    procedure clear; safecall;
    function empty: WordBool; safecall;
    procedure notify; safecall;
    procedure notifyAll; safecall;
    function tryGetReport(out report: PSafeArray): WordBool; safecall;
    function waitGetReportPredicate(const predicate: IPredicate): PSafeArray; safecall;
  end;

// *********************************************************************//
// DispIntf:  IInterfaceQueueDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001FFA-3449-4592-8772-C7C00D46499B}
// *********************************************************************//
  IInterfaceQueueDisp = dispinterface
    ['{20001FFA-3449-4592-8772-C7C00D46499B}']
    procedure clear; dispid 513;
    function empty: WordBool; dispid 514;
    procedure notify; dispid 515;
    procedure notifyAll; dispid 516;
    function tryGetReport(out report: {??PSafeArray}OleVariant): WordBool; dispid 517;
    function waitGetReportPredicate(const predicate: IPredicate): {??PSafeArray}OleVariant; dispid 518;
  end;

// *********************************************************************//
// Interface: IPredicate
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20008863-5B2A-40BE-8E69-4D2F20303732}
// *********************************************************************//
  IPredicate = interface(IDispatch)
    ['{20008863-5B2A-40BE-8E69-4D2F20303732}']
    function predicate: WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IPredicateDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20008863-5B2A-40BE-8E69-4D2F20303732}
// *********************************************************************//
  IPredicateDisp = dispinterface
    ['{20008863-5B2A-40BE-8E69-4D2F20303732}']
    function predicate: WordBool; dispid 257;
  end;

// *********************************************************************//
// Interface: IStatus
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000F706-6451-4F84-BA53-EA90D9BD52DB}
// *********************************************************************//
  IStatus = interface(IDispatch)
    ['{2000F706-6451-4F84-BA53-EA90D9BD52DB}']
    function Get_statusCode: Byte; safecall;
    function Get_lastResultCode: Byte; safecall;
    function Get_statusWord: Word; safecall;
    property statusCode: Byte read Get_statusCode;
    property lastResultCode: Byte read Get_lastResultCode;
    property statusWord: Word read Get_statusWord;
  end;

// *********************************************************************//
// DispIntf:  IStatusDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000F706-6451-4F84-BA53-EA90D9BD52DB}
// *********************************************************************//
  IStatusDisp = dispinterface
    ['{2000F706-6451-4F84-BA53-EA90D9BD52DB}']
    property statusCode: Byte readonly dispid 2561;
    property lastResultCode: Byte readonly dispid 2562;
    property statusWord: {??Word}OleVariant readonly dispid 2563;
  end;

// *********************************************************************//
// Interface: IInformation
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200021D5-E224-4C70-A8CB-A62E90183DA9}
// *********************************************************************//
  IInformation = interface(IDispatch)
    ['{200021D5-E224-4C70-A8CB-A62E90183DA9}']
    function Get_modelName: WideString; safecall;
    function Get_firmwareMajorVersion: Byte; safecall;
    function Get_firmwareMinorVersion: Byte; safecall;
    function Get_secureIc: Byte; safecall;
    function Get_secureIcVersion: SYSUINT; safecall;
    property modelName: WideString read Get_modelName;
    property firmwareMajorVersion: Byte read Get_firmwareMajorVersion;
    property firmwareMinorVersion: Byte read Get_firmwareMinorVersion;
    property secureIc: Byte read Get_secureIc;
    property secureIcVersion: SYSUINT read Get_secureIcVersion;
  end;

// *********************************************************************//
// DispIntf:  IInformationDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200021D5-E224-4C70-A8CB-A62E90183DA9}
// *********************************************************************//
  IInformationDisp = dispinterface
    ['{200021D5-E224-4C70-A8CB-A62E90183DA9}']
    property modelName: WideString readonly dispid 2817;
    property firmwareMajorVersion: Byte readonly dispid 2818;
    property firmwareMinorVersion: Byte readonly dispid 2819;
    property secureIc: Byte readonly dispid 2820;
    property secureIcVersion: SYSUINT readonly dispid 2821;
  end;

// *********************************************************************//
// Interface: ICapability
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200028BD-1A2E-4C77-BEBB-EBEF8989EFEA}
// *********************************************************************//
  ICapability = interface(IDispatch)
    ['{200028BD-1A2E-4C77-BEBB-EBEF8989EFEA}']
    function Get_tabletMaxX: Word; safecall;
    function Get_tabletMaxY: Word; safecall;
    function Get_tabletMaxPressure: Word; safecall;
    function Get_screenWidth: Word; safecall;
    function Get_screenHeight: Word; safecall;
    function Get_maxReportRate: Byte; safecall;
    function Get_resolution: Word; safecall;
    function Get_zlibColorSupport: Byte; safecall;
    property tabletMaxX: Word read Get_tabletMaxX;
    property tabletMaxY: Word read Get_tabletMaxY;
    property tabletMaxPressure: Word read Get_tabletMaxPressure;
    property screenWidth: Word read Get_screenWidth;
    property screenHeight: Word read Get_screenHeight;
    property maxReportRate: Byte read Get_maxReportRate;
    property resolution: Word read Get_resolution;
    property zlibColorSupport: Byte read Get_zlibColorSupport;
  end;

// *********************************************************************//
// DispIntf:  ICapabilityDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200028BD-1A2E-4C77-BEBB-EBEF8989EFEA}
// *********************************************************************//
  ICapabilityDisp = dispinterface
    ['{200028BD-1A2E-4C77-BEBB-EBEF8989EFEA}']
    property tabletMaxX: {??Word}OleVariant readonly dispid 3073;
    property tabletMaxY: {??Word}OleVariant readonly dispid 3074;
    property tabletMaxPressure: {??Word}OleVariant readonly dispid 3075;
    property screenWidth: {??Word}OleVariant readonly dispid 3076;
    property screenHeight: {??Word}OleVariant readonly dispid 3077;
    property maxReportRate: Byte readonly dispid 3078;
    property resolution: {??Word}OleVariant readonly dispid 3079;
    property zlibColorSupport: Byte readonly dispid 3080;
  end;

// *********************************************************************//
// Interface: IInkThreshold
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003425-E218-45D6-B3E2-961C74364617}
// *********************************************************************//
  IInkThreshold = interface(IDispatch)
    ['{20003425-E218-45D6-B3E2-961C74364617}']
    procedure Set_onPressureMark(pRetVal: Word); safecall;
    function Get_onPressureMark: Word; safecall;
    procedure Set_offPressureMark(pRetVal: Word); safecall;
    function Get_offPressureMark: Word; safecall;
    property onPressureMark: Word read Get_onPressureMark write Set_onPressureMark;
    property offPressureMark: Word read Get_offPressureMark write Set_offPressureMark;
  end;

// *********************************************************************//
// DispIntf:  IInkThresholdDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003425-E218-45D6-B3E2-961C74364617}
// *********************************************************************//
  IInkThresholdDisp = dispinterface
    ['{20003425-E218-45D6-B3E2-961C74364617}']
    property onPressureMark: {??Word}OleVariant dispid 4353;
    property offPressureMark: {??Word}OleVariant dispid 4354;
  end;

// *********************************************************************//
// Interface: IHandwritingThicknessColor
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20004323-9CF7-4375-B7C3-DEFDF8588FAD}
// *********************************************************************//
  IHandwritingThicknessColor = interface(IDispatch)
    ['{20004323-9CF7-4375-B7C3-DEFDF8588FAD}']
    procedure Set_penColor(pRetVal: Word); safecall;
    function Get_penColor: Word; safecall;
    procedure Set_penThickness(pRetVal: Byte); safecall;
    function Get_penThickness: Byte; safecall;
    property penColor: Word read Get_penColor write Set_penColor;
    property penThickness: Byte read Get_penThickness write Set_penThickness;
  end;

// *********************************************************************//
// DispIntf:  IHandwritingThicknessColorDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20004323-9CF7-4375-B7C3-DEFDF8588FAD}
// *********************************************************************//
  IHandwritingThicknessColorDisp = dispinterface
    ['{20004323-9CF7-4375-B7C3-DEFDF8588FAD}']
    property penColor: {??Word}OleVariant dispid 4609;
    property penThickness: Byte dispid 4610;
  end;

// *********************************************************************//
// Interface: IHandwritingDisplayArea
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000518C-05F0-4D88-B867-C5C9D58C04C5}
// *********************************************************************//
  IHandwritingDisplayArea = interface(IDispatch)
    ['{2000518C-05F0-4D88-B867-C5C9D58C04C5}']
    procedure Set_upperLeftXPixel(pRetVal: Word); safecall;
    function Get_upperLeftXPixel: Word; safecall;
    procedure Set_upperLeftYPixel(pRetVal: Word); safecall;
    function Get_upperLeftYPixel: Word; safecall;
    procedure Set_lowerRightXPixel(pRetVal: Word); safecall;
    function Get_lowerRightXPixel: Word; safecall;
    procedure Set_lowerRightYPixel(pRetVal: Word); safecall;
    function Get_lowerRightYPixel: Word; safecall;
    property upperLeftXPixel: Word read Get_upperLeftXPixel write Set_upperLeftXPixel;
    property upperLeftYPixel: Word read Get_upperLeftYPixel write Set_upperLeftYPixel;
    property lowerRightXPixel: Word read Get_lowerRightXPixel write Set_lowerRightXPixel;
    property lowerRightYPixel: Word read Get_lowerRightYPixel write Set_lowerRightYPixel;
  end;

// *********************************************************************//
// DispIntf:  IHandwritingDisplayAreaDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000518C-05F0-4D88-B867-C5C9D58C04C5}
// *********************************************************************//
  IHandwritingDisplayAreaDisp = dispinterface
    ['{2000518C-05F0-4D88-B867-C5C9D58C04C5}']
    property upperLeftXPixel: {??Word}OleVariant dispid 4865;
    property upperLeftYPixel: {??Word}OleVariant dispid 4866;
    property lowerRightXPixel: {??Word}OleVariant dispid 4867;
    property lowerRightYPixel: {??Word}OleVariant dispid 4868;
  end;

// *********************************************************************//
// Interface: IUsbDevice
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20006935-F639-4B1E-845F-5B6A6E590E7F}
// *********************************************************************//
  IUsbDevice = interface(IDispatch)
    ['{20006935-F639-4B1E-845F-5B6A6E590E7F}']
    function Get_idVendor: Word; safecall;
    function Get_idProduct: Word; safecall;
    function Get_bcdDevice: Word; safecall;
    function Get_fileName: WideString; safecall;
    function Get_bulkFileName: WideString; safecall;
    property idVendor: Word read Get_idVendor;
    property idProduct: Word read Get_idProduct;
    property bcdDevice: Word read Get_bcdDevice;
    property fileName: WideString read Get_fileName;
    property bulkFileName: WideString read Get_bulkFileName;
  end;

// *********************************************************************//
// DispIntf:  IUsbDeviceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20006935-F639-4B1E-845F-5B6A6E590E7F}
// *********************************************************************//
  IUsbDeviceDisp = dispinterface
    ['{20006935-F639-4B1E-845F-5B6A6E590E7F}']
    property idVendor: {??Word}OleVariant readonly dispid 2049;
    property idProduct: {??Word}OleVariant readonly dispid 2050;
    property bcdDevice: {??Word}OleVariant readonly dispid 2051;
    property fileName: WideString readonly dispid 2052;
    property bulkFileName: WideString readonly dispid 2053;
  end;

// *********************************************************************//
// Interface: IUsbDevices
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20008CC2-6576-4665-8411-99291CF18387}
// *********************************************************************//
  IUsbDevices = interface(IDispatch)
    ['{20008CC2-6576-4665-8411-99291CF18387}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(index: OleVariant): IUsbDevice; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[index: OleVariant]: IUsbDevice read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IUsbDevicesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20008CC2-6576-4665-8411-99291CF18387}
// *********************************************************************//
  IUsbDevicesDisp = dispinterface
    ['{20008CC2-6576-4665-8411-99291CF18387}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[index: OleVariant]: IUsbDevice readonly dispid 0; default;
    property Count: Integer readonly dispid 1793;
  end;

// *********************************************************************//
// Interface: IErrorCode
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001A79-3839-4E67-9855-075A7312AA0D}
// *********************************************************************//
  IErrorCode = interface(IDispatch)
    ['{20001A79-3839-4E67-9855-075A7312AA0D}']
    function Get_value: SYSINT; safecall;
    function Get_category: WideString; safecall;
    function Get_message: WideString; safecall;
    property value: SYSINT read Get_value;
    property category: WideString read Get_category;
    property message: WideString read Get_message;
  end;

// *********************************************************************//
// DispIntf:  IErrorCodeDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001A79-3839-4E67-9855-075A7312AA0D}
// *********************************************************************//
  IErrorCodeDisp = dispinterface
    ['{20001A79-3839-4E67-9855-075A7312AA0D}']
    property value: SYSINT readonly dispid 0;
    property category: WideString readonly dispid 7681;
    property message: WideString readonly dispid 7682;
  end;

// *********************************************************************//
// Interface: IUsbInterface
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000C1D7-8270-490B-A8F3-766258E6BAB9}
// *********************************************************************//
  IUsbInterface = interface(IInterface)
    ['{2000C1D7-8270-490B-A8F3-766258E6BAB9}']
    function connect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode; safecall;
    function connect2(const fileName: WideString; const bulkFileName: WideString; 
                      exclusiveLock: WordBool): IErrorCode; safecall;
  end;

// *********************************************************************//
// DispIntf:  IUsbInterfaceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000C1D7-8270-490B-A8F3-766258E6BAB9}
// *********************************************************************//
  IUsbInterfaceDisp = dispinterface
    ['{2000C1D7-8270-490B-A8F3-766258E6BAB9}']
    function connect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode; dispid 1025;
    function connect2(const fileName: WideString; const bulkFileName: WideString; 
                      exclusiveLock: WordBool): IErrorCode; dispid 1026;
    procedure disconnect; dispid 769;
    function isConnected: WordBool; dispid 770;
    procedure get(data: {??PSafeArray}OleVariant); dispid 771;
    procedure set_(data: {??PSafeArray}OleVariant); dispid 772;
    function supportsWrite: WordBool; dispid 773;
    procedure write(data: {??PSafeArray}OleVariant); dispid 774;
    function interfaceQueue: IInterfaceQueue; dispid 775;
    procedure queueNotifyAll; dispid 776;
    function getReportCountLengths: {??PSafeArray}OleVariant; dispid 777;
    property Protocol: IProtocol readonly dispid 778;
  end;

// *********************************************************************//
// Interface: ISerialInterface
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003D0C-A047-4487-8FE0-0CF9AB05E48C}
// *********************************************************************//
  ISerialInterface = interface(IInterface)
    ['{20003D0C-A047-4487-8FE0-0CF9AB05E48C}']
    function connect(const fileName: WideString; useCrc: WordBool): IErrorCode; safecall;
  end;

// *********************************************************************//
// DispIntf:  ISerialInterfaceDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003D0C-A047-4487-8FE0-0CF9AB05E48C}
// *********************************************************************//
  ISerialInterfaceDisp = dispinterface
    ['{20003D0C-A047-4487-8FE0-0CF9AB05E48C}']
    function connect(const fileName: WideString; useCrc: WordBool): IErrorCode; dispid 5889;
    procedure disconnect; dispid 769;
    function isConnected: WordBool; dispid 770;
    procedure get(data: {??PSafeArray}OleVariant); dispid 771;
    procedure set_(data: {??PSafeArray}OleVariant); dispid 772;
    function supportsWrite: WordBool; dispid 773;
    procedure write(data: {??PSafeArray}OleVariant); dispid 774;
    function interfaceQueue: IInterfaceQueue; dispid 775;
    procedure queueNotifyAll; dispid 776;
    function getReportCountLengths: {??PSafeArray}OleVariant; dispid 777;
    property Protocol: IProtocol readonly dispid 778;
  end;

// *********************************************************************//
// Interface: IPenData
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003BCE-8DD9-43AD-819B-F746171CA1EC}
// *********************************************************************//
  IPenData = interface(IDispatch)
    ['{20003BCE-8DD9-43AD-819B-F746171CA1EC}']
    function Get_rdy: WordBool; safecall;
    function Get_sw: Byte; safecall;
    function Get_pressure: Word; safecall;
    function Get_x: Word; safecall;
    function Get_y: Word; safecall;
    property rdy: WordBool read Get_rdy;
    property sw: Byte read Get_sw;
    property pressure: Word read Get_pressure;
    property x: Word read Get_x;
    property y: Word read Get_y;
  end;

// *********************************************************************//
// DispIntf:  IPenDataDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20003BCE-8DD9-43AD-819B-F746171CA1EC}
// *********************************************************************//
  IPenDataDisp = dispinterface
    ['{20003BCE-8DD9-43AD-819B-F746171CA1EC}']
    property rdy: WordBool readonly dispid 3329;
    property sw: Byte readonly dispid 3330;
    property pressure: {??Word}OleVariant readonly dispid 3331;
    property x: {??Word}OleVariant readonly dispid 3332;
    property y: {??Word}OleVariant readonly dispid 3333;
  end;

// *********************************************************************//
// Interface: IPenDataOption
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200041E8-CBEC-4414-A64D-B6600A4D3FF6}
// *********************************************************************//
  IPenDataOption = interface(IPenData)
    ['{200041E8-CBEC-4414-A64D-B6600A4D3FF6}']
    function Get_option: Word; safecall;
    property option: Word read Get_option;
  end;

// *********************************************************************//
// DispIntf:  IPenDataOptionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200041E8-CBEC-4414-A64D-B6600A4D3FF6}
// *********************************************************************//
  IPenDataOptionDisp = dispinterface
    ['{200041E8-CBEC-4414-A64D-B6600A4D3FF6}']
    property option: {??Word}OleVariant readonly dispid 3585;
    property rdy: WordBool readonly dispid 3329;
    property sw: Byte readonly dispid 3330;
    property pressure: {??Word}OleVariant readonly dispid 3331;
    property x: {??Word}OleVariant readonly dispid 3332;
    property y: {??Word}OleVariant readonly dispid 3333;
  end;

// *********************************************************************//
// Interface: IPenDataEncrypted
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20007929-8A2A-49DF-8B6D-38B71F8991AB}
// *********************************************************************//
  IPenDataEncrypted = interface(IDispatch)
    ['{20007929-8A2A-49DF-8B6D-38B71F8991AB}']
    function Get_sessionId: SYSUINT; safecall;
    function Get_penData1: IPenData; safecall;
    function Get_penData2: IPenData; safecall;
    property sessionId: SYSUINT read Get_sessionId;
    property penData1: IPenData read Get_penData1;
    property penData2: IPenData read Get_penData2;
  end;

// *********************************************************************//
// DispIntf:  IPenDataEncryptedDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20007929-8A2A-49DF-8B6D-38B71F8991AB}
// *********************************************************************//
  IPenDataEncryptedDisp = dispinterface
    ['{20007929-8A2A-49DF-8B6D-38B71F8991AB}']
    property sessionId: SYSUINT readonly dispid 3841;
    property penData1: IPenData readonly dispid 3842;
    property penData2: IPenData readonly dispid 3843;
  end;

// *********************************************************************//
// Interface: IPenDataEncryptedOption
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200088A2-DC76-4716-8879-6E6115A1BBE8}
// *********************************************************************//
  IPenDataEncryptedOption = interface(IPenDataEncrypted)
    ['{200088A2-DC76-4716-8879-6E6115A1BBE8}']
    function Get_option1: Word; safecall;
    function Get_option2: Word; safecall;
    property option1: Word read Get_option1;
    property option2: Word read Get_option2;
  end;

// *********************************************************************//
// DispIntf:  IPenDataEncryptedOptionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200088A2-DC76-4716-8879-6E6115A1BBE8}
// *********************************************************************//
  IPenDataEncryptedOptionDisp = dispinterface
    ['{200088A2-DC76-4716-8879-6E6115A1BBE8}']
    property option1: {??Word}OleVariant readonly dispid 4097;
    property option2: {??Word}OleVariant readonly dispid 4098;
    property sessionId: SYSUINT readonly dispid 3841;
    property penData1: IPenData readonly dispid 3842;
    property penData2: IPenData readonly dispid 3843;
  end;

// *********************************************************************//
// Interface: IProtocolHelper
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000550B-EFC5-4D5F-8969-45C9A67CC93C}
// *********************************************************************//
  IProtocolHelper = interface(IDispatch)
    ['{2000550B-EFC5-4D5F-8969-45C9A67CC93C}']
    function statusCanSend(statusCode: Byte; ReportId: Byte; OpDirection: OpDirection): WordBool; safecall;
    procedure waitForStatusToSend(const Protocol: IProtocol; ReportId: Byte; 
                                  OpDirection: OpDirection; retries: SYSUINT; 
                                  sleepBetweenRetries: SYSUINT); safecall;
    procedure waitForStatus(const Protocol: IProtocol; statusCode: Byte; retries: SYSUINT; 
                            sleepBetweenRetries: SYSUINT); safecall;
    function supportsEncryption(const Protocol: IProtocol): WordBool; safecall;
    function supportsEncryption_DHprime(dhPrime: PSafeArray): WordBool; safecall;
    function setHostPublicKeyAndPollForDevicePublicKey(const Protocol: IProtocol; 
                                                       hostPublicKey: PSafeArray; retries: SYSUINT; 
                                                       sleepBetweenRetries: SYSUINT): PSafeArray; safecall;
    procedure writeImage(const Protocol: IProtocol; encodingMode: Byte; imageData: PSafeArray; 
                         retries: SYSUINT; sleepBetweenRetries: SYSUINT); safecall;
    function flattenMonochrome(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray; safecall;
    function flattenColor16_565(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray; safecall;
    function flatten(image: OleVariant; screenWidth: Word; screenHeight: Word; isColor: WordBool): PSafeArray; safecall;
    function resizeAndFlatten(image: OleVariant; offsetX: SYSUINT; offsetY: SYSUINT; 
                              bitmapWidth: SYSUINT; bitmapHeight: SYSUINT; screenWidth: Word; 
                              screenHeight: Word; isColor: WordBool; Scale: Scale; 
                              backgroundColor: OleVariant; Clip: Byte): PSafeArray; safecall;
  end;

// *********************************************************************//
// DispIntf:  IProtocolHelperDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000550B-EFC5-4D5F-8969-45C9A67CC93C}
// *********************************************************************//
  IProtocolHelperDisp = dispinterface
    ['{2000550B-EFC5-4D5F-8969-45C9A67CC93C}']
    function statusCanSend(statusCode: Byte; ReportId: Byte; OpDirection: OpDirection): WordBool; dispid 6145;
    procedure waitForStatusToSend(const Protocol: IProtocol; ReportId: Byte; 
                                  OpDirection: OpDirection; retries: SYSUINT; 
                                  sleepBetweenRetries: SYSUINT); dispid 6146;
    procedure waitForStatus(const Protocol: IProtocol; statusCode: Byte; retries: SYSUINT; 
                            sleepBetweenRetries: SYSUINT); dispid 6147;
    function supportsEncryption(const Protocol: IProtocol): WordBool; dispid 6148;
    function supportsEncryption_DHprime(dhPrime: {??PSafeArray}OleVariant): WordBool; dispid 6149;
    function setHostPublicKeyAndPollForDevicePublicKey(const Protocol: IProtocol; 
                                                       hostPublicKey: {??PSafeArray}OleVariant; 
                                                       retries: SYSUINT; 
                                                       sleepBetweenRetries: SYSUINT): {??PSafeArray}OleVariant; dispid 6150;
    procedure writeImage(const Protocol: IProtocol; encodingMode: Byte; 
                         imageData: {??PSafeArray}OleVariant; retries: SYSUINT; 
                         sleepBetweenRetries: SYSUINT); dispid 6152;
    function flattenMonochrome(image: OleVariant; screenWidth: {??Word}OleVariant; 
                               screenHeight: {??Word}OleVariant): {??PSafeArray}OleVariant; dispid 6153;
    function flattenColor16_565(image: OleVariant; screenWidth: {??Word}OleVariant; 
                                screenHeight: {??Word}OleVariant): {??PSafeArray}OleVariant; dispid 6154;
    function flatten(image: OleVariant; screenWidth: {??Word}OleVariant; 
                     screenHeight: {??Word}OleVariant; isColor: WordBool): {??PSafeArray}OleVariant; dispid 6155;
    function resizeAndFlatten(image: OleVariant; offsetX: SYSUINT; offsetY: SYSUINT; 
                              bitmapWidth: SYSUINT; bitmapHeight: SYSUINT; 
                              screenWidth: {??Word}OleVariant; screenHeight: {??Word}OleVariant; 
                              isColor: WordBool; Scale: Scale; backgroundColor: OleVariant; 
                              Clip: Byte): {??PSafeArray}OleVariant; dispid 6156;
  end;

// *********************************************************************//
// Interface: IReport
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000122F-B55F-40DE-9284-277D32AEE77F}
// *********************************************************************//
  IReport = interface(IDispatch)
    ['{2000122F-B55F-40DE-9284-277D32AEE77F}']
    function Get_data: PSafeArray; safecall;
    property data: PSafeArray read Get_data;
  end;

// *********************************************************************//
// DispIntf:  IReportDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000122F-B55F-40DE-9284-277D32AEE77F}
// *********************************************************************//
  IReportDisp = dispinterface
    ['{2000122F-B55F-40DE-9284-277D32AEE77F}']
    property data: {??PSafeArray}OleVariant readonly dispid 1281;
  end;

// *********************************************************************//
// Interface: IDecrypt
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20007FDA-B1C5-44F2-A8F8-AFCD4E6A76C2}
// *********************************************************************//
  IDecrypt = interface(IDispatch)
    ['{20007FDA-B1C5-44F2-A8F8-AFCD4E6A76C2}']
    function Get_data: PSafeArray; safecall;
    procedure Set_data(pRetVal: PSafeArray); safecall;
    property data: PSafeArray read Get_data write Set_data;
  end;

// *********************************************************************//
// DispIntf:  IDecryptDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20007FDA-B1C5-44F2-A8F8-AFCD4E6A76C2}
// *********************************************************************//
  IDecryptDisp = dispinterface
    ['{20007FDA-B1C5-44F2-A8F8-AFCD4E6A76C2}']
    property data: {??PSafeArray}OleVariant dispid 5633;
  end;

// *********************************************************************//
// Interface: IReportHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000446E-736E-4513-9751-A9B69648863E}
// *********************************************************************//
  IReportHandler = interface(IDispatch)
    ['{2000446E-736E-4513-9751-A9B69648863E}']
    function handleReport(data: PSafeArray): WordBool; safecall;
  end;

// *********************************************************************//
// DispIntf:  IReportHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000446E-736E-4513-9751-A9B69648863E}
// *********************************************************************//
  IReportHandlerDisp = dispinterface
    ['{2000446E-736E-4513-9751-A9B69648863E}']
    function handleReport(data: {??PSafeArray}OleVariant): WordBool; dispid 5121;
  end;

// *********************************************************************//
// Interface: ITabletEncryptionHandler
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000B2ED-AEDA-4E86-8A69-BB987FA3B238}
// *********************************************************************//
  ITabletEncryptionHandler = interface(IDispatch)
    ['{2000B2ED-AEDA-4E86-8A69-BB987FA3B238}']
    procedure reset; safecall;
    procedure clearKeys; safecall;
    function requireDH: WordBool; safecall;
    procedure setDH(dhPrime: PSafeArray; dhBase: PSafeArray); safecall;
    function generateHostPublicKey: PSafeArray; safecall;
    procedure computeSharedKey(devicePublicKey: PSafeArray); safecall;
    function decrypt(data: PSafeArray): PSafeArray; safecall;
  end;

// *********************************************************************//
// DispIntf:  ITabletEncryptionHandlerDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000B2ED-AEDA-4E86-8A69-BB987FA3B238}
// *********************************************************************//
  ITabletEncryptionHandlerDisp = dispinterface
    ['{2000B2ED-AEDA-4E86-8A69-BB987FA3B238}']
    procedure reset; dispid 7169;
    procedure clearKeys; dispid 7170;
    function requireDH: WordBool; dispid 7171;
    procedure setDH(dhPrime: {??PSafeArray}OleVariant; dhBase: {??PSafeArray}OleVariant); dispid 7172;
    function generateHostPublicKey: {??PSafeArray}OleVariant; dispid 7173;
    procedure computeSharedKey(devicePublicKey: {??PSafeArray}OleVariant); dispid 7174;
    function decrypt(data: {??PSafeArray}OleVariant): {??PSafeArray}OleVariant; dispid 7175;
  end;

// *********************************************************************//
// Interface: ITablet
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005C27-7729-492F-8106-540F2E04DC66}
// *********************************************************************//
  ITablet = interface(IDispatch)
    ['{20005C27-7729-492F-8106-540F2E04DC66}']
    function Get_encryptionHandler: ITabletEncryptionHandler; safecall;
    procedure Set_encryptionHandler(const pRetVal: ITabletEncryptionHandler); safecall;
    function usbConnect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode; safecall;
    function usbConnect2(const fileName: WideString; const bulkFileName: WideString; 
                         exclusiveLock: WordBool): IErrorCode; safecall;
    function serialConnect(const fileName: WideString; useCrc: WordBool): IErrorCode; safecall;
    function Get_Protocol: IProtocol; safecall;
    function isEmpty: WordBool; safecall;
    function isConnected: WordBool; safecall;
    procedure disconnect; safecall;
    function interfaceQueue: IInterfaceQueue; safecall;
    procedure queueNotifyAll; safecall;
    function supportsWrite: WordBool; safecall;
    procedure getReportCountLengths(var pRetVal: PSafeArray); safecall;
    procedure isSupported(ReportId: Byte; var pRetVal: WordBool); safecall;
    function getStatus: IStatus; safecall;
    procedure reset; safecall;
    function getInformation: IInformation; safecall;
    function getCapability: ICapability; safecall;
    function getUid: SYSUINT; safecall;
    procedure setUid(uid: SYSUINT); safecall;
    function getHostPublicKey: PSafeArray; safecall;
    function getDevicePublicKey: PSafeArray; safecall;
    procedure startCapture(sessionId: SYSUINT); safecall;
    procedure endCapture; safecall;
    function getDHprime: PSafeArray; safecall;
    procedure setDHprime(dhPrime: PSafeArray); safecall;
    function getDHbase: PSafeArray; safecall;
    procedure setDHbase(dhBase: PSafeArray); safecall;
    procedure setClearScreen; safecall;
    function getInkingMode: Byte; safecall;
    procedure setInkingMode(inkingMode: Byte); safecall;
    function getInkThreshold: IInkThreshold; safecall;
    procedure setInkThreshold(const inkThreshold: IInkThreshold); safecall;
    procedure writeImage(encodingMode: Byte; imageData: PSafeArray); safecall;
    procedure endImageData; safecall;
    function getHandwritingThicknessColor: IHandwritingThicknessColor; safecall;
    procedure setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor); safecall;
    function getBackgroundColor: Word; safecall;
    procedure setBackgroundColor(backgroundColor: Word); safecall;
    function getHandwritingDisplayArea: IHandwritingDisplayArea; safecall;
    procedure setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea); safecall;
    function getBacklightBrightness: Word; safecall;
    procedure setBacklightBrightness(backlightBrightness: Word); safecall;
    function getPenDataOptionMode: Byte; safecall;
    procedure setPenDataOptionMode(penDataOptionMode: Byte); safecall;
    property encryptionHandler: ITabletEncryptionHandler read Get_encryptionHandler write Set_encryptionHandler;
    property Protocol: IProtocol read Get_Protocol;
  end;

// *********************************************************************//
// DispIntf:  ITabletDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005C27-7729-492F-8106-540F2E04DC66}
// *********************************************************************//
  ITabletDisp = dispinterface
    ['{20005C27-7729-492F-8106-540F2E04DC66}']
    property encryptionHandler: ITabletEncryptionHandler dispid 6657;
    function usbConnect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode; dispid 6658;
    function usbConnect2(const fileName: WideString; const bulkFileName: WideString; 
                         exclusiveLock: WordBool): IErrorCode; dispid 6659;
    function serialConnect(const fileName: WideString; useCrc: WordBool): IErrorCode; dispid 6660;
    property Protocol: IProtocol readonly dispid 6661;
    function isEmpty: WordBool; dispid 6662;
    function isConnected: WordBool; dispid 6663;
    procedure disconnect; dispid 6664;
    function interfaceQueue: IInterfaceQueue; dispid 6665;
    procedure queueNotifyAll; dispid 6666;
    function supportsWrite: WordBool; dispid 6667;
    procedure getReportCountLengths(var pRetVal: {??PSafeArray}OleVariant); dispid 6668;
    procedure isSupported(ReportId: Byte; var pRetVal: WordBool); dispid 6669;
    function getStatus: IStatus; dispid 6670;
    procedure reset; dispid 6671;
    function getInformation: IInformation; dispid 6672;
    function getCapability: ICapability; dispid 6673;
    function getUid: SYSUINT; dispid 6674;
    procedure setUid(uid: SYSUINT); dispid 6675;
    function getHostPublicKey: {??PSafeArray}OleVariant; dispid 6676;
    function getDevicePublicKey: {??PSafeArray}OleVariant; dispid 6677;
    procedure startCapture(sessionId: SYSUINT); dispid 6678;
    procedure endCapture; dispid 6679;
    function getDHprime: {??PSafeArray}OleVariant; dispid 6680;
    procedure setDHprime(dhPrime: {??PSafeArray}OleVariant); dispid 6681;
    function getDHbase: {??PSafeArray}OleVariant; dispid 6682;
    procedure setDHbase(dhBase: {??PSafeArray}OleVariant); dispid 6683;
    procedure setClearScreen; dispid 6684;
    function getInkingMode: Byte; dispid 6685;
    procedure setInkingMode(inkingMode: Byte); dispid 6686;
    function getInkThreshold: IInkThreshold; dispid 6687;
    procedure setInkThreshold(const inkThreshold: IInkThreshold); dispid 6688;
    procedure writeImage(encodingMode: Byte; imageData: {??PSafeArray}OleVariant); dispid 6689;
    procedure endImageData; dispid 6690;
    function getHandwritingThicknessColor: IHandwritingThicknessColor; dispid 6691;
    procedure setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor); dispid 6692;
    function getBackgroundColor: {??Word}OleVariant; dispid 6693;
    procedure setBackgroundColor(backgroundColor: {??Word}OleVariant); dispid 6694;
    function getHandwritingDisplayArea: IHandwritingDisplayArea; dispid 6695;
    procedure setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea); dispid 6696;
    function getBacklightBrightness: {??Word}OleVariant; dispid 6697;
    procedure setBacklightBrightness(backlightBrightness: {??Word}OleVariant); dispid 6698;
    function getPenDataOptionMode: Byte; dispid 6699;
    procedure setPenDataOptionMode(penDataOptionMode: Byte); dispid 6700;
  end;

// *********************************************************************//
// Interface: IJScript
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}
// *********************************************************************//
  IJScript = interface(IDispatch)
    ['{200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}']
    function toArray(value: PSafeArray): IDispatch; safecall;
    function toVBArray(const value: IDispatch): PSafeArray; safecall;
    function toTabletEncryptionHandler(const value: IDispatch): ITabletEncryptionHandler; safecall;
  end;

// *********************************************************************//
// DispIntf:  IJScriptDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}
// *********************************************************************//
  IJScriptDisp = dispinterface
    ['{200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}']
    function toArray(value: {??PSafeArray}OleVariant): IDispatch; dispid 6401;
    function toVBArray(const value: IDispatch): {??PSafeArray}OleVariant; dispid 6402;
    function toTabletEncryptionHandler(const value: IDispatch): ITabletEncryptionHandler; dispid 6403;
  end;

// *********************************************************************//
// Interface: IComponentFile
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005C8A-5280-4C4D-8565-DED24A3672F5}
// *********************************************************************//
  IComponentFile = interface(IDispatch)
    ['{20005C8A-5280-4C4D-8565-DED24A3672F5}']
    function Get_name: WideString; safecall;
    function Get_version: WideString; safecall;
    property name: WideString read Get_name;
    property version: WideString read Get_version;
  end;

// *********************************************************************//
// DispIntf:  IComponentFileDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005C8A-5280-4C4D-8565-DED24A3672F5}
// *********************************************************************//
  IComponentFileDisp = dispinterface
    ['{20005C8A-5280-4C4D-8565-DED24A3672F5}']
    property name: WideString readonly dispid 8449;
    property version: WideString readonly dispid 8450;
  end;

// *********************************************************************//
// Interface: IComponentFiles
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000A6E2-D773-4829-9B61-78DAC3CCAD82}
// *********************************************************************//
  IComponentFiles = interface(IDispatch)
    ['{2000A6E2-D773-4829-9B61-78DAC3CCAD82}']
    function Get__NewEnum: IUnknown; safecall;
    function Get_Item(index: OleVariant): IComponentFile; safecall;
    function Get_Count: Integer; safecall;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[index: OleVariant]: IComponentFile read Get_Item; default;
    property Count: Integer read Get_Count;
  end;

// *********************************************************************//
// DispIntf:  IComponentFilesDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {2000A6E2-D773-4829-9B61-78DAC3CCAD82}
// *********************************************************************//
  IComponentFilesDisp = dispinterface
    ['{2000A6E2-D773-4829-9B61-78DAC3CCAD82}']
    property _NewEnum: IUnknown readonly dispid -4;
    property Item[index: OleVariant]: IComponentFile readonly dispid 0; default;
    property Count: Integer readonly dispid 8193;
  end;

// *********************************************************************//
// Interface: IComponent
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001D33-3D2C-4E4D-AFE8-5E5D446637FD}
// *********************************************************************//
  IComponent = interface(IDispatch)
    ['{20001D33-3D2C-4E4D-AFE8-5E5D446637FD}']
    function getProperty(const name: WideString): OleVariant; safecall;
    procedure setProperty(const name: WideString; value: OleVariant); safecall;
    function componentFiles: IComponentFiles; safecall;
    function diagnosticInformation(flag: SYSUINT): WideString; safecall;
  end;

// *********************************************************************//
// DispIntf:  IComponentDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20001D33-3D2C-4E4D-AFE8-5E5D446637FD}
// *********************************************************************//
  IComponentDisp = dispinterface
    ['{20001D33-3D2C-4E4D-AFE8-5E5D446637FD}']
    function getProperty(const name: WideString): OleVariant; dispid 7937;
    procedure setProperty(const name: WideString; value: OleVariant); dispid 7938;
    function componentFiles: IComponentFiles; dispid 7939;
    function diagnosticInformation(flag: SYSUINT): WideString; dispid 7940;
  end;

// *********************************************************************//
// DispIntf:  IInterfaceEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {2000A1EE-8F0B-4027-B84E-A8172950CF0C}
// *********************************************************************//
  IInterfaceEvents = dispinterface
    ['{2000A1EE-8F0B-4027-B84E-A8172950CF0C}']
    procedure onReport(const pData: IReport); dispid 1537;
  end;

// *********************************************************************//
// DispIntf:  IReportHandlerEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {20004D65-E291-4B63-8062-7E99EBD21BDF}
// *********************************************************************//
  IReportHandlerEvents = dispinterface
    ['{20004D65-E291-4B63-8062-7E99EBD21BDF}']
    procedure onPenData(const pPenData: IPenData); dispid 5377;
    procedure onPenDataOption(const pPenDataOption: IPenDataOption); dispid 5378;
    procedure onPenDataEncrypted(const pPenDataEncrypted: IPenDataEncrypted); dispid 5379;
    procedure onPenDataEncryptedOption(const pPenDataEncryptedOption: IPenDataEncryptedOption); dispid 5380;
    procedure onDevicePublicKey(pDevicePublicKey: {??PSafeArray}OleVariant); dispid 5381;
    procedure onDecrypt(const pData: IDecrypt); dispid 5382;
  end;

// *********************************************************************//
// Interface: ITabletEventsException
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005380-DA13-492A-A97F-EE5811B49B1C}
// *********************************************************************//
  ITabletEventsException = interface(IDispatch)
    ['{20005380-DA13-492A-A97F-EE5811B49B1C}']
    procedure getException; safecall;
  end;

// *********************************************************************//
// DispIntf:  ITabletEventsExceptionDisp
// Flags:     (4544) Dual NonExtensible OleAutomation Dispatchable
// GUID:      {20005380-DA13-492A-A97F-EE5811B49B1C}
// *********************************************************************//
  ITabletEventsExceptionDisp = dispinterface
    ['{20005380-DA13-492A-A97F-EE5811B49B1C}']
    procedure getException; dispid 7425;
  end;

// *********************************************************************//
// DispIntf:  ITabletEvents
// Flags:     (4224) NonExtensible Dispatchable
// GUID:      {2000C72A-E338-477E-B359-D6D00006D29E}
// *********************************************************************//
  ITabletEvents = dispinterface
    ['{2000C72A-E338-477E-B359-D6D00006D29E}']
    procedure onGetReportException(const pException: ITabletEventsException); dispid 6913;
    procedure onUnhandledReportData(pData: {??PSafeArray}OleVariant); dispid 6914;
    procedure onPenData(const pPenData: IPenData); dispid 6915;
    procedure onPenDataOption(const pPenDataOption: IPenDataOption); dispid 6916;
    procedure onPenDataEncrypted(const pPenDataEncrypted: IPenDataEncrypted); dispid 6917;
    procedure onPenDataEncryptedOption(const pPenDataEncryptedOption: IPenDataEncryptedOption); dispid 6918;
    procedure onDevicePublicKey(pDevicePublicKey: {??PSafeArray}OleVariant); dispid 6919;
  end;

// *********************************************************************//
// The Class CoUsbInterface provides a Create and CreateRemote method to          
// create instances of the default interface IUsbInterface exposed by              
// the CoClass UsbInterface. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUsbInterface = class
    class function Create: IUsbInterface;
    class function CreateRemote(const MachineName: string): IUsbInterface;
  end;

  TUsbInterfaceonReport = procedure(ASender: TObject; const pData: IReport) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TUsbInterface
// Help String      : 
// Default Interface: IUsbInterface
// Def. Intf. DISP? : No
// Event   Interface: IInterfaceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TUsbInterfaceProperties= class;
{$ENDIF}
  TUsbInterface = class(TOleServer)
  private
    FOnonReport: TUsbInterfaceonReport;
    FIntf:        IUsbInterface;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TUsbInterfaceProperties;
    function      GetServerProperties: TUsbInterfaceProperties;
{$ENDIF}
    function      GetDefaultInterface: IUsbInterface;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IUsbInterface);
    procedure Disconnect; override;
    function connect1(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode;
    function connect2(const fileName: WideString; const bulkFileName: WideString; 
                      exclusiveLock: WordBool): IErrorCode;
    property DefaultInterface: IUsbInterface read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TUsbInterfaceProperties read GetServerProperties;
{$ENDIF}
    property OnonReport: TUsbInterfaceonReport read FOnonReport write FOnonReport;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TUsbInterface
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TUsbInterfaceProperties = class(TPersistent)
  private
    FServer:    TUsbInterface;
    function    GetDefaultInterface: IUsbInterface;
    constructor Create(AServer: TUsbInterface);
  protected
  public
    property DefaultInterface: IUsbInterface read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoSerialInterface provides a Create and CreateRemote method to          
// create instances of the default interface ISerialInterface exposed by              
// the CoClass SerialInterface. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoSerialInterface = class
    class function Create: ISerialInterface;
    class function CreateRemote(const MachineName: string): ISerialInterface;
  end;

  TSerialInterfaceonReport = procedure(ASender: TObject; const pData: IReport) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TSerialInterface
// Help String      : 
// Default Interface: ISerialInterface
// Def. Intf. DISP? : No
// Event   Interface: IInterfaceEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TSerialInterfaceProperties= class;
{$ENDIF}
  TSerialInterface = class(TOleServer)
  private
    FOnonReport: TSerialInterfaceonReport;
    FIntf:        ISerialInterface;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TSerialInterfaceProperties;
    function      GetServerProperties: TSerialInterfaceProperties;
{$ENDIF}
    function      GetDefaultInterface: ISerialInterface;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ISerialInterface);
    procedure Disconnect; override;
    function connect1(const fileName: WideString; useCrc: WordBool): IErrorCode;
    property DefaultInterface: ISerialInterface read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TSerialInterfaceProperties read GetServerProperties;
{$ENDIF}
    property OnonReport: TSerialInterfaceonReport read FOnonReport write FOnonReport;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TSerialInterface
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TSerialInterfaceProperties = class(TPersistent)
  private
    FServer:    TSerialInterface;
    function    GetDefaultInterface: ISerialInterface;
    constructor Create(AServer: TSerialInterface);
  protected
  public
    property DefaultInterface: ISerialInterface read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoUsbDevices provides a Create and CreateRemote method to          
// create instances of the default interface IUsbDevices exposed by              
// the CoClass UsbDevices. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoUsbDevices = class
    class function Create: IUsbDevices;
    class function CreateRemote(const MachineName: string): IUsbDevices;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TUsbDevices
// Help String      : 
// Default Interface: IUsbDevices
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TUsbDevicesProperties= class;
{$ENDIF}
  TUsbDevices = class(TOleServer)
  private
    FIntf:        IUsbDevices;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TUsbDevicesProperties;
    function      GetServerProperties: TUsbDevicesProperties;
{$ENDIF}
    function      GetDefaultInterface: IUsbDevices;
  protected
    procedure InitServerData; override;
    function Get__NewEnum: IUnknown;
    function Get_Item(index: OleVariant): IUsbDevice;
    function Get_Count: Integer;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IUsbDevices);
    procedure Disconnect; override;
    property DefaultInterface: IUsbDevices read GetDefaultInterface;
    property _NewEnum: IUnknown read Get__NewEnum;
    property Item[index: OleVariant]: IUsbDevice read Get_Item; default;
    property Count: Integer read Get_Count;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TUsbDevicesProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TUsbDevices
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TUsbDevicesProperties = class(TPersistent)
  private
    FServer:    TUsbDevices;
    function    GetDefaultInterface: IUsbDevices;
    constructor Create(AServer: TUsbDevices);
  protected
    function Get__NewEnum: IUnknown;
    function Get_Item(index: OleVariant): IUsbDevice;
    function Get_Count: Integer;
  public
    property DefaultInterface: IUsbDevices read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoJScript provides a Create and CreateRemote method to          
// create instances of the default interface IJScript exposed by              
// the CoClass JScript. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoJScript = class
    class function Create: IJScript;
    class function CreateRemote(const MachineName: string): IJScript;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TJScript
// Help String      : 
// Default Interface: IJScript
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TJScriptProperties= class;
{$ENDIF}
  TJScript = class(TOleServer)
  private
    FIntf:        IJScript;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TJScriptProperties;
    function      GetServerProperties: TJScriptProperties;
{$ENDIF}
    function      GetDefaultInterface: IJScript;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IJScript);
    procedure Disconnect; override;
    function toArray(value: PSafeArray): IDispatch;
    function toVBArray(const value: IDispatch): PSafeArray;
    function toTabletEncryptionHandler(const value: IDispatch): ITabletEncryptionHandler;
    property DefaultInterface: IJScript read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TJScriptProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TJScript
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TJScriptProperties = class(TPersistent)
  private
    FServer:    TJScript;
    function    GetDefaultInterface: IJScript;
    constructor Create(AServer: TJScript);
  protected
  public
    property DefaultInterface: IJScript read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoProtocolHelper provides a Create and CreateRemote method to          
// create instances of the default interface IProtocolHelper exposed by              
// the CoClass ProtocolHelper. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoProtocolHelper = class
    class function Create: IProtocolHelper;
    class function CreateRemote(const MachineName: string): IProtocolHelper;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TProtocolHelper
// Help String      : 
// Default Interface: IProtocolHelper
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TProtocolHelperProperties= class;
{$ENDIF}
  TProtocolHelper = class(TOleServer)
  private
    FIntf:        IProtocolHelper;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TProtocolHelperProperties;
    function      GetServerProperties: TProtocolHelperProperties;
{$ENDIF}
    function      GetDefaultInterface: IProtocolHelper;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IProtocolHelper);
    procedure Disconnect; override;
    function statusCanSend(statusCode: Byte; ReportId: Byte; OpDirection: OpDirection): WordBool;
    procedure waitForStatusToSend(const Protocol: IProtocol; ReportId: Byte; 
                                  OpDirection: OpDirection; retries: SYSUINT; 
                                  sleepBetweenRetries: SYSUINT);
    procedure waitForStatus(const Protocol: IProtocol; statusCode: Byte; retries: SYSUINT; 
                            sleepBetweenRetries: SYSUINT);
    function supportsEncryption(const Protocol: IProtocol): WordBool;
    function supportsEncryption_DHprime(dhPrime: PSafeArray): WordBool;
    function setHostPublicKeyAndPollForDevicePublicKey(const Protocol: IProtocol; 
                                                       hostPublicKey: PSafeArray; retries: SYSUINT; 
                                                       sleepBetweenRetries: SYSUINT): PSafeArray;
    procedure writeImage(const Protocol: IProtocol; encodingMode: Byte; imageData: PSafeArray; 
                         retries: SYSUINT; sleepBetweenRetries: SYSUINT);
    function flattenMonochrome(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray;
    function flattenColor16_565(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray;
    function flatten(image: OleVariant; screenWidth: Word; screenHeight: Word; isColor: WordBool): PSafeArray;
    function resizeAndFlatten(image: OleVariant; offsetX: SYSUINT; offsetY: SYSUINT; 
                              bitmapWidth: SYSUINT; bitmapHeight: SYSUINT; screenWidth: Word; 
                              screenHeight: Word; isColor: WordBool; Scale: Scale; 
                              backgroundColor: OleVariant; Clip: Byte): PSafeArray;
    property DefaultInterface: IProtocolHelper read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TProtocolHelperProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TProtocolHelper
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TProtocolHelperProperties = class(TPersistent)
  private
    FServer:    TProtocolHelper;
    function    GetDefaultInterface: IProtocolHelper;
    constructor Create(AServer: TProtocolHelper);
  protected
  public
    property DefaultInterface: IProtocolHelper read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoReportHandler provides a Create and CreateRemote method to          
// create instances of the default interface IReportHandler exposed by              
// the CoClass ReportHandler. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoReportHandler = class
    class function Create: IReportHandler;
    class function CreateRemote(const MachineName: string): IReportHandler;
  end;

  TReportHandleronPenData = procedure(ASender: TObject; const pPenData: IPenData) of object;
  TReportHandleronPenDataOption = procedure(ASender: TObject; const pPenDataOption: IPenDataOption) of object;
  TReportHandleronPenDataEncrypted = procedure(ASender: TObject; const pPenDataEncrypted: IPenDataEncrypted) of object;
  TReportHandleronPenDataEncryptedOption = procedure(ASender: TObject; const pPenDataEncryptedOption: IPenDataEncryptedOption) of object;
  TReportHandleronDevicePublicKey = procedure(ASender: TObject; pDevicePublicKey: {??PSafeArray}OleVariant) of object;
  TReportHandleronDecrypt = procedure(ASender: TObject; const pData: IDecrypt) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TReportHandler
// Help String      : 
// Default Interface: IReportHandler
// Def. Intf. DISP? : No
// Event   Interface: IReportHandlerEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TReportHandlerProperties= class;
{$ENDIF}
  TReportHandler = class(TOleServer)
  private
    FOnonPenData: TReportHandleronPenData;
    FOnonPenDataOption: TReportHandleronPenDataOption;
    FOnonPenDataEncrypted: TReportHandleronPenDataEncrypted;
    FOnonPenDataEncryptedOption: TReportHandleronPenDataEncryptedOption;
    FOnonDevicePublicKey: TReportHandleronDevicePublicKey;
    FOnonDecrypt: TReportHandleronDecrypt;
    FIntf:        IReportHandler;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TReportHandlerProperties;
    function      GetServerProperties: TReportHandlerProperties;
{$ENDIF}
    function      GetDefaultInterface: IReportHandler;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IReportHandler);
    procedure Disconnect; override;
    function handleReport(data: PSafeArray): WordBool;
    property DefaultInterface: IReportHandler read GetDefaultInterface;
  
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TReportHandlerProperties read GetServerProperties;
{$ENDIF}
    property OnonPenData: TReportHandleronPenData read FOnonPenData write FOnonPenData;
    property OnonPenDataOption: TReportHandleronPenDataOption read FOnonPenDataOption write FOnonPenDataOption;
    property OnonPenDataEncrypted: TReportHandleronPenDataEncrypted read FOnonPenDataEncrypted write FOnonPenDataEncrypted;
    property OnonPenDataEncryptedOption: TReportHandleronPenDataEncryptedOption read FOnonPenDataEncryptedOption write FOnonPenDataEncryptedOption;
    property OnonDevicePublicKey: TReportHandleronDevicePublicKey read FOnonDevicePublicKey write FOnonDevicePublicKey;
    property OnonDecrypt: TReportHandleronDecrypt read FOnonDecrypt write FOnonDecrypt;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TReportHandler
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TReportHandlerProperties = class(TPersistent)
  private
    FServer:    TReportHandler;
    function    GetDefaultInterface: IReportHandler;
    constructor Create(AServer: TReportHandler);
  protected
  public
    property DefaultInterface: IReportHandler read GetDefaultInterface;
  published
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoTablet provides a Create and CreateRemote method to          
// create instances of the default interface ITablet exposed by              
// the CoClass Tablet. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoTablet = class
    class function Create: ITablet;
    class function CreateRemote(const MachineName: string): ITablet;
  end;

  TTabletonGetReportException = procedure(ASender: TObject; const pException: ITabletEventsException) of object;
  TTabletonUnhandledReportData = procedure(ASender: TObject; pData: {??PSafeArray}OleVariant) of object;
  TTabletonPenData = procedure(ASender: TObject; const pPenData: IPenData) of object;
  TTabletonPenDataOption = procedure(ASender: TObject; const pPenDataOption: IPenDataOption) of object;
  TTabletonPenDataEncrypted = procedure(ASender: TObject; const pPenDataEncrypted: IPenDataEncrypted) of object;
  TTabletonPenDataEncryptedOption = procedure(ASender: TObject; const pPenDataEncryptedOption: IPenDataEncryptedOption) of object;
  TTabletonDevicePublicKey = procedure(ASender: TObject; pDevicePublicKey: {??PSafeArray}OleVariant) of object;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TTablet
// Help String      : 
// Default Interface: ITablet
// Def. Intf. DISP? : No
// Event   Interface: ITabletEvents
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TTabletProperties= class;
{$ENDIF}
  TTablet = class(TOleServer)
  private
    FOnonGetReportException: TTabletonGetReportException;
    FOnonUnhandledReportData: TTabletonUnhandledReportData;
    FOnonPenData: TTabletonPenData;
    FOnonPenDataOption: TTabletonPenDataOption;
    FOnonPenDataEncrypted: TTabletonPenDataEncrypted;
    FOnonPenDataEncryptedOption: TTabletonPenDataEncryptedOption;
    FOnonDevicePublicKey: TTabletonDevicePublicKey;
    FIntf:        ITablet;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TTabletProperties;
    function      GetServerProperties: TTabletProperties;
{$ENDIF}
    function      GetDefaultInterface: ITablet;
  protected
    procedure InitServerData; override;
    procedure InvokeEvent(DispID: TDispID; var Params: TVariantArray); override;
    function Get_encryptionHandler: ITabletEncryptionHandler;
    procedure Set_encryptionHandler(const pRetVal: ITabletEncryptionHandler);
    function Get_Protocol: IProtocol;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: ITablet);
    procedure Disconnect; override;
    function usbConnect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode;
    function usbConnect2(const fileName: WideString; const bulkFileName: WideString; 
                         exclusiveLock: WordBool): IErrorCode;
    function serialConnect(const fileName: WideString; useCrc: WordBool): IErrorCode;
    function isEmpty: WordBool;
    function isConnected: WordBool;
    procedure disconnect1;
    function interfaceQueue: IInterfaceQueue;
    procedure queueNotifyAll;
    function supportsWrite: WordBool;
    procedure getReportCountLengths(var pRetVal: PSafeArray);
    procedure isSupported(ReportId: Byte; var pRetVal: WordBool);
    function getStatus: IStatus;
    procedure reset;
    function getInformation: IInformation;
    function getCapability: ICapability;
    function getUid: SYSUINT;
    procedure setUid(uid: SYSUINT);
    function getHostPublicKey: PSafeArray;
    function getDevicePublicKey: PSafeArray;
    procedure startCapture(sessionId: SYSUINT);
    procedure endCapture;
    function getDHprime: PSafeArray;
    procedure setDHprime(dhPrime: PSafeArray);
    function getDHbase: PSafeArray;
    procedure setDHbase(dhBase: PSafeArray);
    procedure setClearScreen;
    function getInkingMode: Byte;
    procedure setInkingMode(inkingMode: Byte);
    function getInkThreshold: IInkThreshold;
    procedure setInkThreshold(const inkThreshold: IInkThreshold);
    procedure writeImage(encodingMode: Byte; imageData: PSafeArray);
    procedure endImageData;
    function getHandwritingThicknessColor: IHandwritingThicknessColor;
    procedure setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor);
    function getBackgroundColor: Word;
    procedure setBackgroundColor(backgroundColor: Word);
    function getHandwritingDisplayArea: IHandwritingDisplayArea;
    procedure setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea);
    function getBacklightBrightness: Word;
    procedure setBacklightBrightness(backlightBrightness: Word);
    function getPenDataOptionMode: Byte;
    procedure setPenDataOptionMode(penDataOptionMode: Byte);
    property DefaultInterface: ITablet read GetDefaultInterface;
    property Protocol: IProtocol read Get_Protocol;
    property encryptionHandler: ITabletEncryptionHandler read Get_encryptionHandler write Set_encryptionHandler;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TTabletProperties read GetServerProperties;
{$ENDIF}
    property OnonGetReportException: TTabletonGetReportException read FOnonGetReportException write FOnonGetReportException;
    property OnonUnhandledReportData: TTabletonUnhandledReportData read FOnonUnhandledReportData write FOnonUnhandledReportData;
    property OnonPenData: TTabletonPenData read FOnonPenData write FOnonPenData;
    property OnonPenDataOption: TTabletonPenDataOption read FOnonPenDataOption write FOnonPenDataOption;
    property OnonPenDataEncrypted: TTabletonPenDataEncrypted read FOnonPenDataEncrypted write FOnonPenDataEncrypted;
    property OnonPenDataEncryptedOption: TTabletonPenDataEncryptedOption read FOnonPenDataEncryptedOption write FOnonPenDataEncryptedOption;
    property OnonDevicePublicKey: TTabletonDevicePublicKey read FOnonDevicePublicKey write FOnonDevicePublicKey;
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TTablet
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TTabletProperties = class(TPersistent)
  private
    FServer:    TTablet;
    function    GetDefaultInterface: ITablet;
    constructor Create(AServer: TTablet);
  protected
    function Get_encryptionHandler: ITabletEncryptionHandler;
    procedure Set_encryptionHandler(const pRetVal: ITabletEncryptionHandler);
    function Get_Protocol: IProtocol;
  public
    property DefaultInterface: ITablet read GetDefaultInterface;
  published
    property encryptionHandler: ITabletEncryptionHandler read Get_encryptionHandler write Set_encryptionHandler;
  end;
{$ENDIF}


// *********************************************************************//
// The Class CoComponent provides a Create and CreateRemote method to          
// create instances of the default interface IComponent exposed by              
// the CoClass Component. The functions are intended to be used by             
// clients wishing to automate the CoClass objects exposed by the         
// server of this typelibrary.                                            
// *********************************************************************//
  CoComponent = class
    class function Create: IComponent;
    class function CreateRemote(const MachineName: string): IComponent;
  end;


// *********************************************************************//
// OLE Server Proxy class declaration
// Server Object    : TComponent
// Help String      : 
// Default Interface: IComponent
// Def. Intf. DISP? : No
// Event   Interface: 
// TypeFlags        : (2) CanCreate
// *********************************************************************//
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  TComponentProperties= class;
{$ENDIF}
  TComponent2 = class(TOleServer)
  private
    FIntf:        IComponent;
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    FProps:       TComponentProperties;
    function      GetServerProperties: TComponentProperties;
{$ENDIF}
    function      GetDefaultInterface: IComponent;
  protected
    procedure InitServerData; override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor  Destroy; override;
    procedure Connect; override;
    procedure ConnectTo(svrIntf: IComponent);
    procedure Disconnect; override;
    function getProperty(const name: WideString): OleVariant;
    procedure setProperty(const name: WideString; value: OleVariant);
    function componentFiles: IComponentFiles;
    function diagnosticInformation(flag: SYSUINT): WideString;
    property DefaultInterface: IComponent read GetDefaultInterface;
  published
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
    property Server: TComponentProperties read GetServerProperties;
{$ENDIF}
  end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
// *********************************************************************//
// OLE Server Properties Proxy Class
// Server Object    : TComponent
// (This object is used by the IDE's Property Inspector to allow editing
//  of the properties of this server)
// *********************************************************************//
 TComponentProperties = class(TPersistent)
  private
    FServer:    TComponent;
    function    GetDefaultInterface: IComponent;
    constructor Create(AServer: TComponent);
  protected
  public
    property DefaultInterface: IComponent read GetDefaultInterface;
  published
  end;
{$ENDIF}


procedure Register;

resourcestring
  dtlServerPage = 'ActiveX';

  dtlOcxPage = 'ActiveX';

implementation

uses ComObj;

class function CoUsbInterface.Create: IUsbInterface;
begin
  Result := CreateComObject(CLASS_UsbInterface) as IUsbInterface;
end;

class function CoUsbInterface.CreateRemote(const MachineName: string): IUsbInterface;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UsbInterface) as IUsbInterface;
end;

procedure TUsbInterface.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2000BC66-5735-45C7-9521-93FAAFE8C3BB}';
    IntfIID:   '{2000C1D7-8270-490B-A8F3-766258E6BAB9}';
    EventIID:  '{2000A1EE-8F0B-4027-B84E-A8172950CF0C}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TUsbInterface.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IUsbInterface;
  end;
end;

procedure TUsbInterface.ConnectTo(svrIntf: IUsbInterface);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TUsbInterface.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TUsbInterface.GetDefaultInterface: IUsbInterface;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TUsbInterface.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TUsbInterfaceProperties.Create(Self);
{$ENDIF}
end;

destructor TUsbInterface.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TUsbInterface.GetServerProperties: TUsbInterfaceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TUsbInterface.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1537: if Assigned(FOnonReport) then
         FOnonReport(Self, IUnknown(TVarData(Params[0]).VPointer) as IReport {const IReport});
  end; {case DispID}
end;

function TUsbInterface.connect1(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode;
begin
  Result := DefaultInterface.connect(usbDevice, exclusiveLock);
end;

function TUsbInterface.connect2(const fileName: WideString; const bulkFileName: WideString; 
                                exclusiveLock: WordBool): IErrorCode;
begin
  Result := DefaultInterface.connect2(fileName, bulkFileName, exclusiveLock);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TUsbInterfaceProperties.Create(AServer: TUsbInterface);
begin
  inherited Create;
  FServer := AServer;
end;

function TUsbInterfaceProperties.GetDefaultInterface: IUsbInterface;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoSerialInterface.Create: ISerialInterface;
begin
  Result := CreateComObject(CLASS_SerialInterface) as ISerialInterface;
end;

class function CoSerialInterface.CreateRemote(const MachineName: string): ISerialInterface;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_SerialInterface) as ISerialInterface;
end;

procedure TSerialInterface.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{20001CFF-184E-4E32-9FC4-A617533D342E}';
    IntfIID:   '{20003D0C-A047-4487-8FE0-0CF9AB05E48C}';
    EventIID:  '{2000A1EE-8F0B-4027-B84E-A8172950CF0C}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TSerialInterface.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ISerialInterface;
  end;
end;

procedure TSerialInterface.ConnectTo(svrIntf: ISerialInterface);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TSerialInterface.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TSerialInterface.GetDefaultInterface: ISerialInterface;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TSerialInterface.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TSerialInterfaceProperties.Create(Self);
{$ENDIF}
end;

destructor TSerialInterface.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TSerialInterface.GetServerProperties: TSerialInterfaceProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TSerialInterface.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    1537: if Assigned(FOnonReport) then
         FOnonReport(Self, IUnknown(TVarData(Params[0]).VPointer) as IReport {const IReport});
  end; {case DispID}
end;

function TSerialInterface.connect1(const fileName: WideString; useCrc: WordBool): IErrorCode;
begin
  Result := DefaultInterface.connect(fileName, useCrc);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TSerialInterfaceProperties.Create(AServer: TSerialInterface);
begin
  inherited Create;
  FServer := AServer;
end;

function TSerialInterfaceProperties.GetDefaultInterface: ISerialInterface;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoUsbDevices.Create: IUsbDevices;
begin
  Result := CreateComObject(CLASS_UsbDevices) as IUsbDevices;
end;

class function CoUsbDevices.CreateRemote(const MachineName: string): IUsbDevices;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_UsbDevices) as IUsbDevices;
end;

procedure TUsbDevices.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2000D7A5-64F7-4826-B56E-85ACC618E4D6}';
    IntfIID:   '{20008CC2-6576-4665-8411-99291CF18387}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TUsbDevices.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IUsbDevices;
  end;
end;

procedure TUsbDevices.ConnectTo(svrIntf: IUsbDevices);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TUsbDevices.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TUsbDevices.GetDefaultInterface: IUsbDevices;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TUsbDevices.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TUsbDevicesProperties.Create(Self);
{$ENDIF}
end;

destructor TUsbDevices.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TUsbDevices.GetServerProperties: TUsbDevicesProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TUsbDevices.Get__NewEnum: IUnknown;
begin
    Result := DefaultInterface._NewEnum;
end;

function TUsbDevices.Get_Item(index: OleVariant): IUsbDevice;
begin
    Result := DefaultInterface.Item[index];
end;

function TUsbDevices.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TUsbDevicesProperties.Create(AServer: TUsbDevices);
begin
  inherited Create;
  FServer := AServer;
end;

function TUsbDevicesProperties.GetDefaultInterface: IUsbDevices;
begin
  Result := FServer.DefaultInterface;
end;

function TUsbDevicesProperties.Get__NewEnum: IUnknown;
begin
    Result := DefaultInterface._NewEnum;
end;

function TUsbDevicesProperties.Get_Item(index: OleVariant): IUsbDevice;
begin
    Result := DefaultInterface.Item[index];
end;

function TUsbDevicesProperties.Get_Count: Integer;
begin
    Result := DefaultInterface.Count;
end;

{$ENDIF}

class function CoJScript.Create: IJScript;
begin
  Result := CreateComObject(CLASS_JScript) as IJScript;
end;

class function CoJScript.CreateRemote(const MachineName: string): IJScript;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_JScript) as IJScript;
end;

procedure TJScript.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2000D408-6AFE-4CBA-BDB1-DA087DA66B05}';
    IntfIID:   '{200072FE-6F48-44D0-8C0A-4ABAE07EDFF6}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TJScript.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IJScript;
  end;
end;

procedure TJScript.ConnectTo(svrIntf: IJScript);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TJScript.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TJScript.GetDefaultInterface: IJScript;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TJScript.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TJScriptProperties.Create(Self);
{$ENDIF}
end;

destructor TJScript.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TJScript.GetServerProperties: TJScriptProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TJScript.toArray(value: PSafeArray): IDispatch;
begin
  Result := DefaultInterface.toArray(value);
end;

function TJScript.toVBArray(const value: IDispatch): PSafeArray;
begin
  Result := DefaultInterface.toVBArray(value);
end;

function TJScript.toTabletEncryptionHandler(const value: IDispatch): ITabletEncryptionHandler;
begin
  Result := DefaultInterface.toTabletEncryptionHandler(value);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TJScriptProperties.Create(AServer: TJScript);
begin
  inherited Create;
  FServer := AServer;
end;

function TJScriptProperties.GetDefaultInterface: IJScript;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoProtocolHelper.Create: IProtocolHelper;
begin
  Result := CreateComObject(CLASS_ProtocolHelper) as IProtocolHelper;
end;

class function CoProtocolHelper.CreateRemote(const MachineName: string): IProtocolHelper;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ProtocolHelper) as IProtocolHelper;
end;

procedure TProtocolHelper.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{2000CF89-E182-40AD-A8C2-5694987EA5DF}';
    IntfIID:   '{2000550B-EFC5-4D5F-8969-45C9A67CC93C}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TProtocolHelper.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IProtocolHelper;
  end;
end;

procedure TProtocolHelper.ConnectTo(svrIntf: IProtocolHelper);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TProtocolHelper.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TProtocolHelper.GetDefaultInterface: IProtocolHelper;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TProtocolHelper.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TProtocolHelperProperties.Create(Self);
{$ENDIF}
end;

destructor TProtocolHelper.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TProtocolHelper.GetServerProperties: TProtocolHelperProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TProtocolHelper.statusCanSend(statusCode: Byte; ReportId: Byte; OpDirection: OpDirection): WordBool;
begin
  Result := DefaultInterface.statusCanSend(statusCode, ReportId, OpDirection);
end;

procedure TProtocolHelper.waitForStatusToSend(const Protocol: IProtocol; ReportId: Byte; 
                                              OpDirection: OpDirection; retries: SYSUINT; 
                                              sleepBetweenRetries: SYSUINT);
begin
  DefaultInterface.waitForStatusToSend(Protocol, ReportId, OpDirection, retries, sleepBetweenRetries);
end;

procedure TProtocolHelper.waitForStatus(const Protocol: IProtocol; statusCode: Byte; 
                                        retries: SYSUINT; sleepBetweenRetries: SYSUINT);
begin
  DefaultInterface.waitForStatus(Protocol, statusCode, retries, sleepBetweenRetries);
end;

function TProtocolHelper.supportsEncryption(const Protocol: IProtocol): WordBool;
begin
  Result := DefaultInterface.supportsEncryption(Protocol);
end;

function TProtocolHelper.supportsEncryption_DHprime(dhPrime: PSafeArray): WordBool;
begin
  Result := DefaultInterface.supportsEncryption_DHprime(dhPrime);
end;

function TProtocolHelper.setHostPublicKeyAndPollForDevicePublicKey(const Protocol: IProtocol; 
                                                                   hostPublicKey: PSafeArray; 
                                                                   retries: SYSUINT; 
                                                                   sleepBetweenRetries: SYSUINT): PSafeArray;
begin
  Result := DefaultInterface.setHostPublicKeyAndPollForDevicePublicKey(Protocol, hostPublicKey, 
                                                                       retries, sleepBetweenRetries);
end;

procedure TProtocolHelper.writeImage(const Protocol: IProtocol; encodingMode: Byte; 
                                     imageData: PSafeArray; retries: SYSUINT; 
                                     sleepBetweenRetries: SYSUINT);
begin
  DefaultInterface.writeImage(Protocol, encodingMode, imageData, retries, sleepBetweenRetries);
end;

function TProtocolHelper.flattenMonochrome(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray;
begin
  Result := DefaultInterface.flattenMonochrome(image, screenWidth, screenHeight);
end;

function TProtocolHelper.flattenColor16_565(image: OleVariant; screenWidth: Word; screenHeight: Word): PSafeArray;
begin
  Result := DefaultInterface.flattenColor16_565(image, screenWidth, screenHeight);
end;

function TProtocolHelper.flatten(image: OleVariant; screenWidth: Word; screenHeight: Word; 
                                 isColor: WordBool): PSafeArray;
begin
  Result := DefaultInterface.flatten(image, screenWidth, screenHeight, isColor);
end;

function TProtocolHelper.resizeAndFlatten(image: OleVariant; offsetX: SYSUINT; offsetY: SYSUINT; 
                                          bitmapWidth: SYSUINT; bitmapHeight: SYSUINT; 
                                          screenWidth: Word; screenHeight: Word; isColor: WordBool; 
                                          Scale: Scale; backgroundColor: OleVariant; Clip: Byte): PSafeArray;
begin
  Result := DefaultInterface.resizeAndFlatten(image, offsetX, offsetY, bitmapWidth, bitmapHeight, 
                                              screenWidth, screenHeight, isColor, Scale, 
                                              backgroundColor, Clip);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TProtocolHelperProperties.Create(AServer: TProtocolHelper);
begin
  inherited Create;
  FServer := AServer;
end;

function TProtocolHelperProperties.GetDefaultInterface: IProtocolHelper;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoReportHandler.Create: IReportHandler;
begin
  Result := CreateComObject(CLASS_ReportHandler) as IReportHandler;
end;

class function CoReportHandler.CreateRemote(const MachineName: string): IReportHandler;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_ReportHandler) as IReportHandler;
end;

procedure TReportHandler.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{20008BA5-8133-45BA-91A5-AB54A1F70E13}';
    IntfIID:   '{2000446E-736E-4513-9751-A9B69648863E}';
    EventIID:  '{20004D65-E291-4B63-8062-7E99EBD21BDF}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TReportHandler.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as IReportHandler;
  end;
end;

procedure TReportHandler.ConnectTo(svrIntf: IReportHandler);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TReportHandler.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TReportHandler.GetDefaultInterface: IReportHandler;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TReportHandler.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TReportHandlerProperties.Create(Self);
{$ENDIF}
end;

destructor TReportHandler.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TReportHandler.GetServerProperties: TReportHandlerProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TReportHandler.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    5377: if Assigned(FOnonPenData) then
         FOnonPenData(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenData {const IPenData});
    5378: if Assigned(FOnonPenDataOption) then
         FOnonPenDataOption(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataOption {const IPenDataOption});
    5379: if Assigned(FOnonPenDataEncrypted) then
         FOnonPenDataEncrypted(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataEncrypted {const IPenDataEncrypted});
    5380: if Assigned(FOnonPenDataEncryptedOption) then
         FOnonPenDataEncryptedOption(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataEncryptedOption {const IPenDataEncryptedOption});
    5381: if Assigned(FOnonDevicePublicKey) then
         FOnonDevicePublicKey(Self, Params[0] { ??PSafeArray OleVariant});
    5382: if Assigned(FOnonDecrypt) then
         FOnonDecrypt(Self, IUnknown(TVarData(Params[0]).VPointer) as IDecrypt {const IDecrypt});
  end; {case DispID}
end;

function TReportHandler.handleReport(data: PSafeArray): WordBool;
begin
  Result := DefaultInterface.handleReport(data);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TReportHandlerProperties.Create(AServer: TReportHandler);
begin
  inherited Create;
  FServer := AServer;
end;

function TReportHandlerProperties.GetDefaultInterface: IReportHandler;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

class function CoTablet.Create: ITablet;
begin
  Result := CreateComObject(CLASS_Tablet) as ITablet;
end;

class function CoTablet.CreateRemote(const MachineName: string): ITablet;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Tablet) as ITablet;
end;

procedure TTablet.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{20002178-1165-4D38-A7F5-B169DE2045C1}';
    IntfIID:   '{20005C27-7729-492F-8106-540F2E04DC66}';
    EventIID:  '{2000C72A-E338-477E-B359-D6D00006D29E}';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TTablet.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    ConnectEvents(punk);
    Fintf:= punk as ITablet;
  end;
end;

procedure TTablet.ConnectTo(svrIntf: ITablet);
begin
  Disconnect;
  FIntf := svrIntf;
  ConnectEvents(FIntf);
end;

procedure TTablet.DisConnect;
begin
  if Fintf <> nil then
  begin
    DisconnectEvents(FIntf);
    FIntf := nil;
  end;
end;

function TTablet.GetDefaultInterface: ITablet;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TTablet.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TTabletProperties.Create(Self);
{$ENDIF}
end;

destructor TTablet.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TTablet.GetServerProperties: TTabletProperties;
begin
  Result := FProps;
end;
{$ENDIF}

procedure TTablet.InvokeEvent(DispID: TDispID; var Params: TVariantArray);
begin
  case DispID of
    -1: Exit;  // DISPID_UNKNOWN
    6913: if Assigned(FOnonGetReportException) then
         FOnonGetReportException(Self, IUnknown(TVarData(Params[0]).VPointer) as ITabletEventsException {const ITabletEventsException});
    6914: if Assigned(FOnonUnhandledReportData) then
         FOnonUnhandledReportData(Self, Params[0] { ??PSafeArray OleVariant});
    6915: if Assigned(FOnonPenData) then
         FOnonPenData(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenData {const IPenData});
    6916: if Assigned(FOnonPenDataOption) then
         FOnonPenDataOption(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataOption {const IPenDataOption});
    6917: if Assigned(FOnonPenDataEncrypted) then
         FOnonPenDataEncrypted(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataEncrypted {const IPenDataEncrypted});
    6918: if Assigned(FOnonPenDataEncryptedOption) then
         FOnonPenDataEncryptedOption(Self, IUnknown(TVarData(Params[0]).VPointer) as IPenDataEncryptedOption {const IPenDataEncryptedOption});
    6919: if Assigned(FOnonDevicePublicKey) then
         FOnonDevicePublicKey(Self, Params[0] { ??PSafeArray OleVariant});
  end; {case DispID}
end;

function TTablet.Get_encryptionHandler: ITabletEncryptionHandler;
begin
    Result := DefaultInterface.encryptionHandler;
end;

procedure TTablet.Set_encryptionHandler(const pRetVal: ITabletEncryptionHandler);
begin
  DefaultInterface.Set_encryptionHandler(pRetVal);
end;

function TTablet.Get_Protocol: IProtocol;
begin
    Result := DefaultInterface.Protocol;
end;

function TTablet.usbConnect(const usbDevice: IUsbDevice; exclusiveLock: WordBool): IErrorCode;
begin
  Result := DefaultInterface.usbConnect(usbDevice, exclusiveLock);
end;

function TTablet.usbConnect2(const fileName: WideString; const bulkFileName: WideString; 
                             exclusiveLock: WordBool): IErrorCode;
begin
  Result := DefaultInterface.usbConnect2(fileName, bulkFileName, exclusiveLock);
end;

function TTablet.serialConnect(const fileName: WideString; useCrc: WordBool): IErrorCode;
begin
  Result := DefaultInterface.serialConnect(fileName, useCrc);
end;

function TTablet.isEmpty: WordBool;
begin
  Result := DefaultInterface.isEmpty;
end;

function TTablet.isConnected: WordBool;
begin
  Result := DefaultInterface.isConnected;
end;

procedure TTablet.disconnect1;
begin
  DefaultInterface.disconnect;
end;

function TTablet.interfaceQueue: IInterfaceQueue;
begin
  Result := DefaultInterface.interfaceQueue;
end;

procedure TTablet.queueNotifyAll;
begin
  DefaultInterface.queueNotifyAll;
end;

function TTablet.supportsWrite: WordBool;
begin
  Result := DefaultInterface.supportsWrite;
end;

procedure TTablet.getReportCountLengths(var pRetVal: PSafeArray);
begin
  DefaultInterface.getReportCountLengths(pRetVal);
end;

procedure TTablet.isSupported(ReportId: Byte; var pRetVal: WordBool);
begin
  DefaultInterface.isSupported(ReportId, pRetVal);
end;

function TTablet.getStatus: IStatus;
begin
  Result := DefaultInterface.getStatus;
end;

procedure TTablet.reset;
begin
  DefaultInterface.reset;
end;

function TTablet.getInformation: IInformation;
begin
  Result := DefaultInterface.getInformation;
end;

function TTablet.getCapability: ICapability;
begin
  Result := DefaultInterface.getCapability;
end;

function TTablet.getUid: SYSUINT;
begin
  Result := DefaultInterface.getUid;
end;

procedure TTablet.setUid(uid: SYSUINT);
begin
  DefaultInterface.setUid(uid);
end;

function TTablet.getHostPublicKey: PSafeArray;
begin
  Result := DefaultInterface.getHostPublicKey;
end;

function TTablet.getDevicePublicKey: PSafeArray;
begin
  Result := DefaultInterface.getDevicePublicKey;
end;

procedure TTablet.startCapture(sessionId: SYSUINT);
begin
  DefaultInterface.startCapture(sessionId);
end;

procedure TTablet.endCapture;
begin
  DefaultInterface.endCapture;
end;

function TTablet.getDHprime: PSafeArray;
begin
  Result := DefaultInterface.getDHprime;
end;

procedure TTablet.setDHprime(dhPrime: PSafeArray);
begin
  DefaultInterface.setDHprime(dhPrime);
end;

function TTablet.getDHbase: PSafeArray;
begin
  Result := DefaultInterface.getDHbase;
end;

procedure TTablet.setDHbase(dhBase: PSafeArray);
begin
  DefaultInterface.setDHbase(dhBase);
end;

procedure TTablet.setClearScreen;
begin
  DefaultInterface.setClearScreen;
end;

function TTablet.getInkingMode: Byte;
begin
  Result := DefaultInterface.getInkingMode;
end;

procedure TTablet.setInkingMode(inkingMode: Byte);
begin
  DefaultInterface.setInkingMode(inkingMode);
end;

function TTablet.getInkThreshold: IInkThreshold;
begin
  Result := DefaultInterface.getInkThreshold;
end;

procedure TTablet.setInkThreshold(const inkThreshold: IInkThreshold);
begin
  DefaultInterface.setInkThreshold(inkThreshold);
end;

procedure TTablet.writeImage(encodingMode: Byte; imageData: PSafeArray);
begin
  DefaultInterface.writeImage(encodingMode, imageData);
end;

procedure TTablet.endImageData;
begin
  DefaultInterface.endImageData;
end;

function TTablet.getHandwritingThicknessColor: IHandwritingThicknessColor;
begin
  Result := DefaultInterface.getHandwritingThicknessColor;
end;

procedure TTablet.setHandwritingThicknessColor(const HandwritingThicknessColor: IHandwritingThicknessColor);
begin
  DefaultInterface.setHandwritingThicknessColor(HandwritingThicknessColor);
end;

function TTablet.getBackgroundColor: Word;
begin
  Result := DefaultInterface.getBackgroundColor;
end;

procedure TTablet.setBackgroundColor(backgroundColor: Word);
begin
  DefaultInterface.setBackgroundColor(backgroundColor);
end;

function TTablet.getHandwritingDisplayArea: IHandwritingDisplayArea;
begin
  Result := DefaultInterface.getHandwritingDisplayArea;
end;

procedure TTablet.setHandwritingDisplayArea(const handwritingDisplayArea: IHandwritingDisplayArea);
begin
  DefaultInterface.setHandwritingDisplayArea(handwritingDisplayArea);
end;

function TTablet.getBacklightBrightness: Word;
begin
  Result := DefaultInterface.getBacklightBrightness;
end;

procedure TTablet.setBacklightBrightness(backlightBrightness: Word);
begin
  DefaultInterface.setBacklightBrightness(backlightBrightness);
end;

function TTablet.getPenDataOptionMode: Byte;
begin
  Result := DefaultInterface.getPenDataOptionMode;
end;

procedure TTablet.setPenDataOptionMode(penDataOptionMode: Byte);
begin
  DefaultInterface.setPenDataOptionMode(penDataOptionMode);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TTabletProperties.Create(AServer: TTablet);
begin
  inherited Create;
  FServer := AServer;
end;

function TTabletProperties.GetDefaultInterface: ITablet;
begin
  Result := FServer.DefaultInterface;
end;

function TTabletProperties.Get_encryptionHandler: ITabletEncryptionHandler;
begin
    Result := DefaultInterface.encryptionHandler;
end;

procedure TTabletProperties.Set_encryptionHandler(const pRetVal: ITabletEncryptionHandler);
begin
  DefaultInterface.Set_encryptionHandler(pRetVal);
end;

function TTabletProperties.Get_Protocol: IProtocol;
begin
    Result := DefaultInterface.Protocol;
end;

{$ENDIF}

class function CoComponent.Create: IComponent;
begin
  Result := CreateComObject(CLASS_Component) as IComponent;
end;

class function CoComponent.CreateRemote(const MachineName: string): IComponent;
begin
  Result := CreateRemoteComObject(MachineName, CLASS_Component) as IComponent;
end;

procedure TComponent2.InitServerData;
const
  CServerData: TServerData = (
    ClassID:   '{20000000-5D96-46B0-895F-B0CC7295E44D}';
    IntfIID:   '{20001D33-3D2C-4E4D-AFE8-5E5D446637FD}';
    EventIID:  '';
    LicenseKey: nil;
    Version: 500);
begin
  ServerData := @CServerData;
end;

procedure TComponent2.Connect;
var
  punk: IUnknown;
begin
  if FIntf = nil then
  begin
    punk := GetServer;
    Fintf:= punk as IComponent;
  end;
end;

procedure TComponent2.ConnectTo(svrIntf: IComponent);
begin
  Disconnect;
  FIntf := svrIntf;
end;

procedure TComponent2.DisConnect;
begin
  if Fintf <> nil then
  begin
    FIntf := nil;
  end;
end;

function TComponent2.GetDefaultInterface: IComponent;
begin
  if FIntf = nil then
    Connect;
  Assert(FIntf <> nil, 'DefaultInterface is NULL. Component is not connected to Server. You must call ''Connect'' or ''ConnectTo'' before this operation');
  Result := FIntf;
end;

constructor TComponent2.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps := TComponentProperties.Create(Self);
{$ENDIF}
end;

destructor TComponent2.Destroy;
begin
{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
  FProps.Free;
{$ENDIF}
  inherited Destroy;
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
function TComponent.GetServerProperties: TComponentProperties;
begin
  Result := FProps;
end;
{$ENDIF}

function TComponent2.getProperty(const name: WideString): OleVariant;
begin
  Result := DefaultInterface.getProperty(name);
end;

procedure TComponent2.setProperty(const name: WideString; value: OleVariant);
begin
  DefaultInterface.setProperty(name, value);
end;

function TComponent2.componentFiles: IComponentFiles;
begin
  Result := DefaultInterface.componentFiles;
end;

function TComponent2.diagnosticInformation(flag: SYSUINT): WideString;
begin
  Result := DefaultInterface.diagnosticInformation(flag);
end;

{$IFDEF LIVE_SERVER_AT_DESIGN_TIME}
constructor TComponentProperties.Create(AServer: TComponent);
begin
  inherited Create;
  FServer := AServer;
end;

function TComponentProperties.GetDefaultInterface: IComponent;
begin
  Result := FServer.DefaultInterface;
end;

{$ENDIF}

procedure Register;
begin
  RegisterComponents(dtlServerPage, [TUsbInterface, TSerialInterface, TUsbDevices, TJScript, 
    TProtocolHelper, TReportHandler, TTablet, TComponent]);
end;

end.
