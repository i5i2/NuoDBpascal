{
  @file resultSetMetaData.h
 * @brief Metadata for a NuoDB_ResultSet.
}
unit life.icoder.nuodb.rsmeta;

interface

uses
  life.icoder.nuodb;

type
  {Constant SQL types used by the C-Language API.}
  PNuoDB_Type = ^NuoDB_Type;
  NuoDB_Type = (
    NUODB_TYPE_NULL          = 0,     //< Represents SQL value NULL (0) */
    NUODB_TYPE_BIT           = -7,    //< Type code representing the SQL type BIT (-7) */
    NUODB_TYPE_TINYINT       = -6,    //< Type code representing the SQL type BYTE (-6) */
    NUODB_TYPE_SMALLINT      = 5,     //< Type code representing the SQL type SMALLINT (5) */
    NUODB_TYPE_INTEGER       = 4,     //< Type code representing the SQL type INTEGER (4) */
    NUODB_TYPE_BIGINT        = -5,    //< Type code representing the SQL type BIGINT (-5) */
    NUODB_TYPE_FLOAT         = 6,     //< Type code representing the SQL type FLOAT (6) */
    NUODB_TYPE_DOUBLE        = 8,     //< Type code representing the SQL type DOUBLE (8) */
    NUODB_TYPE_CHAR          = 1,     //< Type code representing the SQL type CHAR (1) */
    NUODB_TYPE_VARCHAR       = 12,    //< Type code representing the SQL type VARCHAR (12) */
    NUODB_TYPE_LONGVARCHAR   = -1,    //< Type code representing the SQL type LONGVARCHAR (-1) */
    NUODB_TYPE_DATE          = 91,    //< Type code representing the SQL type DATE (91) */
    NUODB_TYPE_TIME          = 92,    //< Type code representing the SQL type TIME (92) */
    NUODB_TYPE_TIMESTAMP     = 93,    //< Type code representing the SQL type TIMESTAMP (93) */
    NUODB_TYPE_BLOB          = 2004,  //< Type code representing the SQL type BLOB (2004) */
    NUODB_TYPE_CLOB          = 2005,  //< Type code representing the SQL type CLOB (2005) */
    NUODB_TYPE_NUMERIC       = 2,     //< Type code representing the SQL type NUMERIC (2) */
    NUODB_TYPE_DECIMAL       = 3,     //< Type code representing the SQL type DECIMAL (3) */
    NUODB_TYPE_BOOLEAN       = 16,    //< Type code representing the SQL type BOOLEAN (16) */
    NUODB_TYPE_BINARY        = -2,    //< Type code representing the SQL type BINARY (-2) */
    NUODB_TYPE_LONGVARBINARY = -4     //< Type code representing the SQL type LONGVARBINARY (-4) */
  );

  {Data structure used to obtain metadata for a NuoDB_ResultSet.
 *
 * An data structure that can be used to get information
 * about the types and properties of the columns in a
 * NuoDB_ResultSet data structure.}
  PNuoDB_ResultSetMetaData = ^NuoDB_ResultSetMetaData;
  NuoDB_ResultSetMetaData = packed record
    _state: _NuoDB_ResultSetMetaData_state_t;

    {@brief   Gets the designated column's table's schema
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  schema name or "" if not applicable}
    public type TgetSchemaName = function (_this: PNuoDB_ResultSetMetaData; index: Integer): PAnsiChar; stdcall;
    public getSchemaName: TgetSchemaName;

    {@brief   Gets the designated column's table name.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  table name or "" if not applicable}
    public type TgetTableName = function (_this: PNuoDB_ResultSetMetaData; index: Integer): PAnsiChar; stdcall;
    public getTableName: TgetTableName;

    {@brief   Gets the designated column's name.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  column name}
    public type TgetColumnName = function (_this: PNuoDB_ResultSetMetaData; index: Integer): PAnsiChar; stdcall;
    public getColumnName: TgetColumnName;

    {@brief   Gets the designated column's suggested title for use in
     *          printouts and displays.
     *
     * The suggested title is usually specified by the SQL AS clause.
     * If a SQL AS is not specified, the value returned from
     * getColumnLabel() will be the same as the value returned by
     * getColumnName()
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  the column label}
    public type TgetColumnLabel = function (_this: PNuoDB_ResultSetMetaData; index: Integer): PAnsiChar; stdcall;
    public getColumnLabel: TgetColumnLabel;

    {@brief   Get the designated column's number of digits to the
     *          right of the decimal point
     *
     * 0 is returned for data types where the scale is not applicable
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  scale}
    public type TgetScale = function (_this: PNuoDB_ResultSetMetaData; index: Integer): Integer; stdcall;
    public getScale: TgetScale;

    {@brief   Get the designated column's specified column size
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  precision}
    public type TgetPrecision = function (_this: PNuoDB_ResultSetMetaData; index: Integer): Integer; stdcall;
    public getPrecision: TgetPrecision;

    {@brief   Get the designated column's specified column size
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  precision}
    public type TgetColumnDisplaySize = function (_this: PNuoDB_ResultSetMetaData; index: Integer): Integer; stdcall;
    public getColumnDisplaySize: TgetColumnDisplaySize;

    {@brief   Retrieves the designated colunmn's SQL type
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2,
     * ...
     * @param[out]  columnType  pointer to the NuoDB_Type which is set
     * to the column's SQL type.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TgetColumnType = function (_this: PNuoDB_ResultSetMetaData; index: Integer; columnType: PNuoDB_Type): NuoDB_Status; stdcall;
    public getColumnType: TgetColumnType;

    {@brief   Retrieves the designated colunmn's type name
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  the columnn type name}
    public type TgetColumnTypeName = function (_this: PNuoDB_ResultSetMetaData; index: Integer): PAnsiChar; stdcall;
    public getColumnTypeName: TgetColumnTypeName;

    {@brief   returns the number of columns in this ResultSet data structure
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     *
     * @return  the number of columns}
    public type TgetColumnCount = function (_this: PNuoDB_ResultSetMetaData; index: Integer): Integer; stdcall;
    public getColumnCount: TgetColumnCount;

    {@brief   Indicates whether the designated column is auto increment.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  true if so and false otherwise}
    public type TisAutoIncrement = function (_this: PNuoDB_ResultSetMetaData; index: Integer): nuodb_bool_t; stdcall;
    public isAutoIncrement: TisAutoIncrement;

    {@brief   Indicates whether it is possible for a write on the designated
     *          column to succeed.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  true if possibly writable and false otherwise}
    public type TisWritable = function (_this: PNuoDB_ResultSetMetaData; index: Integer): nuodb_bool_t; stdcall;
    public isWritable: TisWritable;

    {@brief   Indicates whether the designated column is definitely
     * not writable.
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  true if not writable and false otherwise}
    public type TisReadOnly = function (_this: PNuoDB_ResultSetMetaData; index: Integer): nuodb_bool_t; stdcall;
    public isReadOnly: TisReadOnly;

    {@brief   Indicates the nullability of values in the designated column
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  true if the column is nullable and false otherwise}
    public type TisNullable = function (_this: PNuoDB_ResultSetMetaData; index: Integer): nuodb_bool_t; stdcall;
    public isNullable: TisNullable;

    {@brief   Gets the maximum column width which would be the larger of the
     *          length of the value stored in the designated column and the
     *          declared length of the column
     *
     * @param[in]   _this   a pointer to the current (this) data structure.
     * @param[in]   index   the first column is 1, the second is 2, ...
     *
     * @return  the max length}
    public type TgetCurrentColumnMaxLength = function (_this: PNuoDB_ResultSetMetaData; index: Integer): Integer; stdcall;
    public getCurrentColumnMaxLength: TgetCurrentColumnMaxLength;
  end;

implementation

end.
