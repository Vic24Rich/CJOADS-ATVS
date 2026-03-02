/* brModelo - Lógico: */

CREATE TABLE CLIENTES (
    Cod_Clientes CHAR PRIMARY KEY,
    Sobrenome CHAR,
    Nome CHAR,
    Inicial CHAR,
    DDD INT,
    Telefone INT,
    Saldo REAL
);

CREATE TABLE FATURAS (
    Num_Fatura INT PRIMARY KEY,
    Cod_Clientes CHAR,
    Data_Fatura DATE
);

CREATE TABLE LINHAS (
    Num_Linhas INT PRIMARY KEY,
    Num_Fatura INT,
    Unidades INT,
    Valor REAL
);

CREATE TABLE PRODUTOS (
    Cod_Produto INT PRIMARY KEY,
    Num_Linhas INT,
    Descricao CHAR,
    Quantidade INT,
    Valor REAL,
    Desconto REAL
);

CREATE TABLE FORNECEDORES (
    Cod_Fornecedor INT PRIMARY KEY,
    Cod_Produto INT,
    Nome CHAR,
    Contato INT,
    DDD INT,
    Telefone INT,
    Estado CHAR,
    Cidade CHAR
);
 
ALTER TABLE FATURAS ADD CONSTRAINT FK_FATURAS_2
    FOREIGN KEY (Cod_Clientes???)
    REFERENCES ??? (???);
 
ALTER TABLE LINHAS ADD CONSTRAINT FK_LINHAS_2
    FOREIGN KEY (Num_Fatura???)
    REFERENCES ??? (???);
 
ALTER TABLE PRODUTOS ADD CONSTRAINT FK_PRODUTOS_2
    FOREIGN KEY (Num_Linhas???)
    REFERENCES ??? (???);
 
ALTER TABLE FORNECEDORES ADD CONSTRAINT FK_FORNECEDORES_2
    FOREIGN KEY (Cod_Produto???)
    REFERENCES ??? (???);