#include <iostream>
#include <string>

using namespace std;

class GradeBook {
	
	public:
	
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

int main(void) {
	
	cout << "\n>> The Grade Book\n\n";
	
	string coursename;
	
	// Criar o objweto do tipo GradeBook, chamado myGradeBook
	GradeBook myGradeBook;
	
	cout << "* Initial course name is: " << myGradeBook.getCourseName() << endl;
	
	cout << "Digite o nome do seu curso: "; getline(cin, coursename);
	
	myGradeBook.setCourseName(coursename);
	
	// Executa o metodo displayMessage()
	myGradeBook.diplayMessage();
	
	return 0;
	
}
