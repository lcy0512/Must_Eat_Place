/* 
    Description : Firebase의 Model 
    Author 		: Lcy
    Date 			: 2024.04.07
*/

class FireBaseReview {
  String? id;
  String name;
  String phone;
  double lat;
  double long;
  String? image;
  String estimate;
  String initdate;

  FireBaseReview ({
    this.id,
    required this.name,
    required this.phone,
    required this.lat,
    required this.long,
    required this.image,
    required this.estimate,
    required this.initdate,
  });

}