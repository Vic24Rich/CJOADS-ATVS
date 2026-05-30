-- ============================================================================
-- SCRIPT DE CRIAÇÃO DO BANCO DE DADOS - ERP FINANCEIRO
-- ============================================================================
CREATE DATABASE IF NOT EXISTS erp_financeiro CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE erp_financeiro;

-- 1. TABELA DE STATUS DE PARCELAS
CREATE TABLE STATUS_PARCELA (
    id INT AUTO_INCREMENT,
    sigla VARCHAR(2) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_status_parcela PRIMARY KEY (id),
    CONSTRAINT unq_sigla_status UNIQUE (sigla)
);

-- 2. TABELA DE TIPOS DE PAGAMENTO
CREATE TABLE TIPO_PAGAMENTO (
    id INT AUTO_INCREMENT,
    codigo VARCHAR(2) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_tipo_pagamento PRIMARY KEY (id),
    CONSTRAINT unq_cod_pagamento UNIQUE (codigo)
);

-- 3. TABELA DE TIPOS DE RECEBIMENTO
CREATE TABLE TIPO_RECEBIMENTO (
    id INT AUTO_INCREMENT,
    codigo VARCHAR(2) NOT NULL,
    descricao VARCHAR(50) NOT NULL,
    CONSTRAINT pk_tipo_recebimento PRIMARY KEY (id),
    CONSTRAINT unq_cod_recebimento UNIQUE (codigo)
);

-- 4. TABELA DE DOCUMENTOS DE ORIGEM
CREATE TABLE DOCUMENTO_ORIGEM (
    id INT AUTO_INCREMENT,
    sigla VARCHAR(50) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    CONSTRAINT pk_documento_origem PRIMARY KEY (id),
    CONSTRAINT unq_sigla_doc UNIQUE (sigla)
);

-- 5. TABELA DE NATUREZA FINANCEIRA
CREATE TABLE NATUREZA_FINANCEIRA (
    id INT AUTO_INCREMENT,
    codigo VARCHAR(10) NOT NULL,
    descricao VARCHAR(100) NOT NULL,
    tipo CHAR(1) NOT NULL,
    CONSTRAINT pk_natureza_financeira PRIMARY KEY (id),
    CONSTRAINT unq_cod_natureza UNIQUE (codigo),
    CONSTRAINT chk_tipo_natureza CHECK (tipo IN ('R', 'D'))
);

-- 6. TABELA DE LANÇAMENTOS A PAGAR
CREATE TABLE LANÇAMENTO_PAGAR (
    id INT AUTO_INCREMENT,
    id_documento_origem INT NOT NULL,
    id_natureza_financeira INT NOT NULL,
    numero_documento VARCHAR(50) NOT NULL,
    valor_total DECIMAL(18,2) NOT NULL,
    data_lancamento DATE NOT NULL,
    competencia DATE NOT NULL,
    CONSTRAINT pk_lancamento_pagar PRIMARY KEY (id),
    CONSTRAINT fk_pagar_doc_origem FOREIGN KEY (id_documento_origem) REFERENCES DOCUMENTO_ORIGEM(id) ON DELETE RESTRICT,
    CONSTRAINT fk_pagar_natureza FOREIGN KEY (id_natureza_financeira) REFERENCES NATUREZA_FINANCEIRA(id) ON DELETE RESTRICT
);

-- 7. TABELA DE PARCELAS A PAGAR
CREATE TABLE PARCELA_PAGAR (
    id INT AUTO_INCREMENT,
    id_lancamento_pagar INT NOT NULL,
    id_status_parcela INT NOT NULL,
    id_tipo_pagamento INT NULL,
    numero_parcela INT NOT NULL,
    data_vencimento DATE NOT NULL,
    data_pagamento DATE NULL,
    valor DECIMAL(18,2) NOT NULL,
    taxa_juros DECIMAL(18,2) DEFAULT 0.00,
    taxa_multa DECIMAL(18,2) DEFAULT 0.00,
    valor_desconto DECIMAL(18,2) DEFAULT 0.00,
    valor_pago DECIMAL(18,2) DEFAULT 0.00,
    CONSTRAINT pk_parcela_pagar PRIMARY KEY (id),
    CONSTRAINT fk_parcela_pagar_pai FOREIGN KEY (id_lancamento_pagar) REFERENCES LANÇAMENTO_PAGAR(id) ON DELETE CASCADE,
    CONSTRAINT fk_parcela_pagar_status FOREIGN KEY (id_status_parcela) REFERENCES STATUS_PARCELA(id) ON DELETE RESTRICT,
    CONSTRAINT fk_parcela_pagar_tipo FOREIGN KEY (id_tipo_pagamento) REFERENCES TIPO_PAGAMENTO(id) ON DELETE RESTRICT
);

-- 8. TABELA DE LANÇAMENTOS A RECEBER
CREATE TABLE LANCAMENTO_RECEBER (
    id INT AUTO_INCREMENT,
    id_documento_origem INT NOT NULL,
    id_natureza_financeira INT NOT NULL,
    numero_documento VARCHAR(50) NOT NULL,
    valor_total DECIMAL(18,2) NOT NULL,
    data_lancamento DATE NOT NULL,
    competencia DATE NOT NULL,
    CONSTRAINT pk_lancamento_receber PRIMARY KEY (id),
    CONSTRAINT fk_receber_doc_origem FOREIGN KEY (id_documento_origem) REFERENCES DOCUMENTO_ORIGEM(id) ON DELETE RESTRICT,
    CONSTRAINT fk_receber_natureza FOREIGN KEY (id_natureza_financeira) REFERENCES NATUREZA_FINANCEIRA(id) ON DELETE RESTRICT
);

-- 9. TABELA DE PARCELAS A RECEBER
CREATE TABLE PARCELA_RECEBER (
    id INT AUTO_INCREMENT,
    id_lancamento_receber INT NOT NULL,
    id_status_parcela INT NOT NULL,
    id_tipo_recebimento INT NULL,
    numero_parcela INT NOT NULL,
    data_vencimento DATE NOT NULL,
    data_recebimento DATE NULL,
    valor DECIMAL(18,2) NOT NULL,
    taxa_juros DECIMAL(18,2) DEFAULT 0.00,
    taxa_multa DECIMAL(18,2) DEFAULT 0.00,
    valor_desconto DECIMAL(18,2) DEFAULT 0.00,
    valor_recebido DECIMAL(18,2) DEFAULT 0.00,
    CONSTRAINT pk_parcela_receber PRIMARY KEY (id),
    CONSTRAINT fk_parcela_receber_pai FOREIGN KEY (id_lancamento_receber) REFERENCES LANCAMENTO_RECEBER(id) ON DELETE CASCADE,
    CONSTRAINT fk_parcela_receber_status FOREIGN KEY (id_status_parcela) REFERENCES STATUS_PARCELA(id) ON DELETE RESTRICT,
    CONSTRAINT fk_parcela_receber_tipo FOREIGN KEY (id_tipo_recebimento) REFERENCES TIPO_RECEBIMENTO(id) ON DELETE RESTRICT
);

-- 10. TABELA DE FECHAMENTO DE CAIXA E BANCO
CREATE TABLE FECHAMENTO_CAIXA_BANCO (
    id INT AUTO_INCREMENT,
    data_fechamento DATE NOT NULL,
    saldo_inicial DECIMAL(18,2) NOT NULL,
    total_ingressos DECIMAL(18,2) NOT NULL,
    total_desembolsos DECIMAL(18,2) NOT NULL,
    saldo_final DECIMAL(18,2) NOT NULL,
    CONSTRAINT pk_fechamento PRIMARY KEY (id),
    CONSTRAINT unq_data_fechamento UNIQUE (data_fechamento)
);

-- 11. TABELA DE EXTRATO CONTA BANCO
CREATE TABLE EXTRATO_CONTA_BANCO (
    id INT AUTO_INCREMENT,
    data_movimento DATE NOT NULL,
    numero_documento VARCHAR(50) NOT NULL,
    descricao VARCHAR(150) NOT NULL,
    tipo_movimento CHAR(1) NOT NULL,
    valor DECIMAL(18,2) NOT NULL,
    conciliado CHAR(1) DEFAULT 'N',
    CONSTRAINT pk_extrato PRIMARY KEY (id),
    CONSTRAINT chk_tipo_extrato CHECK (tipo_movimento IN ('C', 'D')),
    CONSTRAINT chk_conciliado CHECK (conciliado IN ('S', 'N'))
);

-- CARGA DAS TABELAS PARAMÉTRICAS
INSERT INTO STATUS_PARCELA (sigla, descricao) VALUES 
('AB', 'Aberto'), ('QT', 'Quitado'), ('QP', 'Quitado Parcial'), ('VC', 'Vencido'), ('RN', 'Renegociado');

INSERT INTO TIPO_PAGAMENTO (codigo, descricao) VALUES 
('01', 'Dinheiro'), ('02', 'Pix'), ('03', 'Cartão Crédito'), ('04', 'Cartão Débito'), ('05', 'Transferência'), ('06', 'Boleto');

INSERT INTO TIPO_RECEBIMENTO (codigo, descricao) VALUES 
('01', 'Dinheiro'), ('02', 'Pix'), ('03', 'Cartão Crédito'), ('04', 'Cartão Débito'), ('05', 'Transferência'), ('06', 'Boleto');

INSERT INTO DOCUMENTO_ORIGEM (sigla, descricao) VALUES 
('NF', 'Nota Fiscal'), ('NFe', 'Nota Fiscal Eletrônica'), ('FAT', 'Fatura'), ('REC', 'Recibo'), ('BOL', 'Boleto');

INSERT INTO NATUREZA_FINANCEIRA (codigo, descricao, tipo) VALUES 
('1001', 'Vendas de Mercadorias', 'R'), ('1002', 'Prestação de Serviços', 'R'), ('1003', 'Receitas de Aplicações', 'R'),
('2001', 'Aluguel de Imóvel', 'D'), ('2002', 'Fornecedores de Insumos', 'D'), ('2003', 'Folha de Pagamento', 'D'),
('2004', 'Tarifas Bancárias', 'D'), ('2005', 'Impostos e Contribuições', 'D');

-- REGISTROS DE LANÇAMENTOS E PARCELAS (MASSA TRANSACIONAL DE TESTE SIMULADA)
INSERT INTO LANÇAMENTO_PAGAR (id_documento_origem, id_natureza_financeira, numero_documento, valor_total, data_lancamento, competencia) VALUES
(1, 4, 'NF-202601', 3000.00, '2026-01-05', '2026-01-01'),
(2, 5, 'NFe-8890', 15000.00, '2026-01-10', '2026-01-01'),
(4, 6, 'REC-992', 1200.00, '2026-01-15', '2026-01-15'),
(1, 4, 'NF-202602', 3000.00, '2026-02-05', '2026-02-01');

INSERT INTO PARCELA_PAGAR (id_lancamento_pagar, id_status_parcela, id_tipo_pagamento, numero_parcela, data_vencimento, data_pagamento, valor, taxa_juros, taxa_multa, valor_desconto, valor_pago) VALUES
(1, 2, 5, 1, '2026-02-05', '2026-02-05', 3000.00, 0.00, 0.00, 0.00, 3000.00),
(2, 2, 5, 1, '2026-01-30', '2026-01-30', 15000.00, 0.00, 0.00, 200.00, 14800.00),
(3, 4, NULL, 1, '2026-02-15', NULL, 1200.00, 0.00, 0.00, 0.00, 0.00),
(4, 1, NULL, 1, '2026-03-05', NULL, 3000.00, 0.00, 0.00, 0.00, 0.00);

INSERT INTO LANCAMENTO_RECEBER (id_documento_origem, id_natureza_financeira, numero_documento, valor_total, data_lancamento, competencia) VALUES
(3, 1, 'FAT-001', 25000.00, '2026-01-02', '2026-01-01'),
(5, 2, 'BOL-554', 8000.00, '2026-01-05', '2026-01-05'),
(3, 1, 'FAT-002', 12000.00, '2026-02-02', '2026-02-01');

INSERT INTO PARCELA_RECEBER (id_lancamento_receber, id_status_parcela, id_tipo_recebimento, numero_parcela, data_vencimento, data_recebimento, valor, taxa_juros, taxa_multa, valor_desconto, valor_recebido) VALUES
(1, 2, 6, 1, '2026-02-02', '2026-02-02', 25000.00, 0.00, 0.00, 0.00, 25000.00),
(2, 2, 2, 1, '2026-01-20', '2026-01-25', 8000.00, 50.00, 160.00, 0.00, 8210.00),
(3, 1, NULL, 1, '2026-03-02', NULL, 12000.00, 0.00, 0.00, 0.00, 0.00);

-- 5 Novos Lançamentos e Parcelas a Pagar (Despesas)
INSERT INTO LANÇAMENTO_PAGAR (id_documento_origem, id_natureza_financeira, numero_documento, valor_total, data_lancamento, competencia) VALUES
(1, 6, 'NF-FOLHA03', 12000.00, '2026-03-01', '2026-03-01'), -- Folha
(2, 5, 'NFe-9001', 5000.00, '2026-03-10', '2026-03-01'),   -- Insumos
(4, 4, 'REC-995', 2000.00, '2026-03-15', '2026-03-15'),     -- Aluguel
(1, 8, 'NF-IMP03', 4500.00, '2026-04-05', '2026-04-01'),    -- Impostos
(2, 7, 'TAR-BAN04', 150.00, '2026-04-10', '2026-04-01');    -- Tarifa

INSERT INTO PARCELA_PAGAR (id_lancamento_pagar, id_status_parcela, id_tipo_pagamento, numero_parcela, data_vencimento, data_pagamento, valor, valor_pago) VALUES
(5, 2, 5, 1, '2026-03-05', '2026-03-05', 12000.00, 12000.00),
(6, 2, 5, 1, '2026-03-20', '2026-03-20', 5000.00, 5000.00),
(7, 1, NULL, 1, '2026-04-15', NULL, 2000.00, 0.00),
(8, 1, NULL, 1, '2026-05-05', NULL, 4500.00, 0.00),
(9, 2, 5, 1, '2026-04-10', '2026-04-10', 150.00, 150.00);

-- 5 Novos Lançamentos e Parcelas a Receber (Receitas)
INSERT INTO LANCAMENTO_RECEBER (id_documento_origem, id_natureza_financeira, numero_documento, valor_total, data_lancamento, competencia) VALUES
(3, 1, 'FAT-003', 15000.00, '2026-03-02', '2026-03-01'),
(3, 2, 'FAT-004', 3500.00, '2026-03-10', '2026-03-10'),
(5, 1, 'BOL-600', 9000.00, '2026-03-25', '2026-03-25'),
(3, 2, 'FAT-005', 7500.00, '2026-04-02', '2026-04-01'),
(5, 3, 'REC-006', 1200.00, '2026-04-10', '2026-04-10');


INSERT INTO PARCELA_RECEBER (id_lancamento_receber, id_status_parcela, id_tipo_recebimento, numero_parcela, data_vencimento, data_recebimento, valor, valor_recebido) VALUES
(4, 2, 2, 1, '2026-04-02', '2026-04-02', 15000.00, 15000.00),
(5, 2, 6, 1, '2026-04-10', '2026-04-10', 3500.00, 3500.00),
(6, 1, NULL, 1, '2026-04-25', NULL, 9000.00, 0.00),
(7, 1, NULL, 1, '2026-05-02', NULL, 7500.00, 0.00),
(8, 2, 5, 1, '2026-04-10', '2026-04-10', 1200.00, 1200.00);

INSERT INTO FECHAMENTO_CAIXA_BANCO (data_fechamento, saldo_inicial, total_ingressos, total_desembolsos, saldo_final) VALUES
('2026-01-31', 50000.00, 8210.00, 14800.00, 43410.00),
('2026-02-28', 43410.00, 25000.00, 3000.00, 65410.00);

INSERT INTO EXTRATO_CONTA_BANCO (data_movimento, numero_documento, descricao, tipo_movimento, valor, conciliado) VALUES
('2026-01-25', 'PIX9923', 'RECEBIMENTO PIX BOL-554', 'C', 8210.00, 'S'),
('2026-01-30', 'TED8812', 'PAGAMENTO FORNECEDORES NFe-8890', 'D', 14800.00, 'S'),
('2026-02-02', 'COB001A', 'LIQUIDACAO DUPLICATA FAT-001', 'C', 25000.00, 'S'),
('2026-02-27', 'TAR2210', 'DEBITO TARIFA BANCARIA MENSAL', 'D', 45.00, 'N');

-- 1-  Fluxo de Caixa Realizado Consolidado Mensal
SELECT 
    YEAR(COALESCE(R.data_recebimento, P.data_pagamento)) AS Ano,
    MONTH(COALESCE(R.data_recebimento, P.data_pagamento)) AS Mes,
    SUM(COALESCE(R.valor_recebido, 0)) AS Total_Ingressos,
    SUM(COALESCE(P.valor_pago, 0)) AS Total_Desembolsos,
    (SUM(COALESCE(R.valor_recebido, 0)) - SUM(COALESCE(P.valor_pago, 0))) AS Saldo_Liquido
FROM (SELECT data_recebimento, valor_recebido FROM PARCELA_RECEBER WHERE data_recebimento IS NOT NULL) R
JOIN (SELECT data_pagamento, valor_pago FROM PARCELA_PAGAR WHERE data_pagamento IS NOT NULL) P ON MONTH(R.data_recebimento) = MONTH(P.data_pagamento)
GROUP BY Ano, Mes ORDER BY Ano, Mes;

-- 2- Lucratividade por Natureza Financeira
SELECT 
    NF.codigo AS Codigo_Conta,
    NF.descricao AS Categoria,
    NF.tipo AS Tipo_Fluxo,
    SUM(CASE WHEN NF.tipo = 'R' THEN COALESCE(PR.valor_recebido, PR.valor) ELSE 0 END) -
    SUM(CASE WHEN NF.tipo = 'D' THEN COALESCE(PP.valor_pago, PP.valor) ELSE 0 END) AS Balanco_Acumulado
FROM NATUREZA_FINANCEIRA NF
LEFT JOIN LANCAMENTO_RECEBER LR ON LR.id_natureza_financeira = NF.id
LEFT JOIN PARCELA_RECEBER PR ON PR.id_lancamento_receber = LR.id
LEFT JOIN LANÇAMENTO_PAGAR LP ON LP.id_natureza_financeira = NF.id
LEFT JOIN PARCELA_PAGAR PP ON PP.id_lancamento_pagar = LP.id
GROUP BY NF.id, NF.codigo, NF.descricao, NF.tipo
ORDER BY Codigo_Conta;

-- 3- Lista de Contas a Receber (Faixas de Atraso)
SELECT 
    PR.id AS ID_Parcela,
    LR.numero_documento AS Documento,
    PR.data_vencimento AS Vencimento,
    PR.valor AS Valor_Nominal,
    DATEDIFF('2026-05-25', PR.data_vencimento) AS Dias_Em_Atraso,
    CASE 
        WHEN DATEDIFF('2026-05-25', PR.data_vencimento) BETWEEN 1 AND 30 THEN '01 a 30 Dias'
        WHEN DATEDIFF('2026-05-25', PR.data_vencimento) BETWEEN 31 AND 60 THEN '31 a 60 Dias'
        WHEN DATEDIFF('2026-05-25', PR.data_vencimento) BETWEEN 61 AND 90 THEN '61 a 90 Dias'
        ELSE 'Acima de 90 Dias'
    END AS Faixa_Inadimplencia
FROM PARCELA_RECEBER PR
JOIN LANCAMENTO_RECEBER LR ON PR.id_lancamento_receber = LR.id
WHERE PR.id_status_parcela IN (1, 4) AND PR.data_vencimento < '2026-05-25';

-- 4- Lista de Contas a Pagar
SELECT 
    PP.id AS ID_Parcela,
    LP.numero_documento AS Documento,
    PP.data_vencimento AS Vencimento,
    PP.valor AS Valor_Nominal,
    DATEDIFF('2026-05-25', PP.data_vencimento) AS Dias_Vencidos,
    CASE 
        WHEN DATEDIFF('2026-05-25', PP.data_vencimento) BETWEEN 1 AND 30 THEN '01 a 30 Dias'
        WHEN DATEDIFF('2026-05-25', PP.data_vencimento) BETWEEN 31 AND 60 THEN '31 a 60 Dias'
        ELSE 'Acima de 60 Dias'
    END AS Faixa_Atraso
FROM PARCELA_PAGAR PP
JOIN LANÇAMENTO_PAGAR LP ON PP.id_lancamento_pagar = LP.id
WHERE PP.id_status_parcela IN (1, 4) AND PP.data_vencimento < '2026-05-25';

-- 5- Percentual de Descontos Obtidos em Compras
SELECT 
    YEAR(data_pagamento) AS Ano,
    MONTH(data_pagamento) AS Mes,
    SUM(valor) AS Total_Nominal,
    SUM(valor_desconto) AS Total_Descontos,
    ROUND((SUM(valor_desconto) / SUM(valor)) * 100, 2) AS Percentual_Economia
FROM PARCELA_PAGAR
WHERE id_status_parcela = 2 AND data_pagamento IS NOT NULL
GROUP BY Ano, Mes;

-- 6- Divergências entre Valores de Parcela e Valores Pagos
SELECT 
    id AS ID_Parcela,
    valor AS Valor_Original,
    taxa_juros AS Juros,
    taxa_multa AS Multa,
    valor_desconto AS Desconto,
    valor_pago AS Valor_Baixado,
    (valor + taxa_juros + taxa_multa - valor_desconto) AS Calculado_Teorico
FROM PARCELA_PAGAR
WHERE valor_pago <> (valor + taxa_juros + taxa_multa - valor_desconto)

-- 7- Ticket Médio Mensal por Meio de Recebimento
SELECT 
    TR.descricao AS Meio_Recebimento,
    COUNT(PR.id) AS Qtd_Transacoes,
    ROUND(AVG(PR.valor_recebido), 2) AS Ticket_Medio,
    SUM(PR.valor_recebido) AS Volume_Total
FROM PARCELA_RECEBER PR
JOIN TIPO_RECEBIMENTO TR ON PR.id_tipo_recebimento = TR.id
WHERE PR.id_status_parcela = 2
GROUP BY TR.descricao;

-- 8- Distribuição de Despesas por Tipo de Documento Base
SELECT 
    DO.sigla AS Tipo_Doc,
    DO.descricao AS Documento,
    COUNT(LP.id) AS Total_Lancamentos,
    SUM(LP.valor_total) AS Gasto_Total
FROM LANÇAMENTO_PAGAR LP
JOIN DOCUMENTO_ORIGEM DO ON LP.id_documento_origem = DO.id
GROUP BY DO.sigla, DO.descricao
ORDER BY Gasto_Total DESC;

-- 9- Conciliação Bancária - Inconsistências de Lançamento
SELECT 
    EB.id AS ID_Extrato,
    EB.data_movimento AS Data_Banco,
    EB.descricao AS Historico_Banco,
    EB.valor AS Valor_Banco
FROM EXTRATO_CONTA_BANCO EB
WHERE EB.tipo_movimento = 'D' AND EB.conciliado = 'N'
AND NOT EXISTS (
    SELECT 1 FROM PARCELA_PAGAR PP 
    WHERE PP.valor_pago = EB.valor AND PP.data_pagamento = EB.data_movimento
);

-- 10- Evolução dos Fechamentos Históricos de Caixa
SELECT 
    id AS ID_Fechamento,
    data_fechamento AS Data_Corte,
    saldo_inicial AS Inicial,
    total_ingressos AS Ingressos,
    total_desembolsos AS Desembolsos,
    saldo_final AS Final_Apurado,
    ROUND((saldo_inicial + total_ingressos - total_desembolsos), 2) AS Calculado_Verificacao
FROM FECHAMENTO_CAIXA_BANCO
ORDER BY data_fechamento;

-- 11- Projeção de Encargos por Inadimplência Ativa de Terceiros
SELECT 
    PR.id AS ID_Parcela,
    PR.data_vencimento AS Vencimento,
    PR.valor AS Valor_Original,
    DATEDIFF('2026-05-25', PR.data_vencimento) AS Dias_Atraso,
    ROUND(PR.valor * 0.02, 2) AS Multa_Projetada,
    ROUND(PR.valor * (0.01 / 30) * DATEDIFF('2026-05-25', PR.data_vencimento), 2) AS Juros_Projetados,
    ROUND(PR.valor + (PR.valor * 0.02) + (PR.valor * (0.01 / 30) * DATEDIFF('2026-05-25', PR.data_vencimento)), 2) AS Total_Projetado
FROM PARCELA_RECEBER PR
WHERE PR.id_status_parcela = 4 OR (PR.id_status_parcela = 1 AND PR.data_vencimento < '2026-05-25');

-- 12- Lançamentos sem Notas Fiscais Associadas
SELECT 
    LP.id AS ID_Lancamento,
    DO.sigla AS Documento_Sigla,
    LP.numero_documento AS Num_Doc,
    LP.valor_total AS Valor
FROM LANÇAMENTO_PAGAR LP
JOIN DOCUMENTO_ORIGEM DO ON LP.id_documento_origem = DO.id
WHERE DO.sigla NOT IN ('NF', 'NFe');

-- 13- Análise de Sazonalidade Trimestral de Faturamento
SELECT 
    YEAR(data_vencimento) AS Ano,
    QUARTER(data_vencimento) AS Trimestre,
    COUNT(id) AS Qtd_Parcelas,
    SUM(valor) AS Faturamento_Previsto
FROM PARCELA_RECEBER
GROUP BY Ano, Trimestre
ORDER BY Ano, Trimestre;

-- 14- Parcelas Acima do Valor Médio do Mês
SELECT 
    id AS ID_Parcela,
    data_vencimento AS Vencimento,
    valor AS Valor_Parcela
FROM PARCELA_RECEBER P
WHERE valor > (
    SELECT AVG(valor) 
    FROM PARCELA_RECEBER 
    WHERE MONTH(data_vencimento) = MONTH(P.data_vencimento) AND YEAR(data_vencimento) = YEAR(P.data_vencimento)
);

-- 15- Índice de Liquidez Imediata Baseado em Inadimplência Ativa
SELECT 
    (SELECT SUM(valor) FROM PARCELA_RECEBER WHERE id_status_parcela = 4 OR (id_status_parcela = 1 AND data_vencimento < '2026-05-25')) AS Total_Inadimplido_Clientes,
    (SELECT SUM(valor) FROM PARCELA_PAGAR WHERE id_status_parcela = 1 AND data_vencimento >= '2026-05-25') AS Compromissos_A_Vencer,
    ROUND((SELECT SUM(valor) FROM PARCELA_RECEBER WHERE id_status_parcela = 4) / 
          (SELECT SUM(valor) FROM PARCELA_PAGAR WHERE id_status_parcela = 1 AND data_vencimento >= '2026-05-25'), 2) AS Razao_Risco;

-- 16- Identificação de Potencial Duplicidade de Lançamentos
SELECT 
    numero_documento,
    competencia,
    valor_total,
    COUNT(*) AS Ocorrencias
FROM LANÇAMENTO_PAGAR
GROUP BY numero_documento, competencia, valor_total
HAVING COUNT(*) > 1;

-- 17- Proporção Percentual de Cada Categoria de Despesa no Mês
SELECT 
    NF.descricao AS Categoria_Gasto,
    SUM(PP.valor_pago) AS Gasto_Categoria,
    ROUND((SUM(PP.valor_pago) / (SELECT SUM(valor_pago) FROM PARCELA_PAGAR WHERE data_pagamento BETWEEN '2026-01-01' AND '2026-01-31')) * 100, 2) AS Percentual_Do_Mes
FROM PARCELA_PAGAR PP
JOIN LANÇAMENTO_PAGAR LP ON PP.id_lancamento_pagar = LP.id
JOIN NATUREZA_FINANCEIRA NF ON LP.id_natureza_financeira = NF.id
WHERE PP.data_pagamento BETWEEN '2026-01-01' AND '2026-01-31'
GROUP BY NF.descricao;

-- 18- Tempo Médio de Recebimento de Clientes (Eficiência de Cobrança)
SELECT 
    COUNT(id) AS Total_Parcelas_Pagas,
    AVG(DATEDIFF(data_recebimento, data_vencimento)) AS Media_Dias_Desvio,
    MAX(DATEDIFF(data_recebimento, data_vencimento)) AS Maior_Atraso_Registrado
FROM PARCELA_RECEBER
WHERE id_status_parcela = 2 AND data_recebimento IS NOT NULL;

-- 19- Projeção de Fluxo de Caixa Futuro (Próximos 30 Dias)
SELECT 
    (SELECT COALESCE(SUM(valor),0) FROM PARCELA_RECEBER WHERE data_vencimento BETWEEN '2026-05-25' AND '2026-06-25' AND id_status_parcela = 1) AS Ingressos_Previstos,
    (SELECT COALESCE(SUM(valor),0) FROM PARCELA_PAGAR WHERE data_vencimento BETWEEN '2026-05-25' AND '2026-06-25' AND id_status_parcela = 1) AS Desembolsos_Previstos,
    ((SELECT COALESCE(SUM(valor),0) FROM PARCELA_RECEBER WHERE data_vencimento BETWEEN '2026-05-25' AND '2026-06-25' AND id_status_parcela = 1) - 
     (SELECT COALESCE(SUM(valor),0) FROM PARCELA_PAGAR WHERE data_vencimento BETWEEN '2026-05-25' AND '2026-06-25' AND id_status_parcela = 1)) AS Resultado_Projetado;

-- 20- Demonstrativo de Resultado de Exercício (DRE)
SELECT 
    '1. RECEITAS BRUTAS OPERACIONAIS' AS Fluxo_Contabil,
    SUM(valor_recebido) AS Montante FROM PARCELA_RECEBER WHERE id_status_parcela = 2
UNION ALL
SELECT 
    '2. (-) DESPESAS OPERACIONAIS', 
    SUM(valor_pago) * -1 FROM PARCELA_PAGAR WHERE id_status_parcela = 2
UNION ALL
SELECT 
    '3. RESULTADO LÍQUIDO DO EXERCÍCIO',
    (SELECT SUM(valor_recebido) FROM PARCELA_RECEBER WHERE id_status_parcela = 2) - 
    (SELECT SUM(valor_pago) FROM PARCELA_PAGAR WHERE id_status_parcela = 2);

-- 21- Mapeamento de Extratos Bancários Pendentes de Conciliação
SELECT 
    tipo_movimento AS Operacao_Banco,
    COUNT(*) AS Registros_Pendentes,
    SUM(valor) AS Volume_A_Conciliar
FROM EXTRATO_CONTA_BANCO
WHERE conciliado = 'N'
GROUP BY tipo_movimento;

-- 22- Identificação de Parcelas Pagas com Juros e Multas
SELECT 
    id AS ID_Parcela,
    data_vencimento AS Vencimento,
    data_pagamento AS Pago_Em,
    valor AS Nominal,
    (taxa_juros + taxa_multa) AS Total_Encargos,
    valor_pago AS Pago_Final
FROM PARCELA_PAGAR
WHERE (taxa_juros > 0 OR taxa_multa > 0) AND id_status_parcela = 2;

-- 23- Consolidação de Ingressos por Operadora de Recebimentos
SELECT 
    TR.codigo AS Cod_Meio,
    TR.descricao AS Meio,
    SUM(PR.valor) AS Nominal_Total,
    SUM(PR.taxa_juros + PR.taxa_multa) AS Encargos_Recuperados,
    SUM(PR.valor_recebido) AS Caixa_Efetivo
FROM PARCELA_RECEBER PR
JOIN TIPO_RECEBIMENTO TR ON PR.id_tipo_recebimento = TR.id
WHERE PR.id_status_parcela = 2
GROUP BY TR.codigo, TR.descricao;

-- 24- Verificação de Lançamentos sem Vinculo a Competências Atuais
SELECT 
    id AS ID_Lancamento,
    numero_documento AS Doc,
    data_lancamento AS Cadastro,
    competencia AS Competencia_Fato,
    DATEDIFF(data_lancamento, competencia) AS Desvio_Dias
FROM LANCAMENTO_RECEBER
WHERE DATEDIFF(data_lancamento, competencia) > 90;

-- 25- Auditoria de Parcelas com Baixas Parciais
SELECT 
    id AS ID_Parcela,
    id_lancamento_pagar AS ID_Lancamento,
    numero_parcela AS Parcela_Num,
    valor AS Valor_Original,
    valor_pago AS Pago_Ate_Momento,
    (valor - valor_pago) AS Saldo_Devedor_Residual
FROM PARCELA_PAGAR
WHERE id_status_parcela = 3;

-- 26- Histórico de Perdas Financeiras por Crédito Inadimplente Crítico
SELECT 
    PR.id AS ID_Parcela,
    LR.numero_documento AS Doc,
    PR.data_vencimento AS Vencimento,
    PR.valor AS Valor_Perda,
    DATEDIFF('2026-05-25', PR.data_vencimento) AS Dias_Inadimplencia
FROM PARCELA_RECEBER PR
JOIN LANCAMENTO_RECEBER LR ON PR.id_lancamento_receber = LR.id
WHERE PR.id_status_parcela IN (1, 4) AND DATEDIFF('2026-05-25', PR.data_vencimento) > 60;

-- 27- Relação Mensal entre Despesas com Impostos vs Custos com Insumos
SELECT 
    YEAR(LP.competencia) AS Ano,
    MONTH(LP.competencia) AS Mes,
    SUM(CASE WHEN NF.codigo = '2005' THEN LP.valor_total ELSE 0 END) AS Gastos_Impostos,
    SUM(CASE WHEN NF.codigo = '2002' THEN LP.valor_total ELSE 0 END) AS Gastos_Insumos,
    ROUND((SUM(CASE WHEN NF.codigo = '2005' THEN LP.valor_total ELSE 0 END) / 
           NULLIF(SUM(CASE WHEN NF.codigo = '2002' THEN LP.valor_total ELSE 0 END), 0)) * 100, 2) AS Carga_Tributaria_Relativa
FROM LANÇAMENTO_PAGAR LP
JOIN NATUREZA_FINANCEIRA NF ON LP.id_natureza_financeira = NF.id
GROUP BY Ano, Mes;

-- 28- Cruzamento de Disponibilidade Corrente vs Provisões Imediatas
SELECT 
    (SELECT saldo_final FROM FECHAMENTO_CAIXA_BANCO ORDER BY data_fechamento DESC LIMIT 1) AS Caixa_Disponivel_Real,
    COALESCE(SUM(PP.valor), 0) AS Provisao_Despesas_15_Dias,
    (SELECT saldo_final FROM FECHAMENTO_CAIXA_BANCO ORDER BY data_fechamento DESC LIMIT 1) - COALESCE(SUM(PP.valor), 0) AS Margem_Seguranca
FROM PARCELA_PAGAR PP
WHERE PP.id_status_parcela = 1 AND PP.data_vencimento BETWEEN '2026-05-25' AND DATE_ADD('2026-05-25', INTERVAL 15 DAY);

-- 29- Extratos de Crédito com Maior Impacto no Mês Atual
SELECT 
    id AS ID_Extrato,
    data_movimento AS Data,
    descricao AS Historico,
    valor AS Valor_Entrada
FROM EXTRATO_CONTA_BANCO
WHERE tipo_movimento = 'C'
ORDER BY valor DESC;

-- 30- Demonstrativo Geral de Saldos por Status de Carteiras
SELECT 
    SP.descricao AS Status_Parcela,
    COUNT(DISTINCT PP.id) AS Qtd_Contas_A_Pagar,
    COALESCE(SUM(PP.valor), 0) AS Total_Dividas,
    COUNT(DISTINCT PR.id) AS Qtd_Contas_A_Receber,
    COALESCE(SUM(PR.valor), 0) AS Total_Direitos
FROM STATUS_PARCELA SP
LEFT JOIN PARCELA_PAGAR PP ON PP.id_status_parcela = SP.id
LEFT JOIN PARCELA_RECEBER PR ON PR.id_status_parcela = SP.id
GROUP BY SP.id, SP.descricao;


