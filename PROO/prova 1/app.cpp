// Plantação de Tomates do Prof. Avelino

#include <iostream>
#include <vector>

using namespace std;

int main(void) {

	cout << "* Tomates Magicos\n\n";

	int alt, larg, posi1, posi2, posi3, posi4, posi5, totalplantio = 0, totalarmadilha = 0, contador = 0;

	cout << "- Professor Avelino, informe a altura e a largura de seu terreno: ";
	cin >> alt;
	cin >> larg;
	
	vector<vector<char>> terreno(alt, vector<char>(larg));

	cout << "\n\n- Informe as 5 posicoes onde deseja plantar cada pe de tomate: ";
	cin >> posi1;
	cin >> posi2;
	cin >> posi3;
	cin >> posi4;
	cin >> posi5;

	for (int i = 0; i < alt; i++) {
		for (int j = 0; j < larg; j++) {
			
			if (posi1 == contador+1) {

				terreno[i][j] = 'T';
				totalplantio++;

			} else if (posi2 == contador+1) {

				terreno[i][j] = 'T';
				totalplantio++;

			} else if (posi3 == contador+1) {

				terreno[i][j] = 'T';
				totalplantio++;

			} else if (posi4 == contador+1) {

				terreno[i][j] = 'T';
				totalplantio++;

			} else if (posi5 == contador+1) {

				terreno[i][j] = 'T';
				totalplantio++;

			}  else if (posi1+1 == contador+1 or posi1-1 == contador+1 or posi1+larg == contador+1 or (posi1-larg == contador+1 and terreno[i][j] != 'T')) {
				
				terreno[i][j] = '#';
				totalarmadilha++;
				
			} else if (posi2+1 == contador+1 or posi2-1 == contador+1 or posi2+larg == contador+1 or (posi2-larg == contador+1 and terreno[i][j] != 'T')) {
				
				terreno[i][j] = '#';
				totalarmadilha++;
				
			} else if (posi3+1 == contador+1 or posi3-1 == contador+1 or posi3+larg == contador+1 or (posi3-larg == contador+1 and terreno[i][j] != 'T')) {
				
				terreno[i][j] = '#';
				totalarmadilha++;
				
			} else if (posi4+1 == contador+1 or posi4-1 == contador+1 or posi4+larg == contador+1 or (posi4-larg == contador+1 and terreno[i][j] != 'T')) {
				
				terreno[i][j] = '#';
				totalarmadilha++;
				
			} else if (posi5+1 == contador+1 or posi5-1 == contador+1 or posi5+larg == contador+1 or (posi5-larg == contador+1 and terreno[i][j] != 'T')) {
				
				terreno[i][j] = '#';
				totalarmadilha++;
				
			} else {
				
				terreno[i][j] = '.';
				
			}
			contador++;
		}
	}

	cout << "\n\n- Voce conseguiu plantar " << totalplantio << " tomates com sucesso!\n\n";
	
	for (int i = 0; i < alt; i++) {
		for (int j = 0; j < larg; j++) {
			
			cout << terreno[i][j] << "  ";
			
		}
		cout << endl;
	}
	
	cout << "\n\n- Total de armadilhas instaladas: " << totalarmadilha;

	return 0;

}
