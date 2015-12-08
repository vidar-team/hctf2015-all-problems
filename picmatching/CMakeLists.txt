cmake_minimum_required(VERSION 2.8)

SET(CMAKE_BUILD_TYPE Release CACHE STRING "set build type to release")
SET(CMAKE_INSTALL_PREFIX /tmp CACHE STRING "install prefix")
add_definitions(-std=c++11)
remove_definitions(-g)
project( picmatch )

SET(Boost_USE_STATIC_LIBS    TRUE)
SET(Boost_USE_MULTITHREADED    TRUE)
SET(Boost_USE_STATIC_RUNTIME   TRUE)

SET(OpenCV_DIR /opt/opencv/share/OpenCV)
find_package(Boost REQUIRED serialization iostreams )
find_package(OpenCV REQUIRED )

include_directories(${Boost_INCLUDE_DIR} ${OpenCV_INCLUDE_DIRS} )
add_executable(picmatch archiverhelper.cpp picmatch.cpp)
target_link_libraries( picmatch ${Boost_LIBRARIES} ${OpenCV_LIBS} )

add_custom_command(TARGET ${PROJECT_NAME} POST_BUILD COMMAND objcopy -N -S -R .comment -R .jcr ${PROJECT_NAME})
