project(example1)
cmake_minimum_required(VERSION 3.14)

set(SOURCE_FILES main.cpp)

function(add_precompiled_header _target _header)
	message(" ** Calling add_precompiled_header ${_target} ${_header}")
	string(REPLACE ".h" ".gch" _gch_header ${_header})
	message(" ** New precompiled header: ${_gch_header}")
	add_custom_command(OUTPUT "${_gch_header}"
		COMMAND "${CMAKE_CXX_COMPILER}" -x c++-header -o "${_gch_header}" -c "${_header}"
		IMPLICIT_DEPENDS CXX "${_header}"
		COMMENT "Precompiling ${_header} to ${_gch_header} for ${_target} (C++)")

	get_property(_sources TARGET ${_target} PROPERTY SOURCES)
	message(" ** Sources found: ${_sources}")
	foreach(_source ${_sources})
		message(" ** Adding ${_gch_header} as dependency to ${_source}")
		set_property(SOURCE ${_source} APPEND PROPERTY OBJECT_DEPENDS "${_gch_header}")
	endforeach()
endfunction()


add_executable(example1 ${SOURCE_FILES})

# get_property(_target_sources TARGET example1 PROPERTY SOURCES)
# message(" ** sources: ${_target_sources}")

add_precompiled_header(example1 someheader.h)
