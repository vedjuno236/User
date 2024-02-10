import 'package:intl/intl.dart';

String formatDuration(DateTime departureTime , DateTime arrivalTime) {

  DateFormat timeFormat = DateFormat('HH:mm:ss');

  String departureTimeStr = timeFormat.format(departureTime) ;
  String arrivalTimeStr = timeFormat.format(arrivalTime);


  DateTime departureTimeParse = timeFormat.parse(departureTimeStr);
  DateTime arrivalTimeParse = timeFormat.parse(arrivalTimeStr);

  Duration duration = arrivalTimeParse.difference(departureTimeParse);

  int hours = duration.inHours;
  int minutes = (duration.inMinutes % 60);

  String formattedDuration = '';
  if (hours > 0) {
    formattedDuration += '$hours ${hours == 1 ? 'ຊົ່ວໂມງ' : 'ຊົ່ວໂມງ'}';
  }
  if (minutes > 0) {
    if (formattedDuration.isNotEmpty) {
      formattedDuration += ' ';
    }
    formattedDuration += '$minutes ${minutes == 1 ? 'ນາທີ' : 'ນາທີ'}';
  }

  return formattedDuration;
}

final oCcy = NumberFormat("#,##0", "en_US");
