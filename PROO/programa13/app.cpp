#include <iostream>
#include <string>
#include <vector>

using namespace std;

struct Pokemon  {
	
	string nome;
	string tipo;
	int nivel;
	int hp;
	
	void aumentarHp(int pontos) {
		
		hp += pontos;
		
	}
	
};

struct Treinador {
	
	string nome;
	string cidade;
	vector<Pokemon*> pokemons;
	
};

int main(void) {
	
	cout << "\n* Dados do treinador:\n\n";
	
	Treinador* ptrTreinador = new Treinador;
	
	cout << "Digite um nome: "; cin >> ptrTreinador->nome;
	cout << "Digite sua cidade: "; cin >> ptrTreinador->cidade;
	
	cout << "\n\nNome: " << ptrTreinador->nome << endl;
	cout << "Cidade: " << ptrTreinador->cidade << endl;
	
	Pokemon* pikachu = new Pokemon;
	
	pikachu->nome = "Pikachu";
	pikachu->tipo = "Eletrico";
	pikachu->nivel = 40;
	pikachu->hp = 85;
	
	ptrTreinador->pokemons.push_back(pikachu);
	
	Pokemon* grenija = new Pokemon;
	
	grenija->nome = "Grenija";
	grenija->tipo = "Agua / Sombrio";
	grenija->nivel = 35;
	grenija->hp = 60;
	
	ptrTreinador->pokemons.push_back(grenija);
	
	Pokemon* hawlucha = new Pokemon;
	
	hawlucha->nome = "Hawlucha";
	hawlucha->tipo = "Lutador / Voador";
	hawlucha->nivel = 32;
	hawlucha->hp = 55;
	
	ptrTreinador->pokemons.push_back(hawlucha);
	
	cout << "\n\n>> Dados do Treinador";
	
	cout << "\n\nNome: " << ptrTreinador->nome << endl;
	cout << "Cidade: " << ptrTreinador->cidade;
	
	cout << "\n\n>> Pokemons do Treinador\n";
	
	for (Pokemon* pokemon : ptrTreinador->pokemons) {
		
		cout << "\nNome: " << pokemon->nome << endl;
		cout << "Tipo: " << pokemon->tipo << endl;
		cout << "Nivel: " << pokemon->nivel << endl;
		cout << "HP: " << pokemon->hp << endl;
		
	}
	cin.ignore(90, '\n');
	
	cout << "\n\nPresione <Enter> para finalizar... ";
	cin.get();
	
	
	delete ptrTreinador;
	
	for (Pokemon* pokemon : ptrTreinador->pokemons) {
		
		delete pokemon;
		
	}
	
	return 0;
	
}
