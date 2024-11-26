# combustivelApp

combustivelApp é um aplicativo de gestão de um posto de combustivel desenvolvido com Flutter. Ele permite adicionar, editar, listar e excluir veiculos como nome, modelos, ano, placa. Também possui autenticação por firebase e persitencia de dados pelo firestore. É um projeto simples, mas serve como exemplo prático de como implementar uma lista de contatos e manipulá-los com a ajuda de widgets do Flutter.

## Funcionalidades
# Veiculos
- **Adicionar veiculo:** O usuário pode cadastrar um novo veiculo inserindo nome, modelo, ano e placa.
- **Editar veiculo:** O usuário pode atualizar as informações de um veiculo existente.
- **Deletar veiculo:** O usuário pode excluir um veiculo da lista.
- **Listar veiculo:** Todos os veiculo cadastrados são exibidos em uma lista interativa, permitindo fácil visualização e gerenciamento.
# Abastecimentos
- **Adicionar abastecimento:** O usuário pode cadastrar um novo abastecimento inserindo quantidade, quilometragem e data.
- **Listar abastecimento:** Todos os abastecimento cadastrados são exibidos em uma lista interativa, permitindo fácil visualização e gerenciamento.
# Perfil
- **Editar usuario:** O usuário pode atualizar as informações pessoais, como nome.
# Menu
- **Home**: rota para a tela principal.
- **Meus Veículos**: rota para a tela de listagem de veiculos.
- **Adicionar Veículo**: rota para a tela de listagem de veiculos.
- **Histórico de Abastecimentos**: rota para a tela de listagem de abastecimentos.
- **Perfil**: rota para a tela de perfil do usuario.
- **Logout**: rota para a tela de login.

  
## Estrutura do Projeto

- `lib/`
  - `model/`
    - **abastecimento.dart**: Define a estrutura do modelo de dados.
    - **veiculo.dart**: Define a estrutura do modelo de dados.
    - **usuario.dart**: Define a estrutura do modelo de dados .
  - `repository/`
    - **hisotoricoRepository.dart**: Implementa a lógica para listar, adicionar e remover contatos.
    - **usuarioRepository.dart**: Implementa a lógica para listar, adicionar e remover contatos.
    - **veiculoRepository.dart**: Implementa a lógica para listar, adicionar e remover contatos.
  - `auth/`
    - **authFirebase.dart**: Implementa a lógica para buildar o o firebase.
  - `widget/`
    - **appDrawer.dart**: menu de intercação entre as telas por meio das rotas.
    - **autenticaçaoUser.dart**: Ponto de entrada do aplicativo, carrega a tela de listagem de veiculos.
    - **cadastroVeiculo.dart**: arrega a tela de cadastro de veiculos.
    - **historicoAbastecimento.dart**: carrega a tela de listagem de abastecimentos.
    - **listagemVeiculos.dart**: carrega a tela de listagem de veiculos.
    - **perfil.dart**: carrega a tela de perfil do usuario.
    - **registroAbastecimento.dart**: carrega a tela de cadastro de abastecimento.
  - **main.dart**: run do app.
  - **firebase_options.dart**: Arquivo de configuração do firebase

## Instalação

1. Clone este repositório:
   ```bash
   git clone https://github.com/seu-usuario/combustivelApp.git
   cd agendaapp
