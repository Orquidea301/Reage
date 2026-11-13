# 💛 ReAge — Aplicativo de Saúde e Bem-Estar para Idosos

O **ReAge** é um aplicativo mobile desenvolvido em **Flutter** voltado para o público idoso. O seu principal objetivo é promover a acessibilidade, o acompanhamento físico diário, a autonomia e a qualidade de vida através de uma interface limpa, com cores de alto contraste (paleta Amarelo e Creme) e botões fáceis de interagir.

---

## 📂 Estrutura de Pastas e Arquivos (`lib/`)

O projeto está organizado de forma modular, separando constantes, modelos, ecrãs (telas) e componentes reutilizáveis (widgets):

### 🎨 `lib/constants/`
* **`colors.dart`**: Define a paleta de cores oficial do aplicativo (Amarelo primário, Fundo creme, Textos escuros de alto contraste).

### 📦 `lib/models/`
* **`user_model.dart`**: Modela a estrutura de dados do utilizador (nome, peso, altura, idade, nível de atividade e foto).

### 📱 `lib/screens/` (Ecrãs Principais e Onboarding)
* **`main.dart`**: Ponto de entrada da aplicação e inicialização do Flutter.
* **`login_screen.dart`**:  inicial de autenticação/entrada no sistema.
* **`onboarding_page.dart`**: Fluxo inicial de boas-vindas e apresentação do aplicativo.
* **`register_screen.dart`**: Recolha do nome e dados básicos de identificação do utilizador.
* **`goals_screen.dart`**: Seleção dos objetivos principais de saúde do idoso.
* **`activity_level_screen.dart`**: Definição do nível de preparação física atual.
* **`body_concern_screen.dart`**: Identificação de focos corporais ou áreas de atenção.
* **`weight_screen.dart`**: Registo interativo de peso, altura e cálculo dinâmico do IMC.
* **`profile_photo_screen.dart`**: Seleção de foto da galeria do telemóvel ou avanço sem foto, carregamento animado.
* **`profile_screen.dart`**: Perfil principal do utilizador (Lobby com navegação inferior), exibindo os dados corporais reais e a foto escolhida.
* **`report_screen.dart`**: Relatório detalhado com métricas da semana, histórico de treinos e acompanhamento do IMC.
* **`workout_screen.dart`**: Área dedicada aos exercícios e rotinas de mobilidade recomendadas.
* **`home_screen.dart` / `dashboard_screen.dart` / `menu_screen.dart`**: Complementares de navegação e suporte estrutural.

### 🧩 `lib/widgets/` (Componentes Reutilizáveis)
* **`custom_button.dart`**: Botão personalizado com tamanho e fonte adaptados para alta acessibilidade.
* **`custom_input.dart`**: Campo de texto estilizado para recolha de dados sem fricção.
* **`header_nav.dart`**: Cabeçalhos e barras de navegação padronizadas.

---

## 🚀 Como Executar o Projeto

1. Certifique-se de ter o **Flutter** instalado na sua máquina.
2. Clone este repositório:
   ```bash
   git clone [https://github.com/seu-utilizador/reage-app.git](https://github.com/seu-utilizador/reage-app.git)