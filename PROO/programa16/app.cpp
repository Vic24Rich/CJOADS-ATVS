#include "pokemon.hpp"
#include <iostream>
#include <string>

using namespace std;

int main(void) {
	
	cout << "\n* Exemplo Pokemon\n\n";
	
	Pokemon ptrPokemon;
	
	ptrPokemon.nome = "Pikachu";
	ptrPokemon.tipo = "Eletrico";
	ptrPokemon.nivel = 1;
	ptrPokemon.hp = 1;
	
	cout << "Nome: " << ptrPokemon.nome << endl;
	cout << "Tipo: " << ptrPokemon.tipo << endl;
	cout << "Nivel: " << ptrPokemon.nivel << endl;
	cout << "HP: " << ptrPokemon.hp << endl << endl;
	
	// cout << ">> Um Pokemon selvagem apareceu... Vamos batalhar:\n\n";
	// cout << "Seu " << ptrPokemon.nome << " venceu uma luta muito dificil...\n" << endl;
	// cout << "Ele ganhou 50 pontos!\n\n";
	
	// ptrPokemon->aumentarHp(50);
	
	// ptrPokemon->nivel++;
	
	// cout << "O " << ptrPokemon->nome << " subiu de Nivel\n\n";
	
	// cout << "Nome: " << ptrPokemon->nome << endl;
	// cout << "Tipo: " << ptrPokemon->tipo << endl;
	// cout << "Nivel: " << ptrPokemon->nivel << endl;
	// cout << "HP: " << ptrPokemon->hp << endl;
	
	return 0;
	
}
