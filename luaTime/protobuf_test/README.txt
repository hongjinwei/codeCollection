Installation
==============================
remember:sudo ldconfig



protoc -I=$SRC_DIR --cpp_out=$DST_DIR $SRC_DIR/addressbook.proto

g++ -o main main.cpp demo.pb.cc -lprotobuf

