// --------------------------------------------------------------------------------
// Programa 03: Programa que 
//
// Programa que 
// --------------------------------------------------------------------------------

#include <iostream>
#include <iomanip>

using namespace std;

// Global e Constantes
float PI = 3.1415926535897932384326, raio, n1, n2, n3, n4, resultado;

// Prototipos de Função
void entrada1();
void entrada2();
void saida(string operacao);
void pausa();
void diametro();
void circuferencia();
void media();
void mediana();

//Formartação de texto
void cabecalho1() {
	cout << "\n";
	cout << "---------------------" << endl;
	cout << " Progrma Calculadoras " << endl;
	cout << "   Menu Principal    " << endl;
	cout << "---------------------" << endl;
	cout << "\n";
}

void cabecalho2() {
	cout << "\n";
	cout << "-----------------------------------" << endl;
	cout << " Progrma de Calculos de um Circulo " << endl;
	cout << "          Menu Principal           " << endl;
	cout << "-----------------------------------" << endl;
	cout << "\n";
}

void cabecalho3() {
	cout << "\n";
	cout << "-----------------------------" << endl;
	cout << " Progrma de Calculo de Notas " << endl;
	cout << "       Menu Principal        " << endl;
	cout << "-----------------------------" << endl;
	cout << "\n";
}

// Funçao principal
int main(void) {
	
	int opcoes = 0;
	
	while(opcoes != 3){
		
		int opcao = 0;
		
		// Formatação
		cout << setprecision(2);
		cout << setiosflags(ios::right);
		cout << setiosflags(ios::fixed);
		
		cabecalho1();
		
		// Opções de menu
		cout << "[1] - Calculos de um Circulo" << endl;
		cout << "[2] - Calculo de Notas" << endl;
		cout << "[3] - Encerrar o Programa" << endl;
		cout << "\n";
		
		cout << "=> Escolha uma opcao: ";
		cin >> opcoes;
		cout << "\n";
		
		switch (opcoes) {
		case 1:
			
			while(opcao != 3){
				
				// Formatação
				cout << setprecision(2);
				cout << setiosflags(ios::right);
				cout << setiosflags(ios::fixed);
				
				cabecalho2();
				
				// Opções de menu
				cout << "[1] - Circuferencia" << endl;
				cout << "[2] - Diametro" << endl;
				cout << "[3] - Encerrar este Programa" << endl;
				cout << "\n";
				
				cout << "=> Escolha uma opcao: ";
				cin >> opcao;
				cout << "\n";
				
				switch (opcao) {
					
				case 1:
					
					circuferencia();
					
					break;
				case 2:
					
					diametro();
					
					break;
				
				}
			}
			
			break;
		case 2:
			
			while(opcao != 3){
				
				// Formatação
				cout << setprecision(2);
				cout << setiosflags(ios::right);
				cout << setiosflags(ios::fixed);
				
				cabecalho3();
				
				// Opções de menu
				cout << "[1] - Media" << endl;
				cout << "[2] - Mediana" << endl;
				cout << "[3] - Encerrar este Programa" << endl;
				cout << "\n";
				
				cout << "=> Escolha uma opcao: ";
				cin >> opcao;
				cout << "\n";
				
				switch (opcao) {
					
				case 1:
					
					media();
					
					break;
				case 2:
					
					mediana();
					
					break;
					
				}
			}
			
			break;
		
		}
	}
	
	// Fim do progama
	return 0;
	
}

void entrada1() {
	
	cout << "\n" << "* Informe o primeiro numero: ";
	cin >> n1;
	cout << "\n" << "* Informe o segundo numero: ";
	cin >> n2;
	cout << "\n" << "* Informe o terceiro numero: ";
	cin >> n3;
	cout << "\n" << "* Informe o quarto numero: ";
	cin >> n4;
	
}

void entrada2() {
	
	cout << "\n" << "* Informe o raio do circulo: ";
	cin >> raio;

}

void saida(string operacao) {
	
	cout << "\n" << "=> O resultado da " << operacao << " e " << resultado;
	
	// Simula pausa
	pausa();
	
}

void pausa() {
	
	char letra;
	
	cout << "\n" << "Tecle <C> + [ENTER] para voltar ao menu: ";
	
	//Laço para receber a entrada do usuario
	do {
		
		// Obtem a entrada do usuario
		letra = cin.get();
		
		// Converte para maiuscula
		letra = toupper(letra);
	} while (letra != 'C');
	
}

void diametro() {
	
	entrada2();
	
	cout << "\n" << "Rotina de Diametro" << endl;
	cout << "------------------" << endl;
	
	resultado = raio * 2;
	
	saida("diametro");
}

void circuferencia() {
	
	entrada2();
	
	cout << "\n" << "Rotina de Circuferencia" << endl;
	cout << "-----------------------" << endl;
	
	resultado = 2 * PI * raio;
	
	saida("circuferencia");
	
}

void media() {
	
	entrada1();
	
	cout << "\n" << "Rotina de Media" << endl;
	cout << "---------------" << endl;
	
	resultado = (n1 + n2 + n3 + n4) / 4;
	
	saida("media");
	
}

void mediana() {
	
	entrada1();
	
	cout << "\n" << "Rotina de Mediana" << endl;
	cout << "-----------------" << endl;
	
	resultado = (n2 + n3) / 2;
	
	saida("mediana");
}
