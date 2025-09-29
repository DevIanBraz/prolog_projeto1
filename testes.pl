:- include('interface_usuario.pl').

% Predicado para executar todos os testes
executa_testes :-
    writeln('=== EXECUTANDO TESTES AUTOMATIZADOS ==='),
    nl,
    teste_perfil_1,
    nl,
    teste_perfil_2,
    nl,
    teste_perfil_3.

% Teste do perfil 1 (Ciência de Dados)
teste_perfil_1 :-
    writeln('TESTE 1: Perfil de Ciência de Dados'),
    consult('perfil_teste_1.pl'),
    recomenda(Trilhas),
    (   member(ciencia_dados, Trilhas),
        writeln('✓ TESTE 1 APROVADO: Ciência de Dados recomendada corretamente')
    ;   writeln('✗ TESTE 1 FALHOU: Ciência de Dados não foi recomendada')
    ),
    unload_file('perfil_teste_1.pl').

% Teste do perfil 2 (Desenvolvimento Web)
teste_perfil_2 :-
    writeln('TESTE 2: Perfil de Desenvolvimento Web'),
    consult('perfil_teste_2.pl'),
    recomenda(Trilhas),
    (   member(desenvolvimento_web, Trilhas),
        writeln('✓ TESTE 2 APROVADO: Desenvolvimento Web recomendado corretamente')
    ;   writeln('✗ TESTE 2 FALHOU: Desenvolvimento Web não foi recomendado')
    ),
    unload_file('perfil_teste_2.pl').

% Teste do perfil 3 (Segurança da Informação)
teste_perfil_3 :-
    writeln('TESTE 3: Perfil de Segurança da Informação'),
    consult('perfil_teste_3.pl'),
    recomenda(Trilhas),
    (   member(seguranca_informacao, Trilhas),
        writeln('✓ TESTE 3 APROVADO: Segurança da Informação recomendada corretamente')
    ;   writeln('✗ TESTE 3 FALHOU: Segurança da Informação não foi recomendada')
    ),
    unload_file('perfil_teste_3.pl').

% Predicado para testar um perfil específico
testa_perfil(ArquivoPerfil) :-
    format('Testando perfil: ~w~n', [ArquivoPerfil]),
    consult(ArquivoPerfil),
    calcula_e_exibe_resultado,
    unload_file(ArquivoPerfil).
