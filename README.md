# 💛 ReAge — Aplicativo de Saúde e Bem-Estar para Idosos

O **ReAge** é um aplicativo mobile desenvolvido em **Flutter** voltado para o público idoso. O seu principal objetivo é promover a acessibilidade, o acompanhamento físico diário, a autonomia e a qualidade de vida através de uma interface limpa, com cores de alto contraste (paleta Amarelo e Creme) e botões fáceis de interagir.

---

## 🏛️ Arquitetura

O projeto segue uma arquitetura modular em camadas bem definida:
* **Models**: Classes de dados imutáveis (com campos `final` e construtores `const`) que estruturam a informação da aplicação.
* **Services**: Camada responsável por fornecer dados estáticos ou gerir lógica externa (como planos de treino e notificações).
* **Controllers**: Classes de lógica de negócios e estado reativo (utilizando `ChangeNotifier` em conjunto com `ListenableBuilder` para atualizar a UI de forma eficiente).
* **Screens**: Ecrãs e interfaces de utilizador baseados em Material Design e componentes adaptados à acessibilidade.

---

## 📂 Estrutura de Pastas e Arquivos

O projeto está organizado na pasta `lib/`, com o ponto de entrada principal em `lib/main.dart` e os módulos organizados em `lib/src/`:

### 🚀 `lib/`
* **`main.dart`**: Ponto de entrada da aplicação e inicialização do Flutter.

### 🎨 `lib/src/constants/`
* **`colors.dart`**: Define a paleta de cores oficial do aplicativo (Amarelo primário, Fundo creme, Textos escuros de alto contraste).

### ⚙️ `lib/src/controllers/`
* **`history_controller.dart`**: Controller reativo (`ChangeNotifier`) que gere o estado do plano pessoal de 28 dias.
* **`profile_controller.dart`**: Controller reativo (`ChangeNotifier`) que gere o estado editável do perfil do utilizador.
* **`report_controller.dart`**: Processa os cálculos de IMC e a categorização de saúde.

### 📦 `lib/src/models/`
* **`exercise.dart`**: Modelo de dados tipado para cada exercício.
* **`plan_activity.dart`**: Modelo de dados para as atividades do plano de 28 dias.
* **`user_model.dart`**: Modelo de dados imutável do utilizador (`name`, `age`, `weight`, `height`, `mainGoal`).
* **`workout_category.dart`**: Modelo de dados para as categorias de treino.

### 📱 `lib/src/screens/`
* **`activity_level_screen.dart`**: Avaliação do nível de atividade física do utilizador.
* **`body_concern_screen.dart`**: Identificação de desconfortos ou preocupações corporais.
* **`dashboard_screen.dart`**: Ecrã principal de navegação com barra inferior (Lobby).
* **`goals_screen.dart`**: Seleção de objetivos de saúde e foco.
* **`history_screen.dart`**: Visualização do plano pessoal de 28 dias e conclusão de atividades.
* **`home_screen.dart`**: Ecrã inicial alternativo ou de suporte.
* **`login_screen.dart`**: Ecrã de autenticação e entrada no sistema.
* **`menu_screen.dart`**: Menu de navegação e opções.
* **`onboarding_screen.dart`**: Fluxo inicial de boas-vindas e apresentação do aplicativo.
* **`profile_photo_screen.dart`**: Seleção de foto de perfil na galeria ou avanço sem foto.
* **`profile_screen.dart`**: Ecrã de perfil do utilizador e hub de navegação.
* **`register_screen.dart`**: Registo de novos utilizadores com validação.
* **`report_screen.dart`**: Relatório detalhado com métricas e cálculo do IMC.
* **`weight_screen.dart`**: Registo interativo de peso, altura e idade.
* **`workout_screen.dart`**: Área dedicada aos exercícios e rotinas de mobilidade em casa.

### 🔌 `lib/src/services/`
* **`notification_service.dart`**: Serviço de gestão de notificações locais.
* **`plan_service.dart`**: Fornece os dados iniciais e padrões para o plano de 28 dias.

### 🧩 `lib/src/widgets/`
* **`custom_button.dart`**: Botão personalizado de alta acessibilidade.
* **`custom_input.dart`**: Campo de texto estilizado.
* **`header_nav.dart`**: Cabeçalhos e barras de navegação padronizadas.

---

### Versão do Flutter:
* Flutter 3.47.5 
* Dart 3.13.4 
* DevTools 2.60.0

---

## 🚀 Como Executar o Projeto

1. Certifique-se de ter o **Flutter** instalado na sua máquina.
2. Clone este repositório:
   ```bash
   git clone https://github.com/seu-utilizador/reage-app.git
   ```
