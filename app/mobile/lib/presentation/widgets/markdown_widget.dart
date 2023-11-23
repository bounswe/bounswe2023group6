import 'package:flutter/widgets.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CustomMarkdownBody extends MarkdownWidget {
  const CustomMarkdownBody({
    Key? key,
    required String data,
    bool selectable = false,
    MarkdownStyleSheet? styleSheet,
    MarkdownStyleSheetBaseTheme? styleSheetTheme,
    SyntaxHighlighter? syntaxHighlighter,
    MarkdownTapLinkCallback? onTapLink,
    VoidCallback? onTapText,
    String? imageDirectory,
    List<md.BlockSyntax>? blockSyntaxes,
    List<md.InlineSyntax>? inlineSyntaxes,
    md.ExtensionSet? extensionSet,
    MarkdownImageBuilder? imageBuilder,
    MarkdownCheckboxBuilder? checkboxBuilder,
    Map<String, MarkdownElementBuilder> builders = const {},
    MarkdownListItemCrossAxisAlignment listItemCrossAxisAlignment =
        MarkdownListItemCrossAxisAlignment.baseline,
    this.shrinkWrap = true,
    this.fitContent = true,
    this.maxLines,
    this.overflow,
  }) : super(
          key: key,
          data: data,
          selectable: selectable,
          styleSheet: styleSheet,
          styleSheetTheme: styleSheetTheme,
          syntaxHighlighter: syntaxHighlighter,
          onTapLink: onTapLink,
          onTapText: onTapText,
          imageDirectory: imageDirectory,
          blockSyntaxes: blockSyntaxes,
          inlineSyntaxes: inlineSyntaxes,
          extensionSet: extensionSet,
          imageBuilder: imageBuilder,
          checkboxBuilder: checkboxBuilder,
          builders: builders,
          listItemCrossAxisAlignment: listItemCrossAxisAlignment,
        );

  final TextOverflow? overflow;
  final int? maxLines;

  /// See [ScrollView.shrinkWrap]
  final bool shrinkWrap;

  /// Whether to allow the widget to fit the child content.
  final bool fitContent;

  T? _findWidgetOfType<T>(Widget widget) {
    if (widget is T) {
      return widget as T;
    }

    if (widget is MultiChildRenderObjectWidget) {
      final MultiChildRenderObjectWidget multiChild = widget;
      for (final Widget child in multiChild.children) {
        return _findWidgetOfType<T>(child);
      }
    } else if (widget is SingleChildRenderObjectWidget) {
      final SingleChildRenderObjectWidget singleChild = widget;
      return _findWidgetOfType<T>(singleChild.child!);
    }

    return null;
  }

  @override
  Widget build(BuildContext context, List<Widget>? children) {
    final RichText? richText = _findWidgetOfType<RichText>(children!.single);
    if (richText != null) {
      return RichText(
        text: richText.text,
        textScaleFactor: richText.textScaleFactor,
        textAlign: richText.textAlign,
        maxLines: maxLines,
        overflow: overflow ?? TextOverflow.visible,
      );
    }

    return children.first;
  }
}