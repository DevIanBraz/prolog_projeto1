% SISTEMA ESPECIALISTA PARA RECOMENDAÇÃO DE TRILHA ACADÊMICA
% Disciplina: Programação Logica e Funcional
% Desenvolvido por: [Ian Carlo Araújo Braz]

:- include('interface_usuario.pl').
:- include('testes.pl').

% Menu principal
menu_principal :-
    writeln('================================='),
    writeln('  SISTEMA ESPECIALISTA - TRILHAS'),
    writeln('================================='),
    writeln(''),
    writeln('1. Iniciar questionário interativo'),
    writeln('2. Executar todos os testes'),
    writeln('3. Testar perfil específico'),
    writeln('4. Sair'),
    writeln(''),
    write('Escolha uma opção: '),
    read(Opcao),
    executa_opcao(Opcao).

executa_opcao(1) :-
    iniciar,
    menu_principal.

executa_opcao(2) :-
    executa_testes,
    menu_principal.

executa_opcao(3) :-
    writeln(''),
    writeln('Perfis disponíveis:'),
    writeln('a) perfil_teste_1.pl - Ciência de Dados'),
    writeln('b) perfil_teste_2.pl - Desenvolvimento Web'),
    writeln('c) perfil_teste_3.pl - Segurança da Informação'),
    writeln(''),
    write('Escolha o perfil (a/b/c): '),
    read(Escolha),
    seleciona_perfil(Escolha, Arquivo),
    testa_perfil(Arquivo),
    menu_principal.

executa_opcao(4) :-
    writeln('Saindo do sistema...').

executa_opcao(_) :-
    writeln('Opção inválida!'),
    menu_principal.

seleciona_perfil(a, 'perfil_teste_1.pl').
seleciona_perfil(b, 'perfil_teste_2.pl').
seleciona_perfil(c, 'perfil_teste_3.pl').

% Inicialização do sistema
:- initialization(menu_principal).
