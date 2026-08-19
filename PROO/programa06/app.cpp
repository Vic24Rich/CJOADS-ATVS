#include <iostream>

using namespace std;

int main(void) {
	
	int idade = 25, *idadePtr = &idade, *nomePtr = nullptr;
	
	cout << "1 Valor da <idade>: " << idade << endl;
	cout << "1 Endereco da <idade>: " << &idade << endl;
	cout << "2 Valor da <idadePtr>: " << idadePtr << endl;
	cout << "2 Valor apontado da <idadePtr>: " << *idadePtr << endl;
	cout << "2 Valor da <nomePtr>: " << nomePtr << endl;
	
	
	return 0;
	
}
