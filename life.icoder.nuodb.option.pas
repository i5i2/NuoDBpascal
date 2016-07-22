{
  @file options.h
 * @brief Container for NuoDB_Connection options.
 */

/*! Container for NuoDB_Connection options.
 *
 * NuoDB_Options is a simple container that is used to hold a list of
 * NuoDB_Connection options.  Clients should call the
 * NuoDB_Options_create() function to create this container.  Clients
 * can add name/value pairs to the NuoDB_Options container and then
 * pass the NuoDB_Options to the NuoDB_Connection::openDatabase()
 * function.  Clients should call the NuoDB_Options_free() function to
 * release the container where the client application no longer needs
 * the options.
}
unit life.icoder.nuodb.option;

interface

uses
  life.icoder.nuodb;

type
  PNuoDB_Options = ^NuoDB_Options;
  NuoDB_Options = packed record
    _state: _NuoDB_Options_state_t;

    {@brief   Add an option to the list of options.
     *
     * @param[in]   _this  a pointer to the current "this" data structure.
     * @param[in]   name   a pointer to the option name.
     * @param[in]   value  a pointer to the option value.
     *
     * Add the specified name/value pair to the list of options.  If
     * the specified name exists in the list, then this function will
     * replace the previous value.}
    public type Tadd = procedure (_this: PNuoDB_Options; const name: PAnsiChar; const value: PAnsiChar); stdcall;
    public add: Tadd;

    {@brief   Retrieve an option value.
     *
     * This function looks for the specified option name.  If the
     * option name is found, then this function will return a
     * pointer to the value.  If the name is not found, then this
     * function will return a NULL pointer.
     *
     * @param[in]   _this  a pointer to the current "this" data structure.
     * @param[in]   name   a pointer to the option name.
     *
     * @return  a pointer to the value or NULL if the value does not
     * exist.}
    public type TgetValue = function (_this: PNuoDB_Options; const name: PAnsiChar): PAnsiChar; stdcall;
    public getValue: TgetValue;

    {@brief   Clear the options list.
     *
     * This function will remove all name/value pairs from the
     * specified NuoDB_Options container.
     *
     * @param[in]   _this  a pointer to the current "this" data structure.}
    public type Tclear = procedure (_this: PNuoDB_Options); stdcall;
    public clear: Tclear;

    {@brief   Copy options.
     *
     * This function will copy all of the options from the src
     * container to the current (this) container.
     *
     * @param[in]   _this  a pointer to the current "this" data structure.
     * @param[in]   src    a pointer to the source options.}
    public type Tcopy = procedure (_this: PNuoDB_Options; const src: PNuoDB_Options); stdcall;
    public copy: Tcopy;

    {@brief   Retrieve a count of the options.
     *
     * This function counts the number of options in the specified
     * NuoDB_Options data structure.
     *
     * @param[in]   _this  a pointer to the current "this" data structure.
     *
     * @return  a count of the options or zero (0) if the container is
     * empty.}
    public type TgetCount = function (_this: PNuoDB_Options): Integer; stdcall;
    public getCount: TgetCount;
  end;

{@brief   Create a NuoDB_Options container.
 *
 * This is a factory function for creating NuoDB_Options.
 * NuoDB_Options are a container that holds a list NuoDB Database
 * connection options.  Clients should call the NuoDB_Options_free()
 * function to release the resources held by the NuoDB_Options
 * data structure.}
type TNuoDB_Options_create = function (): PNuoDB_Options; stdcall;
var NuoDB_Options_create: TNuoDB_Options_create;

{@brief   Free NuoDB_Options container.
 *
 * This function is used to free the resources held by the specified
 * NuoDB_Options container.  The client must no use the NuoDB_Options
 * data structure after it has been freed.  The NuoDB_Options data
 * structure can be freed right after it is used by the
 * NuoDB_Connection::openDatabase() function.
 *
 * @param[in]   ops  a pointer to the NuoDB_Options data structure.}
type TNuoDB_Options_free = procedure(ops: PNuoDB_Options); stdcall;
var NuoDB_Options_free: TNuoDB_Options_free;

implementation

end.
