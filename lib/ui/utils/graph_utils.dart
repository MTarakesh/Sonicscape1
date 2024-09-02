String getPointStringFromTimeStamp(double timeStamp) {
  var date = DateTime.fromMillisecondsSinceEpoch(timeStamp.toInt());
  return "${date.minute}:${date.second}";
}
