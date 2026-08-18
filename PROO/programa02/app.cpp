// ====================================================================
// programa02.cpp
// 
// Programa para calcular horas trabalhadas.
// ====================================================================
#include <iostream>
#include <iomanip>

using namespace std;

// ====================================================================
// Função principal
// ====================================================================
int main(void) {
	
	// Declaração de Variaveis
	float HT, VH, PD, TD, SB, SL;
	
	// Entrada dos dados
	cout << "\n";
	cout << "Calculo de horas Trabalhadas\n\n";
	cout << "Informe a quantidade de horas trabalhadas: "; cin >> HT;
	cout << "Informe o valor da hora de trabalho: "; cin >> VH;
	cout << "Informe o valor do percentual de desconto: "; cin >> PD;
	
	// Realização dos Calculos
	SB = HT * VH;
	TD = (PD / 100) * SB;
	SL = SB - TD;
	
	// Formatação do resultado
	cout << setprecision(2);
	cout << setiosflags(ios::right);
	cout << setiosflags(ios::fixed);
	
	// APresentação do resultados
	cout << "\n";
	cout << "Salario bruto ....:" << setw(8) << SB << endl;
	cout << "Desconto .........:" << setw(8) << TD << endl;
	cout << "Salario liquido ..:" << setw(8) << SL << endl;
	cout << "\n";
	
	// Fim do programa
	return 0;
	
}


