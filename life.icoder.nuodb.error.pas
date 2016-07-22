{
  error.h
}
unit life.icoder.nuodb.error;

interface

uses
  life.icoder.nuodb,
  life.icoder.nuodb.statement,
  life.icoder.nuodb.connection;

type

{! %NuoDB error information data structure
 *
 * The NuoDB_Error data structure contains information about a error
 * condition.
 *
 * There are three mechanisms for error handling:
 * @li Global error handling through callback functions provided by
 * the client, registered with the function
 * NuoDB_Error_registerCallback().
 * @li Local error handling by checking integer return codes from functions.
 * Functions that return a error code will be integer zero (0) to indicate
 * success, or a negative integer to indicate an error condition.
 * @li Contextual thread error checking by calling the function
 * NuoDB_Error_getLastErrorInfo() to retrive the last known error. }

  PNuoDB_Error = ^NuoDB_Error;
  NuoDB_Error = packed record
    _state: _NuoDB_Error_state_t;

    {* @brief   Returns the error status, which is a enumerated
     * integer code for errors that can be returned by this driver.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  NuoDB_Status enumerated type}
    public type TgetStatus = function (_this: PNuoDB_Error): NuoDB_Status; stdcall;
    public
    getStatus: TgetStatus;

    {* @brief   Returns the NuoDB_Connection for the specified error
     * data structure.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  pointer to NuoDB_Connection.}
     public type TgetConnection = function (_this: PNuoDB_Error): PNuoDB_Connection; stdcall;
     public
     getConnection: TgetConnection;

     {@brief   Returns the NuoDB_Statement for the specified error
     * data structure, if known.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  pointer to the NuoDB_Statement data structure that was
     * involved with the error.  If the NuoDB_Statement was unknown at
     * the time of the error, this function will return NULL.}
     public type TgetStatement = function (_this: PNuoDB_Error): PNuoDB_Statement; stdcall;
     public
     getStatement: TgetStatement;

     {@brief   Returns text of the error message.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  a pointer to a string that contains the error message.}
     public type TgetText = function (_this: PNuoDB_Error): PAnsiChar; stdcall;
     public getText: TgetText;

     {@brief   Returns stack trace for the error.
     *
     * If the stack trace is known at the point of the error
     * condition, then the return value will contain a pointer to
     * a string that represents the entire stack trace.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  pointer to a string that contains the stack trace, or
     * NULL if the stack trace is unknown at the time of the error.}
     public type TgetTrace = function (_this: PNuoDB_Error): PAnsiChar; stdcall;
     public getTrace: TgetTrace;

     {@brief   Returns the SQL State string.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  a pointer to a string that contains the SQL State code.}
     public type TgetSqlState = function (_this: PNuoDB_Error): PAnsiChar; stdcall;
     public getSqlState: TgetSqlState;
  end;

  {@brief   Obtain the last known error.
 *
 * This function returns a pointer to the last known NuoDB_Error that
 * occurred in the context of the caller's thread.  The NuoDB_Error
 * data structure can be used to obtain the last known error code,
 * error text, stack trace, and SQL State.}
  TNuoDB_Error_getLastErrorInfo = function(): PNuoDB_Error; stdcall;
var
  NuoDB_Error_getLastErrorInfo: TNuoDB_Error_getLastErrorInfo;

  {@brief   Clear the last known error.
 *
 * This function clears the last known NuoDB_Error for the caller's thread.}
type
  TNuoDB_Error_clearLastErrorInfo = procedure(); stdcall;
var
  NuoDB_Error_clearLastErrorInfo: TNuoDB_Error_clearLastErrorInfo;

  {@brief   Register an error callback function.
 *
 * This function allows the client application to register a function
 * that will be called in the event of a error.  The registered
 * function is specific to the caller's thread.  When an error occurs,
 * the C driver will call the error function on the caller's thread.}
type
  TError_Callback = function(error: PNuoDB_Error): NuoDB_Status; stdcall;
  TNuoDB_Error_registerCallback = procedure(callback: TError_Callback); stdcall;
var
  NuoDB_Error_registerCallback: TNuoDB_Error_registerCallback;

implementation

end.
