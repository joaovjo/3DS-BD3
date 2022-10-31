/*

Trigger

Automatiza eventos acionados por gatilhos em tabelas ou views
--------------------------------------------------------------

Tipos de Eventos:

Insert, Update, Delete

--OCORR�NCIA
	* FOR - Padr�o
	* AFTER - Espera o evento acabar para iniciar o script
	* INSTEAD OF - Executar antes do evento terminar

*/
--CRIA UMA TABELA TEMPORARIA INSERTED (INSERIR)
--DELETE, UPDATE TABELA TMP DELETED
--Comando para criar o Trigger


CREATE TRIGGER TRG_PEDIDO ON TB_ITENS_PED
AFTER INSERT
AS
BEGIN
	DECLARE @TOTAL DECIMAL(10,2),
			@N_PED INT;
	--PEGAR O REGISTRO DA TABELA TMP INSERED QUANDO INSERIDO
	SELECT @N_PED = N_PED FROM inserted 

	--PEGAR A QUANTIDADE DE PRODUTOS, VALOR E SOMAR O TOTAL

	SELECT @TOTAL = SUM(TB_LIVRO.PRECO_LIV * TB_ITENS_PED.QTD_ITEM)
	FROM TB_LIVRO INNER JOIN TB_ITENS_PED
	ON TB_LIVRO.COD_LIV = TB_ITENS_PED.COD_LIV
	WHERE TB_ITENS_PED.N_PED  = @N_PED;


	UPDATE TB_PEDIDO
	SET VALOR_PED = @TOTAL
	WHERE N_PED = @N_PED;

END
GO

/*

INSERIR NA TABELA PEDIDO VALOR
PADR�O - INICIO

*/
DECLARE @ID INT;

INSERT INTO TB_PEDIDO (
	COD_CLI,
	VALOR_PED,
	DATA_PED
	)
VALUES (1, 0, GETDATE());

-- PEGAR AUTOMATICAMENTE O ID INSERIDO

SELECT @ID = SCOPE_IDENTITY();

-- Quando deletas os itens do pedidos zera o valor total
/*DELETE
FROM TB_ITENS_PED;*/

-- Inserir itens pedido
INSERT INTO TB_ITENS_PED (
	N_PED,
	COD_LIV,
	QTD_ITEM
	)
VALUES (@ID, 2, 2), 
	   (@ID, 4, 1);

select * from TB_ITENS_PED
select * from TB_PEDIDO


----------------------------------24/10/2022--------------------------------------

