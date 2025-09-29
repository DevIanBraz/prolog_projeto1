:- include('base_conhecimento.pl').

% REGRAS PRINCIPAIS

% Predicado para calcular pontuação de uma trilha
calcula_pontuacao(Trilha, Pontuacao) :-
    findall(Peso, (perfil(Trilha, Caracteristica, Peso), resposta_positiva(Caracteristica)), Pesos),
    sum_list(Pesos, Pontuacao).

% Verifica se o usuário respondeu positivamente para uma característica
resposta_positiva(Caracteristica) :-
    pergunta(_, _, Caracteristica),
    resposta(Caracteristica, s).

% Predicado para recomendar trilhas ordenadas por pontuação
recomenda(TrilhasRecomendadas) :-
    findall(pontuacao(Trilha, Pontuacao, Descricao), 
            (trilha(Trilha, Descricao), calcula_pontuacao(Trilha, Pontuacao)), 
            TodasTrilhas),
    sort(2, @>=, TodasTrilhas, TrilhasOrdenadas),
    extract_trilhas(TrilhasOrdenadas, TrilhasRecomendadas).

% Extrai apenas os nomes das trilhas da lista de pontuações
extract_trilhas([], []).
extract_trilhas([pontuacao(Trilha, _, _)|Resto], [Trilha|Trilhas]) :-
    extract_trilhas(Resto, Trilhas).

% Predicado para obter justificativa de uma recomendação
justificativa(Trilha, Justificativas) :-
    findall(Caracteristica-Peso, 
            (perfil(Trilha, Caracteristica, Peso), resposta_positiva(Caracteristica)), 
            Justificativas).

% Predicado para calcular compatibilidade em porcentagem
compatibilidade_porcentagem(Trilha, Porcentagem) :-
    calcula_pontuacao(Trilha, PontuacaoAtual),
    findall(Peso, perfil(Trilha, _, Peso), TodosPesos),
    sum_list(TodosPesos, PontuacaoMaxima),
    Porcentagem is (PontuacaoAtual / PontuacaoMaxima) * 100.
