cmake_minimum_required(VERSION 3.13)
project(RPi-Shutdown-and-Restart-Example)

set(CMAKE_CXX_STANDARD 20)

add_executable(RPi-Shutdown-and-Restart-Example src/main.cpp)

install(TARGETS RPi-Shutdown-and-Restart-Example RUNTIME DESTINATION bin)

enable_testing()
