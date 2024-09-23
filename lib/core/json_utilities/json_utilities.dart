import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// Helper function to handle Integer from JSON
int fromJsonInt(dynamic value) {
  if (value is int) {
    return value;
  } else if (value is String) {
    return int.tryParse(value) ?? 0;
  } else {
    return 0; // Default value if null or invalid
  }
}

// Helper function to handle Double from JSON
double fromJsonDouble(dynamic value) {
  if (value is double) {
    return value;
  } else if (value is String) {
    return double.tryParse(value) ?? 0.0;
  } else if (value is int) {
    return value.toDouble(); // Convert integer to double
  } else {
    return 0.0; // Default value if null or invalid
  }
}

// Helper function to handle String from JSON
String fromJsonString(dynamic value) {
  if (value is String) {
    return value;
  } else if (value != null) {
    return value.toString(); // Convert non-null value to String
  } else {
    return ''; // Default value if null
  }
}

// Helper function to handle Boolean from JSON
bool fromJsonBool(dynamic value) {
  if (value is bool) {
    return value;
  } else if (value is String) {
    return value.toLowerCase() == 'true'; // Convert 'true' string to bool
  } else if (value is int) {
    return value == 1; // Convert 1 to true, 0 to false
  } else {
    return false; // Default value if null or invalid
  }
}

// Helper function to handle List from JSON, return empty if null or invalid
List<T> fromJsonList<T>(dynamic value, T Function(dynamic) fromJson) {
  if (value == null || (value is List && value.isEmpty)) {
    return <T>[]; // Return an empty list if null or empty
  } else if (value is List) {
    return value.map(fromJson).toList(); // Return the casted list if valid
  } else {
    return <T>[]; // Return an empty list if not a valid list
  }
}

// Helper function to handle custom objects from JSON, ensuring it's a valid Map
T fromJsonObject<T>(dynamic value, T Function(Map<String, dynamic>) fromJson) {
  if (value is Map<String, dynamic>) {
    return fromJson(value);
  } else {
    throw Exception(
        "Invalid JSON object for type $T. Expected Map<String, dynamic> but got ${value.runtimeType}");
  }
}

// Helper function to handle DateTime from ISO 8601 format
DateTime? fromJsonDateTime(dynamic value) {
  if (value is String) {
    try {
      return DateTime.parse(value);
    } catch (e) {
      return null; // Return null if parsing fails
    }
  } else if (value is int) {
    return DateTime.fromMillisecondsSinceEpoch(
        value * 1000); // Convert timestamp to DateTime
  } else {
    return null; // Default to null if invalid
  }
}

// Helper function to handle custom DateTime formats
DateTime? fromCustomDateTimeString(String? value, String format) {
  if (value != null) {
    try {
      return DateFormat(format).parse(value);
    } catch (e) {
      return null;
    }
  }
  return null;
}

// Helper function to handle only TimeOfDay from JSON
TimeOfDay? fromCustomTimeString(String? value, String format) {
  if (value != null) {
    try {
      final parsedTime = DateFormat(format).parse(value);
      return TimeOfDay(hour: parsedTime.hour, minute: parsedTime.minute);
    } catch (e) {
      return null;
    }
  }
  return null;
}

// Helper function to handle File paths from JSON
File? fromJsonFile(dynamic path) {
  if (path is String && path.isNotEmpty) {
    return File(path);
  }
  return null;
}

List<File> fromJsonFiles(dynamic value) {
  if (value is List) {
    return value.map((item) => fromJsonFile(item)).whereType<File>().toList();
  }
  return <File>[];
}

// Helper function to format TimeOfDay as a String
String formatTimeOfDay(BuildContext context, TimeOfDay time) {
  final localizations = MaterialLocalizations.of(context);
  return localizations.formatTimeOfDay(time,
      alwaysUse24HourFormat: true); // Format to 24-hour format
}

// Helper function to convert DateTime to custom format string
String formatCustomDateTime(DateTime? dateTime, String format) {
  return dateTime != null ? DateFormat(format).format(dateTime) : '';
}
