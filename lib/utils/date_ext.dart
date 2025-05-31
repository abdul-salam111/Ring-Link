import 'package:intl/intl.dart';

extension VxDateTimeExtension on DateTime {
  ///
  ///Helps in converting the [DateTime] to readable Time Ago format of String.
  ///
  String timeAgo(
      {DateTime? clock, bool? enableFromNow, bool useShortForm = false}) {
    final mIsFromNowEnabled = enableFromNow ?? false;
    final mLanguage = English(shortForm: useShortForm);
    final mClock = clock ?? DateTime.now();
    var deltaTime = mClock.millisecondsSinceEpoch - millisecondsSinceEpoch;

    String pfx, sfx;

    if (mIsFromNowEnabled && deltaTime < 0) {
      deltaTime = isBefore(mClock) ? deltaTime : deltaTime.abs();
      pfx = mLanguage.prefixFromNow();
      sfx = mLanguage.suffixFromNow();
    } else {
      pfx = mLanguage.prefixAgo();
      sfx = mLanguage.suffixAgo();
    }

    final num seconds = deltaTime / 1000;
    final num minutes = seconds / 60;
    final num hours = minutes / 60;
    final num days = hours / 24;
    final num months = days / 30;
    final num years = days / 365;

    String res;
    if (seconds < 45) {
      res = mLanguage.lessThanOneMinute(seconds.round());
    } else if (seconds < 90) {
      res = mLanguage.aboutAMinute(minutes.round());
    } else if (minutes < 45) {
      res = mLanguage.minutes(minutes.round());
    } else if (minutes < 90) {
      res = mLanguage.aboutAnHour(minutes.round());
    } else if (hours < 24) {
      res = mLanguage.hours(hours.round());
    } else if (hours < 48) {
      res = mLanguage.aDay(hours.round());
    } else if (days < 30) {
      res = mLanguage.days(days.round());
    } else if (days < 60) {
      res = mLanguage.aboutAMonth(days.round());
    } else if (days < 365) {
      res = mLanguage.months(months.round());
    } else if (years < 2) {
      res = mLanguage.aboutAYear(months.round());
    } else {
      res = mLanguage.years(years.round());
    }
    return [pfx, res, sfx]
        .where((s) => s.isNotEmpty)
        .join(mLanguage.delimiter());
  }

  String toFriendlyDateTime() {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    final dateFormat = DateFormat('hh:mm a'); // Example: 10:30 AM
    final fullDateFormat =
        DateFormat('MMM dd, yyyy, hh:mm a'); // Example: Sep 14, 2024, 10:30 AM

    if (isSameDate(today)) {
      return 'Today, ${dateFormat.format(this)}';
    } else if (isSameDate(yesterday)) {
      return 'Yesterday, ${dateFormat.format(this)}';
    } else {
      return fullDateFormat.format(this);
    }
  }

  String toSimpleDate() {
    final dateFormat = DateFormat('MMMM d, yyyy');

    return dateFormat.format(this);
  }

  bool isSameDate(DateTime other) {
    return year == other.year && month == other.month && day == other.day;
  }
}

abstract class Language {
  /// flag for short form e.g(1 min) | long form e.g(1 minute ago)
  bool? shortForm;
  Language(this.shortForm);

  String prefixAgo();
  String prefixFromNow();

  String suffixAgo();
  String suffixFromNow();

  String lessThanOneMinute(int seconds);
  String aboutAMinute(int minutes);
  String minutes(int minutes);

  String aboutAnHour(int minutes);
  String hours(int hours);

  String aDay(int hours);
  String days(int days);

  String aboutAMonth(int days);
  String months(int months);

  String aboutAYear(int year);
  String years(int years);

  String delimiter() => ' ';
}

/// To use [English] language for timeAgo. More languages can be added in the future.
class English implements Language {
  @override
  bool? shortForm;
  English({bool shortForm = false}) {
    // ignore: prefer_initializing_formals
    this.shortForm = shortForm;
  }

  @override
  String prefixAgo() => '';
  @override
  String prefixFromNow() => '';
  @override
  String suffixAgo() => shortForm! ? '' : 'ago';
  @override
  String suffixFromNow() => shortForm! ? '' : 'from now';
  @override
  String lessThanOneMinute(int seconds) => shortForm! ? 'now' : 'a moment';
  @override
  String aboutAMinute(int minutes) => shortForm! ? '1 min' : 'a minute';
  @override
  String minutes(int minutes) =>
      shortForm! ? '$minutes min' : '$minutes minutes';
  @override
  String aboutAnHour(int minutes) => shortForm! ? '~1 h' : 'about an hour';
  @override
  String hours(int hours) => shortForm! ? '$hours h' : '$hours hours';
  @override
  String aDay(int hours) => shortForm! ? '~1 d' : 'a day';
  @override
  String days(int days) => shortForm! ? '$days d' : '$days days';
  @override
  String aboutAMonth(int days) => shortForm! ? '~1 mo' : 'about a month';
  @override
  String months(int months) => shortForm! ? '$months mo' : '$months months';
  @override
  String aboutAYear(int year) => shortForm! ? '~1 yr' : 'about a year';
  @override
  String years(int years) => shortForm! ? '$years yr' : '$years years';
  @override
  String delimiter() => ' ';
}
