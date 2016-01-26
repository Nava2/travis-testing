

#include <boost/thread/thread.hpp>
#include <iostream>
#include <thread>
#include <chrono>

int main(int argn, char** args) {
    std::cout << "Hello, world!" << std::endl;
    
    std::thread *t = new std::thread([&](){ std::cout << "from thread" << std::endl; });
    
    std::this_thread::sleep_for(std::chrono::seconds(2));
    
    delete t;
}
