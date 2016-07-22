{
  @file databaseMetaData.h
 * @brief Metadata about a NuoDB database.
 */

/*! Metadata about a %NuoDB database.
 *
 * NuoDB_DatabaseMetaData is used to obtain information about a %NuoDB
 * database.
}
unit life.icoder.nuodb.dbmeta;

interface

uses
  life.icoder.nuodb;

type
  PNuoDB_DatabaseMetaData = ^NuoDB_DatabaseMetaData;
  NuoDB_DatabaseMetaData = packed record
    _state: _NuoDB_DatabaseMetaData_state_t;

    {@brief   Returns the connection URL string
     *
     * @param[in]   _this   a pointer to the current (this)
     * NuoDB_DatabaseMetaData data structure.
     *
     * @return  a pointer to the connection string.}
    public type TgetConnectionURL = function(_this: PNuoDB_DatabaseMetaData): PAnsiChar; stdcall;
    public getConnectionURL: TgetConnectionURL;

    {@brief   Returns the Database Product Name string
     *
     * @param[in]   _this   a pointer to the current (this)
     * NuoDB_DatabaseMetaData data structure.
     *
     * @return  a pointer to the Database Product Name or NULL if an error.}
    public type TgetDatabaseProductName = function(_this: PNuoDB_DatabaseMetaData): PAnsiChar; stdcall;
    public getDatabaseProductName: TgetDatabaseProductName;

    {@brief   Returns Database Product Version string
     *
     * @param[in]   _this   a pointer to the current (this)
     * NuoDB_DatabaseMetaData data structure.
     *
     * @return  a pointer to the database product version string or
     * NULL if an error.}
    public type TgetDatabaseProductVersion = function(_this: PNuoDB_DatabaseMetaData): PAnsiChar; stdcall;
    public getDatabaseProductVersion: TgetDatabaseProductVersion;

    {@brief   Returns driver major version number
     *
     * @param[in]   _this   a pointer to the current (this)
     * NuoDB_DatabaseMetaData data structure.
     *
     * @return  a integer for the driver major version number.}
    public type TgetDriverMajorVersion = function(_this: PNuoDB_DatabaseMetaData): Integer; stdcall;
    public getDriverMajorVersion: TgetDriverMajorVersion;

    {@brief   Returns driver minor version number
     *
     * @param[in]   _this   a pointer to the current (this)
     * NuoDB_DatabaseMetaData data structure.
     *
     * @return  a integer for the driver minor version number.}
    public type TgetDriverMinorVersion = function(_this: PNuoDB_DatabaseMetaData): Integer; stdcall;
    public getDriverMinorVersion: TgetDriverMinorVersion;

  end;

implementation

end.
