***/
*
*	PROGRAMA		Atelier()
*	OBJETIVO		Programa principal do sistema Atelier
*
*	ARGUMENTOS	Sem argumentos
*
*	AUTOR			M�rcio Las
*	DATA			02/01/2009
*
*/
#INCLUDE \sistema\megs\sistema\megs.h

PROCEDURE Atelier() AS VOID
	LOCAL lcVersao AS STRING
	LOCAL lcApp		AS STRING
	LOCAL loForm 	AS FORM

	*** Obt�m a vers�o
	TRY
		lcApp = Sys( 16 )
		IF ( "PROCEDURE " $ lcApp ) THEN 
			lcApp = SubStr( lcApp, At( " ", lcApp, 2 ) + 1 )
		ENDIF 

		AGetFileVersion( laVersao, lcApp )
		lcVersao = laVersao[ 4 ]
		
	CATCH 
		lcVersao = "" 
	ENDTRY
	
	*** Estabele liga��es com as classes
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsbase.vcx
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsctrl.vcx	ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsext.vcx		ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megssys.vcx		ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsform.vcx	ADDITIVE 

	SET CLASSLIB TO \sistema\megs\atelier\vcx\modulom.vcx	ADDITIVE
	SET CLASSLIB TO \sistema\megs\atelier\vcx\moduloe.vcx	ADDITIVE
	SET CLASSLIB TO \sistema\megs\atelier\vcx\modulog.vcx	ADDITIVE
	
	*** Cria formul�rio principal da aplica��o (o objeto Principal � criado tamb�m aqui)
	loForm = createObject( "Principal", lcVersao )

	IF ( Not IsNull( loForm ) ) THEN 
		WITH loForm
			.Icon 						= "\sistema\megs\atelier\img\ico\atelier.ico"
			.Titulo						= "Sistema Atelier"
			.BancoDeDadosDoSistema	= "dbatelier_PG"
			.MenuDoSistema				= "MenuDoSistemaAtelier"
			.PainelDeSistema 			= "PainelDeSistemaAtelier"
			
			.Permissoes					= ( "Cadastros|Grupos de Produtos" + C_LF + ;
												 "Cadastros|Produtos" + C_LF + ;
												 "Cadastros|Clientes" + C_LF + ;
												 "Cadastros|Fornecedores" + C_LF + ;
												 "Movimenta��es|Compras" + C_LF + ;
												 "Movimenta��es|Or�amentos" + C_LF + ;
												 "Movimenta��es|Vendas" + C_LF + ;
												 "Informa��es|Estoque" + C_LF + ;
												 "Informa��es|Relat�rios" + C_LF + ;
												 "Ger�ncia|Caracter�sticas de Produtos" + C_LF + ;
												 "Ger�ncia|Unidades" + C_LF + ;
												 "Ger�ncia|Estados" + C_LF + ;
												 "Ger�ncia|Cidades" + C_LF + ;
												 "Ger�ncia|Bairros" + C_LF + ;
												 "Ger�ncia|Configura��es" + C_LF + ;
												 "Ger�ncia|Usu�rios" ;
											  )
			
			.executar()
		ENDWITH
	ELSE
		MessageBox( "Erro na cria��o do objeto principal da aplica��o!", MB_ICONSTOP, C_EMPRESA )
	ENDIF
		
	*** Remove liga��es com as classes visuais
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\modulog.vcx
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\moduloe.vcx
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\modulom.vcx

	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsform.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megssys.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsext.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsctrl.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsbase.vcx

	*** Remove objetos da mem�ria
	RELEASE loForm
	RELEASE Aplicacao

	RETURN ( .NULL. )
ENDPROC
