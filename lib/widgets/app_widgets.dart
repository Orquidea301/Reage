import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/app_theme.dart';
import '../constants/colors.dart';

/// Cartão padrão da aplicação com sombra e borda arredondada.
class AppCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color color;

  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.color = AppColors.card,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.cardBorder, width: 1),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0F5A4A2A),
            blurRadius: 18,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

/// Caixa de aviso com barra lateral destacada.
class NoticeBox extends StatelessWidget {
  final String text;

  const NoticeBox({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        color: AppColors.noticeFill,
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                width: 4,
                color: AppColors.noticeBorder,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                  child: Text(
                    text,
                    style: const TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Botão principal (amarelo) com suporte a expansão e ajuste de escala de texto.
class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool expand;
  final double height;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.expand = true,
    this.height = 56,
  });

  @override
  Widget build(BuildContext context) {
    final button = ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryYellow,
        foregroundColor: AppColors.onPrimary,
        disabledBackgroundColor: AppColors.progressTrack,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        minimumSize: Size(0, height),
        padding: const EdgeInsets.symmetric(horizontal: 16),
      ),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );

    if (expand) {
      return SizedBox(
        width: double.infinity,
        child: button,
      );
    }
    return button;
  }
}

/// Botão secundário (outline) com suporte opcional a ícone.
class SecondaryButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final double height;
  final IconData? icon;

  const SecondaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height = 56,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final style = OutlinedButton.styleFrom(
      backgroundColor: AppColors.field,
      foregroundColor: AppColors.textBody,
      disabledForegroundColor: AppColors.textDisabled,
      side: const BorderSide(color: AppColors.grayBorder, width: 1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14),
      ),
      minimumSize: Size(0, height),
      padding: const EdgeInsets.symmetric(horizontal: 16),
    );

    const textStyle = TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.bold,
    );

    if (icon != null) {
      return OutlinedButton.icon(
        onPressed: onPressed,
        style: style,
        icon: Icon(icon, size: 20),
        label: Text(label, style: textStyle),
      );
    }

    return OutlinedButton(
      onPressed: onPressed,
      style: style,
      child: Text(label, style: textStyle),
    );
  }
}

/// Logomarca circular da aplicação.
class LogoMark extends StatelessWidget {
  final double size;

  const LogoMark({
    super.key,
    this.size = 48,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/logo_reage_circulo.png',
      width: size,
      height: size,
      errorBuilder: (context, error, stackTrace) => SizedBox(
        width: size,
        height: size,
      ),
    );
  }
}

/// Campo de texto rotulado com suporte a senha e formatação.
class LabeledField extends StatefulWidget {
  final String label;
  final TextEditingController? controller;
  final String? hint;
  final TextInputType? keyboardType;
  final bool password;
  final TextInputAction textInputAction;
  final ValueChanged<String>? onSubmitted;
  final TextCapitalization capitalization;
  final int maxLines;
  final int? minLines;
  final bool suggestions;

  const LabeledField({
    super.key,
    required this.label,
    this.controller,
    this.hint,
    this.keyboardType,
    this.password = false,
    this.textInputAction = TextInputAction.next,
    this.onSubmitted,
    this.capitalization = TextCapitalization.none,
    this.maxLines = 1,
    this.minLines,
    this.suggestions = true,
  });

  @override
  State<LabeledField> createState() => _LabeledFieldState();
}

class _LabeledFieldState extends State<LabeledField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.password;
  }

  @override
  Widget build(BuildContext context) {
    Widget? suffixWidget;
    if (widget.password) {
      suffixWidget = IconButton(
        icon: Icon(
          _obscureText ? Icons.visibility : Icons.visibility_off,
          color: AppColors.textCaption,
        ),
        tooltip: _obscureText ? 'Mostrar senha' : 'Ocultar senha',
        onPressed: () {
          setState(() {
            _obscureText = !_obscureText;
          });
        },
      );
    }

    final enableSuggestions = widget.password ? false : widget.suggestions;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: AppText.label),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          textInputAction: widget.textInputAction,
          onSubmitted: widget.onSubmitted,
          textCapitalization: widget.capitalization,
          maxLines: widget.password ? 1 : widget.maxLines,
          minLines: widget.minLines,
          autocorrect: enableSuggestions,
          enableSuggestions: enableSuggestions,
          style: AppText.input,
          decoration: AppInput.decoration(
            hint: widget.hint,
            suffix: suffixWidget,
          ),
        ),
      ],
    );
  }
}

/// Menu dropdown rotulado.
class LabeledDropdown extends StatelessWidget {
  final String label;
  final String value;
  final List<String> options;
  final ValueChanged<String> onChanged;

  const LabeledDropdown({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppText.label),
        const SizedBox(height: 8),
        InputDecorator(
          decoration: AppInput.decoration(),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              isDense: true,
              dropdownColor: AppColors.pageWhite,
              borderRadius: BorderRadius.circular(14),
              style: AppText.input,
              icon: const Icon(Icons.keyboard_arrow_down, color: AppColors.textDark),
              value: options.contains(value) ? value : (options.isNotEmpty ? options.first : null),
              items: options.map((String option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(
                    option,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  onChanged(newValue);
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}

/// Slider de métricas numéricas com rótulo e valor exibido.
class MetricSlider extends StatelessWidget {
  final String label;
  final String valueText;
  final double value;
  final double min;
  final double max;
  final int? divisions;
  final ValueChanged<double> onChanged;

  const MetricSlider({
    super.key,
    required this.label,
    required this.valueText,
    required this.value,
    required this.min,
    required this.max,
    this.divisions,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final clampedValue = value.clamp(min, max).toDouble();

    return Container(
      decoration: BoxDecoration(
        color: AppColors.pageWhite,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.cardBorder, width: 1),
      ),
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 6),
      child: Column(
        children: [
          Row(
            children: [
              Text(label, style: AppText.label),
              const Spacer(),
              Text(
                valueText,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.gold,
                ),
              ),
            ],
          ),
          SliderTheme(
            data: SliderThemeData(
              trackHeight: 8,
              activeTrackColor: AppColors.primaryYellow,
              inactiveTrackColor: AppColors.progressTrack,
              thumbColor: AppColors.primaryYellow,
              thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 13),
              overlayColor: const Color(0x33F5AE32),
            ),
            child: Slider(
              value: clampedValue,
              min: min,
              max: max,
              divisions: divisions,
              onChanged: onChanged,
            ),
          ),
        ],
      ),
    );
  }
}

/// Link de autenticação (pergunta + ação clicável).
class AuthLink extends StatelessWidget {
  final String question;
  final String action;
  final VoidCallback onTap;

  const AuthLink({
    super.key,
    required this.question,
    required this.action,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        Text(
          question,
          style: const TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(width: 4),
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(4),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 4),
            child: Text(
              action,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.goldDark,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// Scaffold padronizado para telas de autenticação com fundo desfocado e cartão central.
class AuthScaffold extends StatelessWidget {
  final String title;
  final String? subtitle;
  final List<Widget> children;

  const AuthScaffold({
    super.key,
    required this.title,
    this.subtitle,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundCream,
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/fundo_cadastro.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
            ),
          ),
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(28),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 14, sigmaY: 14),
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(24, 28, 24, 20),
                        color: const Color(0xCCF3F0EC),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const LogoMark(size: 48),
                                const SizedBox(width: 14),
                                Text(
                                  'ReAge',
                                  style: AppText.title.copyWith(fontSize: 32),
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            Text(
                              title,
                              textAlign: TextAlign.center,
                              style: AppText.title,
                            ),
                            if (subtitle != null) ...[
                              const SizedBox(height: 8),
                              Text(
                                subtitle!,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                            const SizedBox(height: 24),
                            ...children,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
