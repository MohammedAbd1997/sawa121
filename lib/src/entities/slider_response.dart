/// id : 1
/// title : "لا تتردد في الاتصال بالرقم المجاني لمؤسسة سوا 121 وإبلاغنا بأي مشكلة تتعرض/ي لها"
/// imgUrl : "/images/309ae2aa-0b12-4c3b-9580-8641ec4f2ed4_WhatsApp Image 2020-10-30 at 7.49.30 AM.jpeg"
/// description : "تطبيق سوا 121  يهدف إلى تشجيع جميع فئات المجتمع  رجال نساء وأطفال لتقديم ببلاغ لأي مشكلة يتعرض لها أي شخص ف يالمجتمع, حيث يوفر لهم خدمة الإتصال بالرقم المجاني لمؤسسة سوا 121, أو إرسال رسالة من خلال الواتساب, أو الإتصال بالرقم المجاني لمدينة القدس, كما يوفر أيضا خدمة الإتصال المجانية للشرطة والأسعاف.\r\n "
/// displayOrder : 1

class SliderResponse {
  int? id;
  String? title;
  String? imgUrl;
  String? description;
  int? displayOrder;

  SliderResponse.fromJson(dynamic json) {
    id = json['id'];
    title = json['title'];
    imgUrl = json['imgUrl'];
    description = json['description'];
    displayOrder = json['displayOrder'];
  }

}