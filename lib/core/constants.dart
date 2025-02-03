  const String BaseUrl = 'https://api.le.odvertising.com/';
  const String AppConfigurationsImageUrl = 'https://api.le.odvertising.com/storage';

  /// type of request : [RequestType.POST] or [RequestType.GET]
  enum RequestType { GET, POST, PUT, DELETE }


///  قيد المعالج
///  تمت المعالجة
//   تم حجز موعد
//   تم إنهاء الطلب
  enum OrderStatus { InProcessing, Processed, Booked, Completed,Failed }

  // api requests types
  enum ParametersType { Body, Url }

  const int Pagelimit = 3;
  String countryJsonData = '''
  [
    { "code": "sa", "name": "السعودية" },
    { "code": "ae", "name": "الإمارات" },
    { "code": "bh", "name": "البحرين" },
    { "code": "qa", "name": "قطر" },
    { "code": "om", "name": "عُمان" },
    { "code": "kw", "name": "الكويت" },
    { "code": "jo", "name": "الأردن (رقم وطني)" },
    { "code": "sy", "name": "سوري" }
  ]
  ''';