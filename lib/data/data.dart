import '../datamodel/datamodel.dart';

List<currencydata> currencytypedata = [];
List<List<currencydata>> currencytypedata2 = [];
List<String> type = ["1H", "1W", "1M", "1Y"];
List<int> showtype = [3, 6, 7, 8];
List<int> notificationtime = [1, 5, 15, 30, 1, 4, 8, 1, 7, 1, 1];
List<String> notificationtimename = [
  "realtime",
  "5mins",
  "15mins",
  "30mins",
  "1H",
  "4H",
  "8H",
  "1D",
  "1W",
  "1M",
  "1Y"
];
List<String> notificationtimename_1 = [
  "Real time",
  "5 mins",
  "15 mins",
  "30 mins",
  "1 Hour",
  "4 Hours",
  "8 Hours",
  "1 Day",
  "1 Week",
  "1 Month",
  "1 Year"
];
int cnotificationtime = 0;
var updatetime;
int cid = 6;
List<int> cupdate = [0, 0, 1, 3, 6, 0];
List<int> sortsequency = [0, 1, 2, 3, 4, 5, 6, 7];
List<List<int>> sortsequency_2 = [
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
  [0, 1, 2, 3, 4, 5, 6, 7],
];
var updatetime_2 = [
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now(),
  DateTime.now()
];
List<String> urls = [
  "http://zapp.fxsonic.com/rate/view",
  "http://zapp.fxsonic.com/support/view",
  "http://zapp.fxsonic.com/about/view",
  "http://zapp.fxsonic.com/share/view",
  "http://zapp.fxsonic.com/privacy/view",
  "http://zapp.fxsonic.com/term/view"
];
List<String> menuname = [
  "Rate us",
  "Support",
  "About us",
  "Share",
  "Privacy Policy",
  "Term of service"
];
double totalrate = 10;
String fcmtoken = "";
List<bool> notification_time = [
  false,
  true,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];
List<String> s_w_times = [
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
  '',
];
var s_w_data = null;

//review
List<ReviewModel> reviewdata=[];
