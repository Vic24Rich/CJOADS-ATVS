#include <iostream>
#include "GradeBook.hpp"

using namespace std;

GradeBook::GradeBook(string name) : courseName(name) {}

// ------------------------------------------------------------------------------

void GradeBook::setCourseName(string name) {
	
	courseName = name;
	
}

// ------------------------------------------------------------------------------

string GradeBook::getCourseName() const {
	
	return courseName;
	
}
	
void GradeBook::diplayMessage() const {
	
	cout << "Welcome to the Grade Book for " << courseName << "!" << endl;
	
};
