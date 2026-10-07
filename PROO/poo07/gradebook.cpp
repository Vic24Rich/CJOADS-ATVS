#include <iostream>
#include "GradeBook.hpp"

using namespace std;

GradeBook::GradeBook(string name) : courseName(name) {
	
	setCourseName(name);
	
}

// ------------------------------------------------------------------------------

void GradeBook::setCourseName(string name) {
	
	if (name.size() <= 25) {
		
		courseName = name;
		
	} else {
		
		courseName = name.substr(0,24);
		
		cerr << "Wrning: name \"" << name << "\" exceeds maximun length (25). " << "Limiting courseName to first 25 characters.\n\n";
		
	}
	
}

// ------------------------------------------------------------------------------

string GradeBook::getCourseName() const {
	
	return courseName;
	
}

// ------------------------------------------------------------------------------

void GradeBook::diplayMessage() const {
	
	cout << "Welcome to the Grade Book for " << courseName << "!" << endl;
	
};
