#include <iostream>

using namespace std;

class GradeBook {
	
public: 
	
	void diplayMessage() {
		
		cout << "Welcome to the Grade Book!" << endl;
		
	};
	
};

int main(void) {
	
	cout << "\n>> The Grade Book\n\n";
	
	// Criar o objweto do tipo GradeBook, chamado myGradeBook
	GradeBook myGradeBook;
	
	// Executa o metodo displayMessage()
	myGradeBook.diplayMessage();
	
	return 0;
	
}
