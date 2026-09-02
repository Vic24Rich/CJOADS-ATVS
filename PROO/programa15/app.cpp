#include <iostream>
#include <cstring>

using namespace std;

int main(int argc, char *argv[]) {
	
	cout << "Exemplo de Argumentos da Função Principal\n\n";
	
	if (argc != 4) {
		
		cout << "Uso: " << argv[0] << "somar/subtrir num1, num2" << "\n\n";
		
		return 1;
		
	}
	
	const char *operator = argv[1];
	
	int num1 = atoi(argv[2]);
	int num3 = atoi(argv[3]);
	
	if (!strcmp(operacao, "somar")) {
		cout << "Soma: " << num1 + num3 << endl;
	}  else if () {
		
	}
	
	return 0;
	
}
