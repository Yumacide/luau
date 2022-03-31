# This file is part of the Luau programming language and is licensed under MIT License; see LICENSE.txt for details
if(EXT_PLATFORM_STRING)
    include(EXTLuau.cmake)
    return()
endif()

cmake_minimum_required(VERSION 3.0)

option(LUAU_BUILD_CLI "Build CLI" ON)
option(LUAU_BUILD_TESTS "Build tests" ON)
option(LUAU_BUILD_WEB "Build Web module" OFF)
option(LUAU_WERROR "Warnings as errors" OFF)
option(LUAU_STATIC_CRT "Link with the static CRT (/MT)" OFF)

if(LUAU_STATIC_CRT)
    cmake_minimum_required(VERSION 3.15)
    cmake_policy(SET CMP0091 NEW)
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>")
endif()

project(Luau LANGUAGES CXX C)
add_library(Luau.Ast STATIC)
add_library(Luau.Analysis STATIC)

if(LUAU_BUILD_CLI)
    add_executable(Luau.Analyze.CLI)
    add_executable(Luau.Ast.CLI)

    # This also adds target `name` on Linux/macOS and `name.exe` on Windows
    set_target_properties(Luau.Analyze.CLI PROPERTIES OUTPUT_NAME luau-analyze)
    set_target_properties(Luau.Ast.CLI PROPERTIES OUTPUT_NAME luau-ast)
endif()

include(Sources.cmake)

target_compile_features(Luau.Ast PUBLIC cxx_std_17)
target_include_directories(Luau.Ast PUBLIC Ast/include)

target_compile_features(Luau.Analysis PUBLIC cxx_std_17)
target_include_directories(Luau.Analysis PUBLIC Analysis/include)
target_link_libraries(Luau.Analysis PUBLIC Luau.Ast)

set(LUAU_OPTIONS)

if(MSVC)
    list(APPEND LUAU_OPTIONS /D_CRT_SECURE_NO_WARNINGS) # We need to use the portable CRT functions.
    list(APPEND LUAU_OPTIONS /MP) # Distribute single project compilation across multiple cores
else()
    list(APPEND LUAU_OPTIONS -Wall) # All warnings
endif()

# Enabled in CI; we should be warning free on our main compiler versions but don't guarantee being warning free everywhere
if(LUAU_WERROR)
    if(MSVC)
        list(APPEND LUAU_OPTIONS /WX) # Warnings are errors
    else()
        list(APPEND LUAU_OPTIONS -Werror) # Warnings are errors
    endif()
endif()

target_compile_options(Luau.Ast PRIVATE ${LUAU_OPTIONS})
target_compile_options(Luau.Analysis PRIVATE ${LUAU_OPTIONS})

if(LUAU_BUILD_CLI)
    target_compile_options(Luau.Analyze.CLI PRIVATE ${LUAU_OPTIONS})
    target_compile_options(Luau.Ast.CLI PRIVATE ${LUAU_OPTIONS})

    target_link_libraries(Luau.Analyze.CLI PRIVATE Luau.Analysis)

    target_link_libraries(Luau.Ast.CLI PRIVATE Luau.Ast Luau.Analysis)
endif()