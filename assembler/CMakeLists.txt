cmake_minimum_required(VERSION 3.5.1) # probably overkill, use whatever version is on your machine I guess
project (WAMP_Assembler C)

include_directories(include)

file(GLOB SOURCES "src/*.c")

add_executable(asm_wamp ${SOURCES})
