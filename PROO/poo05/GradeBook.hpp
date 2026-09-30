#include <iostream>
#include <string>

using namespace std;

class GradeBook {
	
public:
	
	explicit GradeBook(string name) : courseName(name) {}
	
	void setCourseName(string name) {
		
		courseName = name;
		
	}
	
	string getCourseName() const {
		
		return courseName;
		
	}
	
	void diplayMessage() const {
		
		cout << "Welcome to the Grade Book for " << courseName << "!" << endl;
		
	};
	
private:
	
	string courseName;
	
};
