{
  load nuoclient.dll/or other platform nuodb driver lib
  now, only implement the windows
}
unit life.icoder.nuodb.loaddriver;

interface

{ init below functions in unit }
uses
  life.icoder.nuodb.connection,
  life.icoder.nuodb.error,
  life.icoder.nuodb.lob,
  life.icoder.nuodb.option,
  life.icoder.nuodb.resultset,
  life.icoder.nuodb.statement,
  life.icoder.nuodb.temporal;

implementation

uses
  Winapi.Windows;

var
  lib_handle: THandle;

initialization
begin
  lib_handle := LoadLibrary('nuoclient.dll');
  if lib_handle <> 0 then
  begin
    NuoDB_Connection_create := GetProcAddress(lib_handle, 'NuoDB_Connection_create');
    NuoDB_Connection_createUtf8 := GetProcAddress(lib_handle, 'NuoDB_Connection_createUtf8');
    NuoDB_Connection_free := GetProcAddress(lib_handle, 'NuoDB_Connection_free');

    NuoDB_Error_getLastErrorInfo := GetProcAddress(lib_handle, 'NuoDB_Error_getLastErrorInfo');
    NuoDB_Error_clearLastErrorInfo := GetProcAddress(lib_handle, 'NuoDB_Error_clearLastErrorInfo');
    NuoDB_Error_registerCallback := GetProcAddress(lib_handle, 'NuoDB_Error_registerCallback');

    NuoDB_Lob_create := GetProcAddress(lib_handle, 'NuoDB_Lob_create');
    NuoDB_Lob_free := GetProcAddress(lib_handle, 'NuoDB_Lob_free');

    NuoDB_Options_create := GetProcAddress(lib_handle, 'NuoDB_Options_create');
    NuoDB_Options_free := GetProcAddress(lib_handle, 'NuoDB_Options_free');

    NuoDB_ResultSet_free := GetProcAddress(lib_handle, 'NuoDB_ResultSet_free');

    NuoDB_Statement_create := GetProcAddress(lib_handle, 'NuoDB_Statement_create');
    NuoDB_Statement_free := GetProcAddress(lib_handle, 'NuoDB_Statement_free');

    NuoDB_Temporal_create := GetProcAddress(lib_handle, 'NuoDB_Temporal_create');
    NuoDB_Temporal_free := GetProcAddress(lib_handle, 'NuoDB_Temporal_free');
  end;
end;

finalization
begin
  if lib_handle <> 0 then
    FreeLibrary(lib_handle);
end;

end.
