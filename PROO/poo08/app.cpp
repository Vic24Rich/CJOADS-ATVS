#include <iostream>
#include <iomanip>
#include <stdexcept>

#include "time.hpp"

using namespace std;

int main(void) {
	
	cout << "\n>> Time\n\n";
	
	Time t;
	
	cout << "The initial universal time is ";
	t.printUniversal(); cout << "\n\n";
	
	cout << "The initial standard time is ";
	t.printStandard(); cout << "\n\n";
	
	t.setTime(13, 27, 6);
	
	cout << "The universal time is ";
	t.printUniversal(); cout << "\n\n";
	
	cout << "The standard time is ";
	t.printStandard(); cout << "\n\n";
	
	try {
		t.setTime(99,99,99);
	}
	catch(invalid_argument &e) {
		cout << "\nException: " << e.what();
	}
	
	cout << "\n\nThe universal time is ";
	t.printUniversal(); cout << "\n\n";
	
	cout << "The standard time is ";
	t.printStandard(); cout << "\n\n";
	
	cout << "\n\n";
	
	return 0;
	
}
