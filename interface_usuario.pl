:- include('motor_inferencia.pl').

% PREDICADO PRINCIPAL
iniciar :-
    limpar_base_respostas,
    writeln('=== SISTEMA ESPECIALISTA PARA RECOMENDAÇÃO DE TRILHA ACADÊMICA ==='),
    writeln(''),
    writeln('Responda as perguntas abaixo com "s" para SIM ou "n" para NÃO'),
    writeln(''),
    faz_perguntas,
    calcula_e_exibe_resultado.

% Limpa respostas anteriores
limpar_base_respostas :-
    retractall(resposta(_, _)).

% Faz todas as perguntas ao usuário
faz_perguntas :-
    pergunta(Numero, Pergunta, Caracteristica),
    faz_pergunta(Numero, Pergunta, Caracteristica),
    fail.
faz_perguntas.

% Faz uma pergunta individual
faz_pergunta(Numero, Pergunta, Caracteristica) :-
    format('~w. ~w (s/n): ', [Numero, Pergunta]),
    read(Resposta),
    valida_resposta(Resposta),
    assertz(resposta(Caracteristica, Resposta)),
    nl.

% Valida a resposta do usuário
valida_resposta(s).
valida_resposta(n).
valida_resposta(Resposta) :-
    \+ member(Resposta, [s, n]),
    writeln('Resposta inválida! Digite "s" para SIM ou "n" para NÃO.'),
    fail.

% Calcula e exibe os resultados
calcula_e_exibe_resultado :-
    writeln(''),
    writeln('=== PROCESSANDO SUAS RESPOSTAS... ==='),
    writeln(''),
    recomenda(TrilhasRecomendadas),
    exibe_resultado(TrilhasRecomendadas).

% Exibe o resultado final
exibe_resultado([]) :-
    writeln('Não foi possível recomendar uma trilha específica.'),
    writeln('Tente refazer o questionário com respostas mais definidas.').

exibe_resultado([PrimeiraTrilha|OutrasTrilhas]) :-
    writeln('=== TRILHAS RECOMENDADAS ==='),
    writeln(''),
    exibe_trilha_detalhada(PrimeiraTrilha, 1),
    (   OutrasTrilhas \= []
    ->  writeln(''),
        writeln('=== OUTRAS OPÇÕES ==='),
        exibe_outras_trilhas(OutrasTrilhas, 2)
    ;   true
    ).

% Exibe uma trilha com detalhes completos
exibe_trilha_detalhada(Trilha, Posicao) :-
    trilha(Trilha, Descricao),
    compatibilidade_porcentagem(Trilha, Porcentagem),
    justificativa(Trilha, Justificativas),
    
    format('~wª RECOMENDAÇÃO: ~w (~1f% de compatibilidade)~n', [Posicao, Trilha, Porcentagem]),
    format('Descrição: ~w~n', [Descricao]),
    writeln('Justificativa:'),
    exibe_justificativas(Justificativas).

% Exibe outras trilhas recomendadas
exibe_outras_trilhas([], _).
exibe_outras_trilhas([Trilha|Resto], Posicao) :-
    trilha(Trilha, Descricao),
    compatibilidade_porcentagem(Trilha, Porcentagem),
    format('~w. ~w (~1f%): ~w~n', [Posicao, Trilha, Porcentagem, Descricao]),
    NovaPosicao is Posicao + 1,
    exibe_outras_trilhas(Resto, NovaPosicao).

% Exibe as justificativas para a recomendação
exibe_justificativas([]).
exibe_justificativas([Caracteristica-Peso|Resto]) :-
    pergunta(_, Pergunta, Caracteristica),
    format('  - ~w (Relevância: ~w/5)~n', [Pergunta, Peso]),
    exibe_justificativas(Resto).
