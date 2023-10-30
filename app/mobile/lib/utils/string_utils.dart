import 'dart:convert';

class StringUtils {
  // Function to convert a Map<String, String> to JSON
  static String mapToJson(Map<String, String> data) {
    return json.encode(data);
  }

  // Function to convert JSON to a Map<String, String>
  static Map<String, String> jsonToMap(String jsonString) {
    Map<String, dynamic> jsonMap = json.decode(jsonString);
    // Convert the values to String
    Map<String, String> resultMap = {};
    jsonMap.forEach((key, value) {
      if (value is String) {
        resultMap[key] = value;
      } else {
        // Handle non-string values, e.g., numbers or booleans
        resultMap[key] = value.toString();
      }
    });
    return resultMap;
  }
}
