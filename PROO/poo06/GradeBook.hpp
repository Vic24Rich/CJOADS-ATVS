#ifndef GRADEBOOK_HPP
#define GRADEBOOK_HPP

#include <string>

using namespace std;

class GradeBook {
	
public:
	
	explicit GradeBook(string name);
	void setCourseName(string name);
	string getCourseName() const;
	void diplayMessage() const;
	
private:
	
	string courseName;
	
};

#endif
