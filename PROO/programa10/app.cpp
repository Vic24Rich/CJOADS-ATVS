#include <iostream>

using namespace std;

int main(void) {
	
	cout << "\nExemplo de Alocação Dinâmica de memória\n\n";
	
	int *numeros = new int[5];
	
	for (int i = 0; i < 5; i++) {
		
		numeros[i] = i * 2;
		
	}
	
	cout << "* Numeros: [ ";
	
	for (int i  = 0; i < 5; i++) {
		if (i < 4) {

			cout << numeros[i] << ", ";
			
		} else {
			cout << numeros[i] << " ]";
		}
	}
	
	delete[] numeros;
	
	
	return 0;
	
}
