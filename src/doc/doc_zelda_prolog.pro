% Melhor ação
	:-dynamic(melhoracao/1).

% Sensores
	:-dynamic(swordglow/2).
	:-dynamic(rupeeglow/2).
	:-dynamic(fairy/2).
	:-dynamic(noise/2).
	:-dynamic(breeze/2).
	:-dynamic(distortion/2).

% Posição
	:-dynamic(em/2).

% Direção
	:-dynamic(direcao/1).
	
% Energia do agente
	:-dynamic(energia/1).

% Casas inválidas (floresta)
	:-dynamic(invalida/2).
	
% Casas visitadas
	:-dynamic(visitada/2).
	
% Casas seguras
	:-dynamic(segura/2).
	:-dynamic(seguro/2).
	
% Casas seguras garantidas adicionadas à base de conhecimento
	:-dynamic(seguragarantido/2).
	
% Casas ameaçadas
	:-dynamic(ameacada/2).
	:-dynamic(possivel_inimigo/2).
	:-dynamic(possivel_buraco/2).
	:-dynamic(possivel_vortice/2).
	
% Casas atacadas
	:-dynamic(casa_atacada/2).
	
% Casas descobertas
	:-dynamic(tem_inimigo/2).
	:-dynamic(tem_buraco/2).
	:-dynamic(tem_vortice/2).
	:-dynamic(tem_coracao/2).

% Casas com inimigos (ou possíveis) que não valem a pena atacar
	:-dynamic(naovaleapena/2).
	
% Casas com inimigos (ou possíveis) que valem a pena atacar
	:-dynamic(valeapena/2).

% Casas seguras que mais valem a pena visitar
:-dynamic(especialsegura/2).

% Atualizações
	valida(X,Y) :- not(invalida(X,Y)).
	
	possivel_inimigo(X,Y) :- noise(W,Z), W is X, Z is Y-1 ; noise(W,Z), W is X, Z is Y+1 ; 
							 noise(W,Z), W is X-1, Z is Y ; noise(W,Z), W is X+1, Z is Y.
							
	possivel_buraco(X,Y) :- breeze(W,Z), W is X, Z is Y-1 ; breeze(W,Z), W is X, Z is Y+1 ; 
							breeze(W,Z), W is X-1, Z is Y ; breeze(W,Z), W is X+1, Z is Y.
							
	possivel_vortice(X,Y) :- distortion(W,Z), W is X, Z is Y-1 ; distortion(W,Z), W is X, Z is Y+1 ; 
							 distortion(W,Z), W is X-1, Z is Y ; distortion(W,Z), W is X+1, Z is Y.	
													
	ameacada(X,Y) :- possivel_inimigo(X,Y) ; possivel_buraco(X,Y) ; possivel_vortice(X,Y).
	
	segura(X,Y) :- not(ameacada(X,Y)), not(visitada(X,Y)), valida(X,Y).
	
	naovaleapena(X,Y) :- N is X-1, S is X+1, W is Y-1, E is Y+1, 
						(visitada(N,Y) ; seguragarantido(N,Y) ; not(valida(N,Y))),
						(visitada(S,Y) ; seguragarantido(S,Y) ; not(valida(S,Y))),
						(visitada(X,W) ; seguragarantido(X,W) ; not(valida(X,W))),
						(visitada(X,E) ; seguragarantido(X,E) ; not(valida(X,E))).
						
	valeapena(X,Y) :- not(naovaleapena(X,Y)).

	especialsegura(X,Y) :-  S is X+1, not(visitada(S,Y)), seguragarantido(S,Y).
	
	seguro(X,Y) :- not(ameacada(X,Y)), not(visitada(X,Y)), valida(X,Y).
			
% Ações prioritárias
	melhoracao(pegarmastersword) :- em(X,Y), swordglow(X,Y).
	melhoracao(pegarrupee) :- em(X,Y), rupeeglow(X,Y).
	melhoracao(pegarcoracao) :- em(X,Y), fairy(X,Y), energia(HP), HP =< 50.
	
% Ações de suporte
	melhoracao(andarestrelacoracao) :- tem_coracao(_,_), energia(HP), HP =< 10.
	
% Ações especiais
	melhoracao(rotacionardireita) :- em(X,Y), direcao(leste), especialsegura(X,Y), energia(HP), HP == 100.
	melhoracao(andar) :- em(X,Y), direcao(sul), especialsegura(X,Y), energia(HP), HP == 100.
	
% Ações evasivas
	melhoracao(atacar) :- em(X,Y), direcao(norte), W is X-1, tem_inimigo(W,Y), valeapena(W,Y), valida(W,Y), not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(sul), W is X+1, tem_inimigo(W,Y), valeapena(W,Y), valida(W,Y), not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(oeste), Z is Y-1, tem_inimigo(X,Z), valeapena(X,Z), valida(X,Z), not(casa_atacada(X,Z)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(leste), Z is Y+1, tem_inimigo(X,Z), valeapena(X,Z), valida(X,Z), not(casa_atacada(X,Z)), energia(HP), HP >= 20.	
	melhoracao(atacar) :- em(X,Y), direcao(norte), W is X-1, possivel_inimigo(W,Y), valeapena(W,Y), valida(W,Y), not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(sul), W is X+1, possivel_inimigo(W,Y), valeapena(W,Y), valida(W,Y), not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(oeste), Z is Y-1, possivel_inimigo(X,Z), valeapena(X,Z), valida(X,Z), not(casa_atacada(X,Z)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(leste), Z is Y+1, possivel_inimigo(X,Z), valeapena(X,Z), valida(X,Z), not(casa_atacada(X,Z)), energia(HP), HP >= 20.
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(norte), Z is Y-1, noise(X,Y), not(casa_atacada(X,Z)), valeapena(X,Z), valida(X,Z), energia(HP), HP >= 20.
	melhoracao(rotacionardireita) :- em(X,Y), direcao(norte), Z is Y+1, noise(X,Y), not(casa_atacada(X,Z)), valeapena(X,Z), valida(X,Z), energia(HP), HP >= 20.
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(sul), Z is Y+1, noise(X,Y), not(casa_atacada(X,Z)), valeapena(X,Z), valida(X,Z), energia(HP), HP >= 20.
	melhoracao(rotacionardireita) :- em(X,Y), direcao(sul), Z is Y-1, noise(X,Y), not(casa_atacada(X,Z)), valeapena(X,Z), valida(X,Z), energia(HP), HP >= 20.
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(oeste),  W is X+1, noise(X,Y), not(casa_atacada(W,Y)), valeapena(W,Y), valida(W,Y), energia(HP), HP >= 20.
	melhoracao(rotacionardireita) :- em(X,Y), direcao(oeste),  W is X-1, noise(X,Y), not(casa_atacada(W,Y)), valeapena(W,Y), valida(W,Y), energia(HP), HP >= 20.
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(leste),  W is X-1, noise(X,Y), not(casa_atacada(W,Y)), valeapena(W,Y), valida(W,Y), energia(HP), HP >= 20.
	melhoracao(rotacionardireita) :- em(X,Y), direcao(leste),  W is X+1, noise(X,Y), not(casa_atacada(W,Y)), valeapena(W,Y), valida(W,Y), energia(HP), HP >= 20.

% Ações secundárias
	melhoracao(andar) :- em(X,Y), direcao(norte), W is X-1, segura(W,Y), valida(W,Y), seguro(_,_).
	melhoracao(andar) :- em(X,Y), direcao(leste), Z is Y+1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(andar) :- em(X,Y), direcao(oeste), Z is Y-1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(andar) :- em(X,Y), direcao(sul), W is X+1, segura(W,Y), valida(W,Y), seguro(_,_).
	melhoracao(rotacionardireita) :- em(X,Y), direcao(norte), Z is Y+1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(norte), Z is Y-1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(rotacionardireita) :- em(X,Y), direcao(sul), Z is Y-1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(sul), Z is Y+1, segura(X,Z), valida(X,Z), seguro(_,_).
	melhoracao(rotacionardireita) :- em(X,Y), direcao(leste),  W is X+1, segura(W,Y), valida(W,Y), seguro(_,_).
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(leste),  W is X-1, segura(W,Y), valida(W,Y), seguro(_,_).
	melhoracao(rotacionardireita) :- em(X,Y), direcao(oeste),  W is X-1, segura(W,Y), valida(W,Y), seguro(_,_).
	melhoracao(rotacionaresquerda) :- em(X,Y), direcao(oeste),  W is X+1, segura(W,Y), valida(W,Y), seguro(_,_).	
	
% Ações terciárias
	melhoracao(andarestrela) :- em(X,Y), direcao(norte), W is X-1, visitada(W,Y), seguro(_,_).
	melhoracao(andarestrela) :- em(X,Y), direcao(sul), W is X+1, visitada(W,Y), seguro(_,_).
	melhoracao(andarestrela) :- em(X,Y), direcao(oeste), Z is Y-1, visitada(X,Z), seguro(_,_).
	melhoracao(andarestrela) :- em(X,Y), direcao(leste), Z is Y+1, visitada(X,Z), seguro(_,_).

% Ação básica
	melhoracao(rotacionaresquerda) :- em(_,_), seguro(_,_).

% Ações quaternárias.
	melhoracao(andarestrelainimigo) :- em(X,Y), not(noise(X,Y)), tem_inimigo(_,_), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(norte), W is X-1, not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(sul), W is X+1, not(casa_atacada(W,Y)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(oeste), Z is Y-1, not(casa_atacada(X,Z)), energia(HP), HP >= 20.
	melhoracao(atacar) :- em(X,Y), direcao(leste), Z is Y+1, not(casa_atacada(X,Z)), energia(HP), HP >= 20.	
	melhoracao(rotacionaresquerda) :- em(X,Y), noise(X,Y).
	
% Sem saída
	melhoracao(chorar).
