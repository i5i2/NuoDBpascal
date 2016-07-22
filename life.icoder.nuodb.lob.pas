{
  @file lob.h
 * @brief NuoDB Large Object.
}
unit life.icoder.nuodb.lob;

interface

uses
  life.icoder.nuodb,
  life.icoder.nuodb.connection;

type
  {Large object types used by NuoDB_Lob}
  NuoDB_Lob_Type = (
    { @brief Representation of a Binary Large Object value to be stored
    * as a column value in a row of a table.
    *
    * A SQL BLOB is a built-in data type that stores a Binary Large
    * Object as a column value in a row of a database table.
    *
    * See <a href="http://doc.nuodb.com/display/doc/Binary+Data+Types"><strong>Binary Data Types</strong></a>
    * in the NuoDB Documentation for more information about this data type.}
    NUODB_BLOB_TYPE = 1,


    { @brief Representation of a Character Large Object (CLOB) value to be
    * stored as a column value in a row of a table.
    *
    * A SQL CLOB is a built-in data type that stores a Character Large
    * Object as a column value in a row of a database table.}
    NUODB_CLOB_TYPE = 2,

    { @brief Representation of Binary to be stored as a column value in a
    * row of a table.
    *
    * A SQL BINARY is a built-in data type that stores a Bytes as a
    * column value in a row of a database table}
    NUODB_BYTES_TYPE = 3
  );

type
  {%NuoDB Large Object
 *
 * NuoDB_Lob is a container which is used to represent any of the
 * following SQL Lob types:}
  PPNuoDB_Lob = ^PNuoDB_Lob;
  PNuoDB_Lob = ^NuoDB_Lob;
  NuoDB_Lob = packed record
    _state: _NuoDB_Lob_state_t;

    {@brief   Returns the current length of the Lob data.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  length of Lob data in bytes.}
    public type TgetLength = function (_this: PNuoDB_Lob): NativeUInt; stdcall;
    public getLength: TgetLength;

    {@brief   Gets a pointer to Lob data.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  a pointer to the Lob data as an array of bytes.}
    public type TgetData = function (_this: PNuoDB_Lob): PAnsiChar; stdcall;
    public getData: TgetData;

    {@brief   Sets a pointer to client's data buffer.
     *
     * Makes a shallow copy of the client data pointer.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   buffer  Client data pointer as an array of bytes.
     * @param[in]   len     Data length in bytes.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetData = function (_this: PNuoDB_Lob; const buffer: PAnsiChar; len: NativeUInt): NuoDB_Status; stdcall;
    public setData: TsetData;

    {@brief   Returns the type of Lob data.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  pointer to Lob type.}
    public type TgetType = function (_this: PNuoDB_Lob): NuoDB_Lob_Type; stdcall;
    public getType: TgetType;
  end;

{@brief   Create a NuoDB_Lob data structure.
 *
 * NuoDB_Lob is a container for various Large Objects.  Clients must
 * create a NuoDB_Lob data structure when passing any of the
 * following Large Object types to a prepared statement.  It is the
 * responsibility of the caller to call NuoDB_Lob_free() when
 * the caller is finished with it.
 *
 * @param[in]   connection    a pointer to the connection.
 * @param[in]   type          valid types are:
 * <ul>
 * <li>NUODB_BLOB_TYPE  = 1</li>
 * <li>NUODB_CLOB_TYPE  = 2</li>
 * <li>NUODB_BYTES_TYPE = 3</li>
 * </ul>
 *
 * @return  a pointer to a NuoDB_Lob data structure}
type TNuoDB_Lob_create = function (connection: PNuoDB_Connection; type_: NuoDB_Lob_Type): PNuoDB_Lob; stdcall;
var NuoDB_Lob_create: TNuoDB_Lob_create;


{@brief   Free a NuoDB_Lob data structure.
 *
 * Clients should call this function to free the NuoDB_Lob.}
type TNuoDB_Lob_free = procedure (lob: PNuoDB_Lob); stdcall;
var NuoDB_Lob_free: TNuoDB_Lob_free;

implementation

end.
