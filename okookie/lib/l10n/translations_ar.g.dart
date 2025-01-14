///
/// Generated file. Do not edit.
///
// coverage:ignore-file
// ignore_for_file: type=lint, unused_import

import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:slang/generated.dart';
import 'translations.g.dart';

// Path: <root>
class TranslationsAr extends Translations {
  /// You can call this constructor and build your own translation instance of this locale.
  /// Constructing via the enum [AppLocale.build] is preferred.
  TranslationsAr({Map<String, Node>? overrides, PluralResolver? cardinalResolver, PluralResolver? ordinalResolver})
      : assert(overrides == null, 'Set "translation_overrides: true" in order to enable this feature.'),
        $meta = TranslationMetadata(
          locale: AppLocale.ar,
          overrides: overrides ?? {},
          cardinalResolver: cardinalResolver,
          ordinalResolver: ordinalResolver,
        ),
        super(cardinalResolver: cardinalResolver, ordinalResolver: ordinalResolver);

  /// Metadata for the translations of <ar>.
  @override
  final TranslationMetadata<AppLocale, Translations> $meta;

  late final TranslationsAr _root = this; // ignore: unused_field

  // Translations
  @override
  String get locale => 'ar';
  @override
  String get orderNow => 'اطلب الآن';
  @override
  String get loginTitle => 'تسجيل الدخول';
  @override
  String get loginSubtitle => 'سجل الدخول  على حسابك';
}
