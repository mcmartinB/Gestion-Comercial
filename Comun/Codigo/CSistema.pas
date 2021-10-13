unit CSistema;

interface

uses
  Windows, SysUtils;

function ExecNewProcess(ProgramName : String; Wait: Boolean): Boolean;

implementation

function ExecNewProcess(ProgramName : String; Wait: Boolean): Boolean;
var
  StartInfo : TStartupInfo;
  ProcInfo : TProcessInformation;
begin
  { fill with known state }
  FillChar(StartInfo,SizeOf(TStartupInfo),#0);
  FillChar(ProcInfo,SizeOf(TProcessInformation),#0);
  StartInfo.cb := SizeOf(TStartupInfo);
  Result := CreateProcess(nil, PChar(ProgramName), nil, nil,False,
              CREATE_NEW_PROCESS_GROUP+NORMAL_PRIORITY_CLASS,
              nil, PChar(ExtractFileDir(ProgramName)),StartInfo, ProcInfo);
  { check to see if successful }
  if Result then
  begin
    //may or may not be needed. Usually wait for child processes
    if Wait then
      WaitForSingleObject(ProcInfo.hProcess, INFINITE);
  end;
  CloseHandle(ProcInfo.hProcess);
  CloseHandle(ProcInfo.hThread);
end;

end.
