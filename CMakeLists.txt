# This file is part of the Luau programming language and is licensed under MIT License; see LICENSE.txt for details
cmake_minimum_required(VERSION 3.0)

project(Luau LANGUAGES CXX)

add_library(Luau.Ast STATIC)
add_library(Luau.Analysis STATIC)

add_library(Luau.Analyze.CLI STATIC)
add_library(Luau.Ast.CLI STATIC)

# This also adds target `name` on Linux/macOS and `name.exe` on Windows
set_target_properties(Luau.Analyze.CLI PROPERTIES OUTPUT_NAME luau-analyze)
set_target_properties(Luau.Ast.CLI PROPERTIES OUTPUT_NAME luau-ast)

set(LUAU_OPTIONS)

if(MSVC)
    list(APPEND LUAU_OPTIONS /D_CRT_SECURE_NO_WARNINGS) # We need to use the portable CRT functions.
    list(APPEND LUAU_OPTIONS /MP) # Distribute single project compilation across multiple cores
else()
    list(APPEND LUAU_OPTIONS -Wall) # All warnings
endif()

include(Sources.cmake)

target_compile_options(Luau.Ast PRIVATE ${LUAU_OPTIONS})
target_compile_options(Luau.Analysis PRIVATE ${LUAU_OPTIONS})
target_compile_options(Luau.Analyze.CLI PRIVATE ${LUAU_OPTIONS})
target_compile_options(Luau.Ast.CLI PRIVATE ${LUAU_OPTIONS})

target_compile_features(Luau.Ast PUBLIC cxx_std_17)
target_include_directories(Luau.Ast PUBLIC Ast/include)

target_compile_features(Luau.Analysis PUBLIC cxx_std_17)
target_include_directories(Luau.Analysis PUBLIC Analysis/include)
target_link_libraries(Luau.Analysis PUBLIC Luau.Ast)

target_link_libraries(Luau.Analyze.CLI PUBLIC Luau.Analysis)

target_link_libraries(Luau.Ast.CLI PUBLIC Luau.Ast Luau.Analysis)

set_property(TARGET Luau.Ast.CLI Luau.Ast Luau.Analyze.CLI Luau.Analysis
             PROPERTY MSVC_RUNTIME_LIBRARY "MultiThreadedDLL")

install(TARGETS Luau.Ast.CLI Luau.Ast Luau.Analyze.CLI Luau.Analysis DESTINATION lib)