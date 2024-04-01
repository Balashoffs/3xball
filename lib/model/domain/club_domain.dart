import 'dart:convert';
import 'dart:typed_data';

class ClubDomain {
  final String clubName;
  final String cityName;
  final String countryName;
  final String clubPhoto;

  Uint8List clubPhotoAsBytes(){
    if(clubPhoto.isNotEmpty) return  base64Decode(clubPhoto);
    return Uint8List(0);
  }

  ClubDomain({
    required this.clubName,
    required this.cityName,
    required this.countryName,
    this.clubPhoto = '',
  });

  ClubDomain.empty()
      : clubName = '',
        cityName = '',
        countryName = '',
        clubPhoto = '';
}
