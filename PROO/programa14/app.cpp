#include <iostream>

using namespace std;

int main(int argc, char* argv[]) {
	
	cout << "Exemplo de Argumentos da Função Principal\n\n";
	
	for (int i = 0; i < argc; i++) {
		
		cout << "Argumento  " << i << ": " << argv[i] << "\n";
		
	}
	
	return 0;
	
}
