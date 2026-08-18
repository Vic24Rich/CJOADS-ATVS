// --------------------------------------------------------------------------------
// Programa 03: Programa que utiliza funcões
//
// Programa que utiliza funções para implementar uma calculadora simples.
// --------------------------------------------------------------------------------

#include <iostream>
#include <iomanip>
#include <cctype>

using namespace std;

// --------------------------------------------------------------------------------
// Variaves globais.
// --------------------------------------------------------------------------------

float resultado, n1, n2;

// --------------------------------------------------------------------------------
// Prototipos de Função
// --------------------------------------------------------------------------------

void entrada();
void saida(string operacao);
void pausa();
void adicao();
void subtracao();
void multiplicacao();
void divisao();

// --------------------------------------------------------------------------------
// Função Principal
// --------------------------------------------------------------------------------

int main(void) {

	// Declaracao de variavies
	int opcao = 0;

	// Laço para ecolha da operação desejada
	while (opcao != 5) {

		// Formatação
		cout << setprecision(2);
		cout << setiosflags(ios::right);
		cout << setiosflags(ios::fixed);

		// Cabeçalho
		cout << "\n";
		cout << "---------------------" << endl;
		cout << " Progrma Calculadora " << endl;
		cout << "   Menu Principal    " << endl;
		cout << "---------------------" << endl;
		cout << "\n";

		// Opções de menu
		cout << "[1] - Adicao" << endl;
		cout << "[2] - Subtracao" << endl;
		cout << "[3] - Multiplicacao" << endl;
		cout << "[4] - Divisao" << endl;
		cout << "[5] - Encerra o Programa" << endl;
		cout << "\n";

		cout << "=> Escolha uma opcao: ";
		cin >> opcao;
		cout << "\n";

		// Se o usuario não deseja encerrar o programa
		if (opcao != 5) {

			// Verifica a opção escolhida pelo usuario
			switch (opcao) {
				case 1:

					//Adição
					adicao();

					break;
				case 2:

					//Subtracao
					subtracao();

					break;
				case 3:

					// Multiplicacao
					multiplicacao();

					break;
				case 4:

					//Divisao
					divisao();

					break;
			}
		}
		// Caso contrario
		else {
			cout << "Programa encerrado com sucesso! : )";
			cout << "\n";
		}

	}

	// Fim do programa
	return 0;
}

// --------------------------------------------------------------------------------
// Definição de Função
// --------------------------------------------------------------------------------

// Realiza a entrada dos numeros que serao utilizado na operacao
void entrada() {

	cout << "\n" << "* Informe o primeiro numero: ";
	cin >> n1;
	cout << "\n" << "* Informe o segundo numero: ";
	cin >> n2;
}
// --------------------------------------------------------------------------------

// Exibição dos resultado
void saida(string operacao) {

	cout << "\n" << "=> O resultado da " << operacao << " entre " << n1 << " e " << n2 << " é " << resultado;

	// Simula pausa
	pausa();

}
// ---

// Simula uma pausa na execucao do programa
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
// --------------------------------------------------------------------------------

// Realiza a operacao de adicao
void adicao() {

	// Rotina de Adicao
	cout << "\n" << "Rotina de Adicao" << endl;
	cout << "----------------" << endl;
	
	entrada();
	
	resultado = n1 + n2;
	
	saida("adicao");
	
}
// --------------------------------------------------------------------------------

// Realiza a operacao de Subtracao
void subtracao() {

	// Rotina de Subtracao
	cout << "\n" << "Rotina de Subtracao" << endl;
	cout << "----------------" << endl;
	
	entrada();
	
	resultado = n1 - n2;
	
	saida("Subtracao");
	
}
// --------------------------------------------------------------------------------

// Realiza a operacao de multiplicacao
void multiplicacao() {
	
	// Rotina de multiplicacao
	cout << "\n" << "Rotina de Multiplicacao" << endl;
	cout << "----------------" << endl;
	
	entrada();
	
	resultado = n1 * n2;
	
	saida("multiplicacao");
	
}
// --------------------------------------------------------------------------------

// Realiza a operacao de divisao
void divisao() {
	
	// Rotina de divisao
	cout << "\n" << "Rotina de Divisao" << endl;
	cout << "----------------" << endl;
	
	entrada();
	
	// Verifica se nao e divisao por 0
	if (n2 == 0) {
		
		cout << "\n" << "Nao ha operacao para este calculo.";
		pausa();
		
	} else {
		resultado = n1 / n2;
		saida("divisao");
	}
	
}
// --------------------------------------------------------------------------------
