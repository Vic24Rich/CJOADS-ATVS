#include <iostream>
#include <vector>
#include <algorithm>

using namespace std;

int main(void) {
	
	vector<string> nomes = {"Victor Rep", "Vinicius What", "Joao Queu", "Paulo Npe", "Jose Gore", "Pedro Beal", "Baal Bmand", "Abel Cando", "Antonio Yawie", "Maria Iandh"};
	
	cout << "Nome antes da ordenacao" << endl << endl;
	
	for (int i = 1; i <= 10; i++ ) {
		cout << i << ". " << nomes[i-1] << endl;
		
	}
	
	cout << endl;
	
	sort(nomes.begin(), nomes.end());
	
	cout << "Nome apos da ordenacao" << endl << endl;
	
	for (int i = 1; i <= 10; i++ ) {
		cout << i << ". " << nomes[i-1] << endl;
		
	}
	
	return 0;
}
