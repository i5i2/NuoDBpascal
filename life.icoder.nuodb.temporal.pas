{
  @file temporal.h
 * @brief Data structure used to represent temporal information.
}
unit life.icoder.nuodb.temporal;

interface

uses
  life.icoder.nuodb;

type
  {Constant temporal types used by NuoDB_Temporal.}
  NuoDB_Temporal_Type = (
    {@brief   SQL DATE type}
    NUODB_TEMPORAL_DATE         = 1,

    {@brief   SQL TIME type }
    NUODB_TEMPORAL_TIME         = 2,

    {  @brief   SQL TIMESTAMP type }
    NUODB_TEMPORAL_TIMESTAMP    = 3
  );

  {Data structure used to represent temporal information.
  *
  * The NuoDB_Temporal data structure can be used to store and retrieve any
  * NuoDB Temporal information (SQL DATE, SQL TIME, or SQL TIMESTAMP).}
  PPNuoDB_Temporal = ^PNuoDB_Temporal;
  PNuoDB_Temporal = ^NuoDB_Temporal;
  NuoDB_Temporal = packed record
    _state: _NuoDB_Temporal_state_t;

    {@brief   Return the SQL type for the NuoDB_Temporal data structure.
     *
     * The NuoDB_Temporal data structure can be used to store and retrieve a
     * SQL DATE, SQL TIME, or SQL TIMESTAMP.  This function returns
     * the SQL type.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  the SQL type.}
    public type TgetType = function (_this: PNuoDB_Temporal): NuoDB_Temporal_Type; stdcall;
    public getType: TgetType;

    {@brief   Set the NuoDB_Temporal data structure with the
     * specified number of milliseconds.
     *
     * @param[in]   _this     a pointer to the current (this) data structure.
     * @param[in]   millis    a 64-bit integer specifying the number of
     *                    milliseconds since the common (UNIX) epoch,
     *                    January 1, 1970}
    public type TsetMilliSeconds = procedure (_this: PNuoDB_Temporal; millis: Int64); stdcall;
    public setMilliSeconds: TsetMilliSeconds;

    {@brief   Return the value of the corresponding NuoDB_Temporal
     * data structure as milliseconds.
     *
     * The milliseconds returned will be UTC milliseconds since the common
     * (UNIX) epoch, Jan 1, 1970.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  the number of milliseconds in the SQL TIMESTAMP}
    public type TgetMilliSeconds = function (_this: PNuoDB_Temporal): Int64; stdcall;
    public getMilliSeconds: TgetMilliSeconds;

    {@brief   Set the fractions of a second in the NuoDB_Temporal
     * data structure with the specified number of nanoseconds.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   nanos   a 32-bit integer specifying the fractional
     * part of one second in nanoseconds.}
    public type TsetNanoSeconds = procedure (_this: PNuoDB_Temporal; nanos: Integer); stdcall;
    public setNanoSeconds: TsetNanoSeconds;

    {@brief   Return the value of the fractional part of the
     *          corresponding NuoDB_Temporal data structure as nanoseconds
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @return  the number of nanoseconds in the fraction of seconds
     *          in the NuoDB_Temporal data structure.}
    public type TgetNanoSeconds = function(_this: PNuoDB_Temporal): Integer; stdcall;
    public getNanoSeconds: TgetNanoSeconds;
  end;

{@brief   Create a NuoDB_Temporal data structure for the specified
 * SQL type.
 *
 * The client is expected to call NuoDB_Temporal_free() when it is no
 * longer using the NuoDB_Temporal data structure.}
type TNuoDB_Temporal_create = function (temporalType: NuoDB_Temporal_Type): PNuoDB_Temporal; stdcall;
var NuoDB_Temporal_create: TNuoDB_Temporal_create;

{@brief   Free the NuoDB_Temporal data structure. }
type TNuoDB_Temporal_free = procedure (temporal: PNuoDB_Temporal); stdcall;
var NuoDB_Temporal_free: TNuoDB_Temporal_free;

implementation

end.
