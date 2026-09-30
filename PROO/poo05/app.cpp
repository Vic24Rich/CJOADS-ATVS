#include <iostream>
#include <string>

#include "GradeBook.hpp"

using namespace std;

int main(void) {
	
	cout << "\n>> The Grade Book\n\n";
	
	// Cria 2 obj do tipo Gradebook
	GradeBook gradeBook1("CS101 Introduction to C++ Programing");
	GradeBook gradeBook2("CS102 Data Structures in C++");
	
	// Criar o objweto do tipo GradeBook, chamado myGradeBook
	cout << "* gradeBook1 create for course: " << gradeBook1.getCourseName() << endl;
	cout << "* gradeBook2 create for course: " << gradeBook2.getCourseName() << endl;
	
	
	
	return 0;
	
}
