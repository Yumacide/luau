# Luau.Ast Sources
target_sources(Luau.Ast PRIVATE
    Ast/include/Luau/Ast.h
    Ast/include/Luau/Common.h
    Ast/include/Luau/Confusables.h
    Ast/include/Luau/DenseHash.h
    Ast/include/Luau/Lexer.h
    Ast/include/Luau/Location.h
    Ast/include/Luau/ParseOptions.h
    Ast/include/Luau/Parser.h
    Ast/include/Luau/ParseResult.h
    Ast/include/Luau/StringUtils.h
    Ast/include/Luau/TimeTrace.h

    Ast/src/Ast.cpp
    Ast/src/Confusables.cpp
    Ast/src/Lexer.cpp
    Ast/src/Location.cpp
    Ast/src/Parser.cpp
    Ast/src/StringUtils.cpp
    Ast/src/TimeTrace.cpp
)

# Luau.Analysis Sources
target_sources(Luau.Analysis PRIVATE
    Analysis/include/Luau/AstQuery.h
    Analysis/include/Luau/Autocomplete.h
    Analysis/include/Luau/BuiltinDefinitions.h
    Analysis/include/Luau/Config.h
    Analysis/include/Luau/Documentation.h
    Analysis/include/Luau/Error.h
    Analysis/include/Luau/FileResolver.h
    Analysis/include/Luau/Frontend.h
    Analysis/include/Luau/IostreamHelpers.h
    Analysis/include/Luau/JsonEncoder.h
    Analysis/include/Luau/Linter.h
    Analysis/include/Luau/LValue.h
    Analysis/include/Luau/Module.h
    Analysis/include/Luau/ModuleResolver.h
    Analysis/include/Luau/Predicate.h
    Analysis/include/Luau/Quantify.h
    Analysis/include/Luau/RecursionCounter.h
    Analysis/include/Luau/RequireTracer.h
    Analysis/include/Luau/Scope.h
    Analysis/include/Luau/Substitution.h
    Analysis/include/Luau/Symbol.h
    Analysis/include/Luau/ToDot.h
    Analysis/include/Luau/TopoSortStatements.h
    Analysis/include/Luau/ToString.h
    Analysis/include/Luau/Transpiler.h
    Analysis/include/Luau/TxnLog.h
    Analysis/include/Luau/TypeAttach.h
    Analysis/include/Luau/TypedAllocator.h
    Analysis/include/Luau/TypeInfer.h
    Analysis/include/Luau/TypePack.h
    Analysis/include/Luau/TypeUtils.h
    Analysis/include/Luau/TypeVar.h
    Analysis/include/Luau/Unifiable.h
    Analysis/include/Luau/Unifier.h
    Analysis/include/Luau/UnifierSharedState.h
    Analysis/include/Luau/Variant.h
    Analysis/include/Luau/VisitTypeVar.h

    Analysis/src/AstQuery.cpp
    Analysis/src/Autocomplete.cpp
    Analysis/src/BuiltinDefinitions.cpp
    Analysis/src/Config.cpp
    Analysis/src/Error.cpp
    Analysis/src/Frontend.cpp
    Analysis/src/IostreamHelpers.cpp
    Analysis/src/JsonEncoder.cpp
    Analysis/src/Linter.cpp
    Analysis/src/LValue.cpp
    Analysis/src/Module.cpp
    Analysis/src/Quantify.cpp
    Analysis/src/RequireTracer.cpp
    Analysis/src/Scope.cpp
    Analysis/src/Substitution.cpp
    Analysis/src/Symbol.cpp
    Analysis/src/ToDot.cpp
    Analysis/src/TopoSortStatements.cpp
    Analysis/src/ToString.cpp
    Analysis/src/Transpiler.cpp
    Analysis/src/TxnLog.cpp
    Analysis/src/TypeAttach.cpp
    Analysis/src/TypedAllocator.cpp
    Analysis/src/TypeInfer.cpp
    Analysis/src/TypePack.cpp
    Analysis/src/TypeUtils.cpp
    Analysis/src/TypeVar.cpp
    Analysis/src/Unifiable.cpp
    Analysis/src/Unifier.cpp
    Analysis/src/EmbeddedBuiltinDefinitions.cpp
)

if(TARGET Luau.Analyze.CLI)
    # Luau.Analyze.CLI Sources
    target_sources(Luau.Analyze.CLI PRIVATE
        CLI/FileUtils.h
        CLI/FileUtils.cpp
        CLI/Analyze.cpp)
endif()

if(TARGET Luau.Ast.CLI)
    target_sources(Luau.Ast.CLI PRIVATE
        CLI/Ast.cpp
        CLI/FileUtils.h
        CLI/FileUtils.cpp
    )
endif()