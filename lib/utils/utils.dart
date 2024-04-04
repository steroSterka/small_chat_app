class Utils{


 static  String getDateAndTime(doc) {
  Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
  DateTime timestamp = data['timestamp'].toDate();
  String date = timestamp.toIso8601String().split('T')[0];
  String time = timestamp.toIso8601String().split('T')[1].substring(0, 5);
  String dateAndTime = '$date $time';
  return dateAndTime;
}
}