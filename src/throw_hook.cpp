#include <cstdio>
#include <cstdlib>
#include <cxxabi.h>
#include <typeinfo>

#include <emscripten/val.h>

// In Emscripten, exceptions aren't really thrown for performance reasons (unless specific compilation
// flags are used, but this cause other compilation problems in this project). Instead, the _cxa_throw()
// function is called, which instantly abort the execution, which means that there is no real way to
// know at runtime where and what the problem was.
//
// Here, we use the wrapping mechanism of the linker to provide our own implemenation of _cxa_throw()
// that print some infos in the console before calling the original implementation.


// Redeclaration of the original _cxa_throw() function (the wraping mecanism add '__real__' before the
// name of the wrapped function)
extern "C" void __real___cxa_throw(void* thrown_exception,
                                   std::type_info* tinfo,
                                   void (*dest)(void*))
    __attribute__((noreturn));


// Our own version of _cxa_throw() (the wraping mecanism add '__wrap__' before the
// name of the wrapped function)
extern "C" void __wrap___cxa_throw(void* thrown_exception,
                                   std::type_info* tinfo,
                                   void (*dest)(void*)) {
    // Print the tyoe of the exception
    const char* name = tinfo ? tinfo->name() : "(unknown)";
    int status = 0;
    char* demangled = abi::__cxa_demangle(name, 0, 0, &status);
    const char* typeName = (status == 0 && demangled) ? demangled : name;

    std::fprintf(stderr, "[__cxa_throw] Exception of type: %s\n", typeName);
    std::fflush(stderr);

    std::free(demangled);

    // Print the stack trace
    emscripten::val::global("console").call<void>("trace");

    // Call the original implementation
    __real___cxa_throw(thrown_exception, tinfo, dest);
}
