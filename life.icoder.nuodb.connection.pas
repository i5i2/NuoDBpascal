{
  connection.h

  @brief NuoDB Database Connection.
}
unit life.icoder.nuodb.connection;

interface

uses
  life.icoder.nuodb,
  life.icoder.nuodb.dbmeta,
  life.icoder.nuodb.option;

type
  // NuoDB Transaction Isolation Levels
  NuoDB_TransactionIsolationLevel = (
    { @brief   Read Committed
     *
     * Each transaction always reads the most recently committed
     * version of a record.
     * See <a href="http://doc.nuodb.com/display/doc/Transactions+and+Isolation+Levels"><strong>
     * Transactions and Isolation Levels</strong></a> for more information.}
    NUODB_TXN_ISOLATION_READ_COMMITTED  = 2,

    { @brief   Write Committed
     *
     * For read operations, each transaction sees the state of the
     * database as it was when the transaction started, plus its
     * own changes, similar to CONSISTENT_READ.
     * For write operations, including SELECT...FOR UPDATE, UPDATE
     * and DELETE), each transaction reads the most recently
     * committed version of a record, similar to READ_COMMITTED. See
     * <a href="http://doc.nuodb.com/display/doc/Transactions+and+Isolation+Levels"><strong>
     * Transactions and Isolation Levels</strong></a> for more information.}
    NUODB_TXN_ISOLATION_WRITE_COMMITTED  = 5,

    { @brief   Consistent Read
     *
     * This is the default %NuoDB transaction isolation
     * level. Each transaction sees a snapshot of the database as
     * of the start of the transaction, plus changes made by that
     * transaction only. See
     * <a href="http://doc.nuodb.com/display/doc/Transactions+and+Isolation+Levels"><strong>
     * Transactions and Isolation Levels</strong></a> for more information.}
    NUODB_TXN_ISOLATION_CONSISTENT_READ = 7, //=====NuoDB Default=====

    { @brief   Serializable
     *
     * This is kept for backward compatibility and will also cause
     * the same behavior as CONSISTENT_READ which is the default
     * %NuoDB transaction isolation level.
     * Each transaction sees a snapshot of the database as of the
     * start of the transaction, plus changes made by that
     * transaction only. See
     * <a href="http://doc.nuodb.com/display/doc/Transactions+and+Isolation+Levels"><strong>
     * Transactions and Isolation Levels</strong></a> for more information.}
    NUODB_TXN_ISOLATION_SERIALIZABLE = 8
  );
  PNuoDB_TransactionIsolationLevel = ^NuoDB_TransactionIsolationLevel;

  {NuoDB Database Connection.
 *
 * NuoDB_Connection is a data structure that represents a connection
 * to a NuoDB Database.  Clients should call the NuoDB_Connection_create()
 * function to create this data structure and then call the openDatabase()
 * function to open a connection to a %NuoDB database.  Clients should
 * call the NuoDB_Connection_free() function to release the
 * NuoDB_Connection when the client application no longer needs the
 * connection.}
  PNuoDB_Connection = ^NuoDB_Connection;
  NuoDB_Connection = packed record
    _state: _NuoDB_Connection_state_t;

     {@fn commit()
    *
    * @brief   Commit any outstanding SQL statements.
    *
    * Makes all changes made since the previous commit/rollback
    * permanent and releases any database locks currently held by
    * this NuoDB_Connection data structure. This function should be
    * used only when auto-commit mode has been disabled.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
    * (integer 0) on success, or a negative integer on failure.}
    public type Tcommit = function (connection: PNuoDB_Connection): NuoDB_Status; stdcall;
    public commit: Tcommit;

    {@brief   Convert the given, presumably UTF-8 string, to the
    *          local encoding using the NuoDB_Connection's active
    *          encoding. See:
    *          NuoDB_Connection::getActiveEncoding().
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    * @param[in]   s            a pointer to the string.
    * @param[in]   sLen         length of the string.
    *
    * @return  a pointer to the converted string or NULL if there was
    * an error.  The client is responsible for freeing this memory.}
    public type TconvertUtf8ToLocal = function (connection: PNuoDB_Connection; const s: PAnsiChar; sLen: NativeUint): PAnsiChar; stdcall;
    public convertUtf8ToLocal: TconvertUtf8ToLocal;

    {@brief   Return the name of the active encoding for this
    *          NuoDB_connection which may not be the same as the
    *          default encoding for this NuoDB_Connection.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  a string that contains the name of the active encoding.}
    public type TgetActiveEncoding = function (connection: PNuoDB_Connection): PAnsiChar; stdcall;
    public getActiveEncoding: TgetActiveEncoding;

    {@brief   Determine if the NuoDB_Connection has the auto-commit
    * flag set.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    * @param[out]  autoCommit   pointer to nuodb_bool_t to set
    * auto-commit value.
    *
    * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
    * (integer 0) on success, or a negative integer on failure.}
    public type TgetAutoCommit = function (connection: PNuoDB_Connection; autoCommit: nuodb_bool_t): NuoDB_Status; stdcall;
    public getAutoCommit: TgetAutoCommit;

    {@brief   Returns the connection version
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  the connection version}
    public type TgetConnectionVersion = function (connection: PNuoDB_Connection): Integer; stdcall;
    public getConnectionVersion: TgetConnectionVersion;

    {@brief   Return the name of the default encoding for this
    * NuoDB_Connection.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  the name of the default encoding}
    public type TgetDefaultEncoding = function (connection: PNuoDB_Connection): PAnsiChar; stdcall;
    public getDefaultEncoding: TgetDefaultEncoding;

    {@brief   Retrieve metadata for the database associated to this
    *          NuoDB_Connection.
    *
    * The metadata includes information about the database's tables, its
    * supported SQL grammar, its stored procedures, the capabilities
    * of this NuoDB_Connection, and so on.
    *
    * The NuoDB_Connection functions manage the memory allocated in
    * the DatabaseMetaData data structure and the caller does not
    * have to do so.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  pointer to a NuoDB_DatabaseMetaData data structure or
    * NULL on error.}
    public type TgetMetaData = function (connection: PNuoDB_Connection): PNuoDB_DatabaseMetaData; stdcall;
    public getMetaData: TgetMetaData;

    {@brief   Retrieves this NuoDB_Connection data structure's
    *          current transaction isolation level
    *
    * The transction isolation level will be one of:
    * <ul>
    * <li>NUODB_TXN_ISOLATION_WRITE_COMMITTED = 5</li>
    * <li>NUODB_TXN_ISOLATION_READ_COMMITTED  = 2</li>
    * <li>NUODB_TXN_ISOLATION_CONSISTENT_READ = 7</li>
    * <li>NUODB_TXN_ISOLATION_SERIALIZABLE    = 8</li>
    * </ul>
    *
    * @param[in]   connection      a pointer to the current (this)
    * NuoDB_Connection data structure.
    * @param[out]  isolationLevel  a pointer to a
    * NuoDB_TransactionIsolationLevel.
    *
    * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
    * (integer 0) on success, or a negative integer on failure.}
    public type TgetTransactionIsolation = function (connection: PNuoDB_Connection; isolationLevel: PNuoDB_TransactionIsolationLevel): NuoDB_Status; stdcall;
    public getTransactionIsolation: TgetTransactionIsolation;

    {@brief   Determine if the client has a valid connection to a
    * %NuoDB TE.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  true if the socket which communicates to the server
    *          exists and is open.}
    public type TisConnected = function (connection: PNuoDB_Connection): nuodb_bool_t; stdcall;
    public isConnected: TisConnected;

    {@brief   Retrieves whether this NuoDB_Connection data structure
    * is in read-only mode.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  true if the database is read-only, otherwise returns
    * false.}
    public type TisReadOnly = function (connection: PNuoDB_Connection): nuodb_bool_t; stdcall;
    public isReadOnly: TisReadOnly;

    {@brief   Retrieves whether this NuoDB_Connection data structure
    * is using UTF-8 strings.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  returns true if the NuoDB_Connection is using UTF-8
    * strings. Otherwise returns false.
    */}
    public type TisUtf8 = function (connection: PNuoDB_Connection): nuodb_bool_t; stdcall;
    public isUtf8: TisUtf8;

    {@brief       Open a database.
    *
    * Given an already existing NuoDB_Connection data structure,
    * clients must call this function to open a database.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    * @param[in]   dbname       a pointer to a const char string
    * representing the database name.
    * @param[in]   user         a pointer to a const char string that
    * contains the database username.
    * @param[in]   password     a pointer to a const char string that
    * contains the database password.
    * @param[in]   options      a pointer to optional NuoDB_Options. If
    * no specific options are needed, the caller can pass a NULL.
    *
    * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
    * (integer 0) on success, or a negative integer on failure.}
    public type TopenDatabase = function (connection: PNuoDB_Connection;
        const dbname: PAnsiChar;
        const user: PAnsiChar;
        const password: PAnsiChar;
        options: PNuoDB_Options
    ): NuoDB_Status; stdcall;
    public openDatabase: TopenDatabase;

    {@brief   Send a ping message to the server. If no error occurs,
    * the server is alive.
    *
    * @param[in]   connection   a pointer to the current (this)
    * NuoDB_Connection data structure.
    *
    * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
    * (integer 0) on success, or a negative integer on failure.}
    public type Tping = function (connection: PNuoDB_Connection): NuoDB_Status; stdcall;
    public ping: Tping;

    {@brief   Roll back any outstanding SQL statements.
     *
     * Undoes all changes made in the current transaction and releases
     * any database locks currently held by this NuoDB_Connection
     * data structure. This function should be used only when
     * auto-commit mode has been disabled.
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type Trollback = function (connection: PNuoDB_Connection): NuoDB_Status; stdcall;
    public rollback: Trollback;

    {@brief   Specify if statements related to this NuoDB_Connection
     *          should be auto-committed.
     *
     * If a NuoDB_Connection is in auto-commit mode, then all its SQL
     * statements will be executed and committed as individual
     * transactions. Otherwise, its SQL statements are grouped into
     * transactions that are terminated by a call to either the
     * function commit() or the function rollback(). By default, new
     * NuoDB_Connections are in auto-commit mode.
     *
     * @param[in]   autoCommit  If true, set autoCommit on and if false, turn
     * autoCommit off
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetAutoCommit = function (connection: PNuoDB_Connection; autoCommit: nuodb_bool_t): NuoDB_Status; stdcall;
    public setAutoCommit: TsetAutoCommit;

    {@brief   Puts this NuoDB_Connection in read-only mode as a hint
     *          to enable database optimizations.
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     * @param[in]   readOnly     a boolean that indicates the
     * read-only mode.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetReadOnly = function (connection: PNuoDB_Connection; readOnly: nuodb_bool_t): NuoDB_Status; stdcall;
    public setReadOnly:  TsetReadOnly;

    {@brief   Change the transaction isolation level for this
     *          NuoDB_Connection data structure to the one specified.
     *
     * Valid transaction isolation levels are:
     * <ul>
     * <li>NUODB_TXN_ISOLATION_WRITE_COMMITTED = 5</li>
     * <li>NUODB_TXN_ISOLATION_READ_COMMITTED  = 2</li>
     * <li>NUODB_TXN_ISOLATION_CONSISTENT_READ = 7</li>
     * <li>NUODB_TXN_ISOLATION_SERIALIZABLE    = 8</li>
     * </ul>
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetTransactionIsolation = function (connection: PNuoDB_Connection; level: NuoDB_TransactionIsolationLevel): NuoDB_Status; stdcall;
    public setTransactionIsolation: TsetTransactionIsolation;

    {@brief   Specify a non-default encoding for this client
     * NuoDB_Connection.
     *
     * %NuoDB uses ICU (International Components for Unicode) for converting
     * strings from the local client environment to UTF-8. %NuoDB Transaction
     * Engines require all strings to be UTF-8. setConverter() allows you to
     * specify a non-default character set table (encoding) that is being used
     * by the client. This may have options appended to the string. IANA alias
     * character set names, IBM CCSIDs starting with "ibm-", Windows codepage
     * numbers starting with "windows-" are frequently ' used for this
     * parameter.  See
     * <a href="http://icu-project.org/apiref/icu4c/ucnv_8h.html#a485c78d4149165f504effa2287717e41">
     * <strong>ICU ucnv_open()</strong></a> for more information.
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     * @param[in]   encoding    Name of a non-default character set table.
     * If this parameter is NULL, the default converter will be used.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetConverter = function (connection: PNuoDB_Connection; const encoding: PAnsiChar): NuoDB_Status; stdcall;
    public setConverter: TsetConverter;

    {@brief   Specify a non-default encoding for this client
     *          NuoDB_Connection and set it as the default for the
     *          connection.
     *
     * %NuoDB uses ICU (International Components for Unicode) for converting
     * strings from the local client environment to UTF-8. %NuoDB Transaction
     * Engines require all strings to be UTF-8. setDefaultConverter()
     * allows you to specify a non-default character set table
     * (encoding) that is being used by the client. This may have
     * options appended to the string. IANA alias character set names,
     * IBM CCSIDs starting with "ibm-", Windows codepage numbers
     * starting with "windows-" are frequently used for this
     * parameter. See
     * <a href="http://icu-project.org/apiref/icu4c/ucnv_8h.html#a485c78d4149165f504effa2287717e41">
     * <strong>ICU ucnv_open()</strong></a> for more information.
     *
     * setDefaultConverter() will set the NuoDB_Connections default
     * converter to that for the given encoding. Future calls to
     * getDefaultEncoding() will return this new default encoding.
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     *
     * @param[in]   encoding    Name of a non-default character set table.
     *                      If this parameter is NULL, the default converter
     *                      will be used.
     *
     * @return  Enumerated integer NuoDB_Status.  NUODB_SUCCESS
     * (integer 0) on success, or a negative integer on failure.}
    public type TsetDefaultConverter = function (connection: PNuoDB_Connection; const encoding: PAnsiChar): NuoDB_Status; stdcall;
    public setDefaultConverter: TsetDefaultConverter;

    { @internal }
    public type TgetProtocolVersion = function (connection: PNuoDB_Connection): Integer; stdcall;
    public getProtocolVersion: TgetProtocolVersion;

    {@brief   Returns the connection URL string
     *
     * @param[in]   connection   a pointer to the current (this)
     * NuoDB_Connection data structure.
     *
     * @return  a pointer to the connection string.}
    public type TgetConnectionURL = function (connection: PNuoDB_Connection): PAnsiChar; stdcall;
    public getConnectionURL: TgetConnectionURL;
  end;

{@brief  Create a NuoDB_Connection to the %NuoDB database.
*
* In order to perform operations on a %NuoDB database, you need to
* create a NuoDB_Connection by calling NuoDB_Connection_create(), and
* then call the NuoDB_Connection::openDatabase() function to
* establish a connection to the specified database.
*
* When clients are finished with the database connection, they should
* call NuoDB_Connection_free() to release the resources held by the
* NuoDB_Connection.
*
* @return  a pointer to a NuoDB_Connection data structure or NULL if
* there was any error.}
type TNuoDB_Connection_create = function (): PNuoDB_Connection; stdcall;
var NuoDB_Connection_create: TNuoDB_Connection_create;

{@brief   Create a NuoDB_Connection to the %NuoDB database with
* UTF-8 string encoding.
*
* This overloading will assumes strings being passed from the client
* to the %NuoDB TE will be UTF-8 despite the encoding set in the
* user's local environment.
*
* @return  a pointer to a NuoDB_Connection data structure or NULL if
* there was any error.}
type TNuoDB_Connection_createUtf8 = function (): PNuoDB_Connection; stdcall;
var NuoDB_Connection_createUtf8: TNuoDB_Connection_createUtf8;

{@brief   Frees the connection to the database
*
* Clients should call NuoDB_Connection_free() on the NuoDB_Connection
* data structure when the client is finished with the specified
* NuoDB_Connection.
*
* @param[in]   connection   a pointer to the current (this) NuoDB_Connection
* data structure.}
type TNuoDB_Connection_free = procedure (connection: PNuoDB_Connection); stdcall;
var NuoDB_Connection_free: TNuoDB_Connection_free;

implementation

end.
