{
              NuoDB C Driver API 整体架构设计
 *
 * The NuoDB C driver provides a C language API for connecting to
 * NuoDB Database and executing SQL statements.
 *
 * The NuoDB C Driver API contains C-Language data structures that
 * represent functional types.  The functional types are object
 * oriented because they contain separate "state" and "methods".  All
 * functional types have an internal data field named "_state", which
 * should not be used by client applications.  The functional types
 * also have data fields that are function pointers, which are the
 * methods provided by that functional type.  All functional methods
 * take, as their first argument, a "this" pointer.  Which is similar
 * to the "this" pointer in C++ member function.  Clients are expected
 * to pass the functional type's current instance as the "this"
 * pointer.
 *
 * The following is a list of the functional types:
 *
 * @li NuoDB_Connection
 * @li NuoDB_DatabaseMetaData
 * @li NuoDB_Error
 * @li NuoDB_Lob
 * @li NuoDB_Options
 * @li NuoDB_ResultSet
 * @li NuoDB_ResultSetMetaData
 * @li NuoDB_Statement
 * @li NuoDB_Temporal
 *
 * There are global factory functions for creating some of those
 * functional types.  The factory functions are named in the format:
 * <functional-type>_Create().  Calling one of the *_Create()
 * functions will construct an initialized functional type.
 *
 * There are global "Free" functions that are used to release all
 * resources held by a functional type. The free functions are named
 * in the format: <functional-type>_Free().  The client application is
 * expected to free functional objects when it is finished using them.
}
unit life.icoder.nuodb;

interface

type
  PInt16 = ^Int16;

//=======================NuoDB.h==================================

type
  Pnuodb_bool_t = ^nuodb_bool_t;
  nuodb_bool_t = AnsiChar;  //typedef unsigned char   nuodb_bool_t;
const
  NUODB_TRUE = 1; //#define NUODB_TRUE  1
  NUODB_FALSE = 0; //#define NUODB_FALSE 0
  NUODB_CDRIVER_MAJOR_VERSION = 2; //#define NUODB_CDRIVER_MAJOR_VERSION 2
  NUODB_CDRIVER_MINOR_VERSION = 3; //#define NUODB_CDRIVER_MINOR_VERSION 3

//=======================structs.h==================================

type
  //* @internal object state
  _NuoDB_Connection_state_t = Pointer;
  _NuoDB_DatabaseMetaData_state_t = Pointer;
  _NuoDB_Error_state_t = Pointer;
  _NuoDB_Lob_state_t = Pointer;
  _NuoDB_ResultSet_state_t = Pointer;
  _NuoDB_Statement_state_t = Pointer;
  _NuoDB_Temporal_state_t = Pointer;
  _NuoDB_ResultSetMetaData_state_t = Pointer;
  _NuoDB_Options_state_t = Pointer;

type
  {Status codes used by the C-Language API}
  NuoDB_Status = (
    NUODB_NO_DATA = 1,   //!< indicates when is is no more data */
    NUODB_SUCCESS = 0,   //!< success */
    NUODB_SYNTAX_ERROR = -1, //!< SQL syntax error, Example: "wrong number of arguments for function" */
    NUODB_FEATURE_NOT_YET_IMPLEMENTED = -2, //!< Feature is not yet implemented */
    NUODB_BUG_CHECK = -3,  //!< An internal database error has occurred */
    NUODB_COMPILE_ERROR = -4, //!< An error has occurred during compilation of the SQL statement,
                              //   Example: "inconsistent select list in union branches" */
    NUODB_RUNTIME_ERROR = -5, //!< An error has occurred during execution of an SQL statement,
                              //   Example: "ResultSet has been closed" */
    NUODB_OCS_ERROR = -6, //!< Unused */
    NUODB_NETWORK_ERROR = -7, //!< A network communication has occurred, either with the Broker
                              //   or TE, Example: "no nodes are available for database" */
    NUODB_CONVERSION_ERROR = -8, //!< An conversion error has occurred during execution of an SQL
                                 //   statement, Example: "Numeric overflow converting..." */
    NUODB_TRUNCATION_ERROR = -9, //!< A truncation error has occurred during execution of an SQL
                                 //   statement, Example: "Assignment of n bytes into type of maximum
                                 //   length m" */
    NUODB_CONNECTION_ERROR = -10, //!< Error related to making an SQL connection or to an already
                                  //       existing SQL connection, Examples: "database already open",
                                 //        "bad statement handle" */
    NUODB_DDL_ERROR = -11, //!< A runtime error has occurred during execution of an SQL DDL
                           //   statement, Example: "table already defined" */
    NUODB_APPLICATION_ERROR = -12, //!< An application specific error has occurred, Example: "Cannot
                                   //   execute PreparedStatement with SQL parameter"*/
    NUODB_SECURITY_ERROR = -13, //!< A database security error has occurred, such as bad credentials,
                                //    Examples: "no username specified", "not a known user", "requested
                                //   access to foo is denied", "Unsupported cipher requested"*/
    NUODB_DATABASE_CORRUPTION = -14, //!< Unused */
    NUODB_VERSION_ERROR = -15, //!< Unused */
    NUODB_LICENSE_ERROR = -16, //!< Unused */
    NUODB_INTERNAL_ERROR = -17, //!< An internal error has occurred. This should never happen.
                                //   Examples: "function hasn't been compiled", "Unexpected NULL lower
                                //   bound node" */
    NUODB_DEBUG_ERROR = -18, //!< Unused */
    NUODB_LOST_BLOB = -19, //!< Unused */
    NUODB_INCONSISTENT_BLOB = -20, //!< Unused */
    NUODB_DELETED_BLOB = -21, //!< Unused */
    NUODB_LOG_ERROR = -22, //!< Unused */
    NUODB_DATABASE_DAMAGED = -23, //!< Unused */
    NUODB_UPDATE_CONFLICT = -24, //!< Server error has occurred, Example: "pending update
                                 //   rejected, transaction nnn" */
    NUODB_NO_SUCH_TABLE = -25, //!< An invalid table reference has occurred, Examples: "Table has
                               //   been dropped", "Can't find table" */
    NUODB_INDEX_OVERFLOW = -26, //!< Unused */
    NUODB_UNIQUE_DUPLICATE = -27, //!< Server error regarding duplicate values in a unique index" */
    NUODB_UNCOMMITTED_UPDATES = -28,
    NUODB_DEADLOCK = -29, //!< Server deadlock error */
    NUODB_OUT_OF_MEMORY_ERROR = -30, //!< Unused */
    NUODB_OUT_OF_RECORD_MEMORY_ERROR = -31, //!< Unused */
    NUODB_LOCK_TIMEOUT = -32, //!< Unused */
    NUODB_PLATFORM_ERROR = -36, //!< Generic server error */
    NUODB_NO_SCHEMA = -37, //!< An error occurred because no schema specified where schema is required. */
    NUODB_CONFIGURATION_ERROR = -38, //!< Server configuration error, Example: "Could not find a
                                     //   valid archive at the given location" */
    NUODB_READ_ONLY_ERROR = -39, //!< An error occurred where an attempt was made to write to a read
                                 //   only connection. */
    NUODB_NO_GENERATED_KEYS = -40, //!< Unused */
    NUODB_THROWN_EXCEPTION = -41, //!< This is used by the SQL THROW control statement */
    NUODB_INVALID_TRANSACTION_ISOLATION = -42, //!< Unused */
    NUODB_UNSUPPORTED_TRANSACTION_ISOLATION = -43, //!< An error occurred where the transaction level specified for
                                                   //   connection is unsupported */
    NUODB_INVALID_UTF8 = -44, //!< An error occurred where a string that is expected to be UTF-8
                              //   is not */
    NUODB_CONSTRAINT_ERROR = -45, //!< A SQL constraint violation has occurred */
    NUODB_UPDATE_ERROR = -46, //!< An attempt was made to update a database object that cannot be
                              //   updated, Example: "Table returned by a stored procedure cannot be
                              //   manipulated" */
    NUODB_I18N_ERROR = -47, //!< An error having to do with Internationalization has occurred,
                            //   Example: "Error getting default converter" */
    NUODB_OPERATION_KILLED = -48, //!< A SQL operation was killed, perhaps by the KILL STATEMENT
                                  //   command */
    NUODB_INVALID_STATEMENT = -49, //!< An invalid reference to a SQL statement occurred, Example: "On
                                   //   connection n, Unable to kill statement m. No such statement id" */
    NUODB_IS_SHUTDOWN = -50, //!< An error occurred because the database is shutting down. */
    NUODB_IN_QUOTED_STRING = -51, //!< An internal error generated by parser when the statement string
                                  //   ends within a quoted string = used by nuosql, */
    NUODB_BATCH_UPDATE_ERROR = -52, //!< Catchall for Batch update exceptions */
    NUODB_JAVA_ERROR = -53, //!< An error has occurred, related to Java stored procedures */
    NUODB_INVALID_FIELD = -54, //!< A server error setting a value to an invalid field */
    NUODB_INVALID_INDEX_NULL = -55, //!< An invalid null was inserted into index */
    NUODB_INVALID_OPERATION = -56, //!< A generic error related to an invalid operation, Examples:
                                   //   "Maximum number of open result sets exceeded", "Maximum number of
                                   //   open statements exceeded" */
    NUODB_INVALID_STATISTICS = -57, //!< Index statistics for a specified query have become invalid */
    NUODB_FINAL_ENUM_MEMBER_IS_UNUSED = -58
  );

implementation

end.
