Map<String, dynamic> _arguments = {};

dynamic appArgs(String key) => _arguments[key];

void setArgs(String key, dynamic value) => _arguments[key] = value;
