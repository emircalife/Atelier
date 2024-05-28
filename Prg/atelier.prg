***/
*
*	PROGRAMA		Atelier()
*	OBJETIVO		Programa principal do sistema Atelier
*
*	ARGUMENTOS	Sem argumentos
*
*	AUTOR			Márcio Las
*	DATA			02/01/2009
*
*/
#INCLUDE \sistema\megs\sistema\megs.h

PROCEDURE Atelier() AS VOID
	LOCAL lcVersao AS STRING
	LOCAL lcApp		AS STRING
	LOCAL loForm 	AS FORM

	*** Obtém a versão
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
	
	*** Estabele ligações com as classes
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsbase.vcx
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsctrl.vcx	ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsext.vcx		ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megssys.vcx		ADDITIVE 
	SET CLASSLIB TO \sistema\megs\sistema\vcx\megsform.vcx	ADDITIVE 

	SET CLASSLIB TO \sistema\megs\atelier\vcx\modulom.vcx	ADDITIVE
	SET CLASSLIB TO \sistema\megs\atelier\vcx\moduloe.vcx	ADDITIVE
	SET CLASSLIB TO \sistema\megs\atelier\vcx\modulog.vcx	ADDITIVE
	
	*** Cria formulário principal da aplicação (o objeto Principal é criado também aqui)
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
												 "Movimentações|Compras" + C_LF + ;
												 "Movimentações|Orçamentos" + C_LF + ;
												 "Movimentações|Vendas" + C_LF + ;
												 "Informações|Estoque" + C_LF + ;
												 "Informações|Relatórios" + C_LF + ;
												 "Gerência|Características de Produtos" + C_LF + ;
												 "Gerência|Unidades" + C_LF + ;
												 "Gerência|Estados" + C_LF + ;
												 "Gerência|Cidades" + C_LF + ;
												 "Gerência|Bairros" + C_LF + ;
												 "Gerência|Configurações" + C_LF + ;
												 "Gerência|Usuários" ;
											  )
			
			.executar()
		ENDWITH
	ELSE
		MessageBox( "Erro na criação do objeto principal da aplicação!", MB_ICONSTOP, C_EMPRESA )
	ENDIF
		
	*** Remove ligações com as classes visuais
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\modulog.vcx
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\moduloe.vcx
	RELEASE CLASSLIB \sistema\megs\atelier\vcx\modulom.vcx

	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsform.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megssys.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsext.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsctrl.vcx
	RELEASE CLASSLIB \sistema\megs\sistema\vcx\megsbase.vcx

	*** Remove objetos da memória
	RELEASE loForm
	RELEASE Aplicacao

	RETURN ( .NULL. )
ENDPROC
