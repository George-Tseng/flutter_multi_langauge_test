import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart' show SynchronousFuture;
import 'package:flutter_localizations/flutter_localizations.dart';

class MyAppLocalizations {
  MyAppLocalizations(this.locale);

  final Locale locale;

  static MyAppLocalizations of(BuildContext context) {
    return Localizations.of<MyAppLocalizations>(context, MyAppLocalizations);
  }

  //在此撰寫多種語言字串的翻譯
  static Map<String, Map<String, String>> _localizedValues = {
    //這裡同時使用languageCode及countryCode，藉此區隔出中文家族(zh-Hans-CN、zh-Hant-HK、zh-Hant-TW)
    'en'+'US': {
      'title': 'To-Do List',
      'content': 'Test',
    },
    'zh'+'TW': {
      'title': '備忘錄',
      'content': '測試',
    },
    'zh'+'CN': {
      'title': '备忘录',
      'content': '测试',
    },
    'zh'+'Hant': {
      'title': '備忘錄',
      'content': '測試',
    },
    'zh'+'Hans': {
      'title': '备忘录',
      'content': '测试',
    },
  };

  //回傳翻譯後的特定字串
  String get title {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['title'];
    else 
      return _localizedValues[locale.languageCode+locale.scriptCode]['title'];
  }

  String get content {
    if(locale.countryCode != null)
      return _localizedValues[locale.languageCode+locale.countryCode]['content'];
    else
      return _localizedValues[locale.languageCode+locale.scriptCode]['content'];
  }
}

class MyAppLocalizationsDelegate extends LocalizationsDelegate<MyAppLocalizations> {
  const MyAppLocalizationsDelegate();

  //檢查執行環境是否支援所設定的語言
  @override
  //這裡同時使用languageCode及countryCode，藉此區隔出中文家族(zh-Hans-CN、zh-Hant-HK、zh-Hant-TW)
  bool isSupported(Locale locale) => (['en', 'zh'].contains(locale.languageCode) && ['US', 'TW', 'CN'].contains(locale.countryCode)) || (['zh'].contains(locale.languageCode) && ['Hans', 'Hant'].contains(locale.scriptCode));

  @override
  Future<MyAppLocalizations> load(Locale locale) {
    return SynchronousFuture<MyAppLocalizations>(MyAppLocalizations(locale));
  }

  //是否需要重載
  @override
  bool shouldReload(MyAppLocalizationsDelegate old) => false;
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(MyAppLocalizations.of(context).title),
      ),
      body: Center(
        child: Text(MyAppLocalizations.of(context).content),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateTitle: (BuildContext context) => MyAppLocalizations.of(context).title,
      localizationsDelegates: [
        const MyAppLocalizationsDelegate(),
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        //英文-美國
        const Locale.fromSubtags(languageCode: 'en', countryCode: 'US'),
        //中文-臺灣
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'TW'),
        //中文-中國
        const Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
        //中文-繁體
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hant'),
        //中文-簡體
        const Locale.fromSubtags(languageCode: 'zh', scriptCode: 'Hans'),
      ],
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: MyHomePage(),
    );
  }
}

void main() {runApp(MyApp());}