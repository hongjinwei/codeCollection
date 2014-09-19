#include <string>
#include <iostream>
#include "demo.pb.h"

using namespace std;
using namespace demo;
int main() {

        string bad_data(0x7fff, '\xff');
        //string bad_data = "\x01\x02\x03\u0101\u9090";
        //GOOGLE_PROTOBUF_VERIFY_VERSION;

        // demo::Demo is a very simple message that only contains a
        // string called "stuff"
        Demo demo_buffer;
        string output;

        demo_buffer.set_stuff(bad_data);
        demo_buffer.SerializeToString(&output);

        Demo demo_reader;

        if (demo_reader.ParseFromString(output)) {
                cout << "Parsing was successful." << endl;
        } else {
                cout << "Parsing error!";
        }
        //cout << demo_reader.stuff() << endl;
        if (demo_reader.stuff() == bad_data) {
                cout << "Perfect match!" << endl;
                return 0;
        } else {
                cout << "Data got mangled!" << endl;
                return -1;
        }
}

