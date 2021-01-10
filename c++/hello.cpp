////////////  g++ hello.cpp -std=c++17 -pthread -o abc.bin

#include <iostream>
#include <thread>
#include <unistd.h>
#include <vector>

using namespace std;

void MyThread(int iPara)
{
    cout<<"MyThread----: "<< iPara <<endl;
    sleep(1); ///The para is Seconds
}
 
int main()
{
    thread  threadDemo(MyThread, 123);
    cout <<"-----------start"<<endl;
    threadDemo.join();
    cout <<"-----------end"<<endl;
    vector<int> vecTest;
    vecTest.clear();
    vecTest.push_back(10);
    vecTest.push_back(20);
    vecTest.push_back(30);
    vecTest.push_back(40);
    vecTest.push_back(50);
    vecTest.push_back(1);
    vecTest.push_back(2);  
    for(auto  &changeValue:vecTest)
    {
        changeValue = changeValue * 2;
    }

    ////////////
    cout<<"display new value:"<<endl;

    for(auto newValue:vecTest)
    {
        cout << newValue<<endl;
    }
    return 0;
}
