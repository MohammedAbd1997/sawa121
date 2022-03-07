/// aboutDtos : [{"id":1,"content":"سوا مؤسسة فلسطينية رائدة تأسست عام 1998, وتلتزم بتوفير الدعم والحماية والإرشاد الاجتماعي لضحايا العنف, وخدمات التوعية المجتمعية, حيث تتمثل أولوية المؤسسة في مناهضة كافة أشكال العنف والإساءة والإهمال ضد النساء والأطفال, وتسعى للتشبيك مع الجهات والأطراف المجتمعية ذات الصلة لنشر وترويج قيم الإنسانية والمساواة على أساس النوع الإجتماعي بهدف إيجاء حياة كريمة للأفراد ومجتمع أكثر أمناً"}]

class AboutUsResponse {
  List<AboutDtos>? aboutDtos;

  AboutUsResponse({this.aboutDtos});

  AboutUsResponse.fromJson(dynamic json) {
    if (json['aboutDtos'] != null) {
      aboutDtos = [];
      json['aboutDtos'].forEach((v) {
        aboutDtos?.add(AboutDtos.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (aboutDtos != null) {
      map['aboutDtos'] = aboutDtos?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

/// id : 1
/// content : "سوا مؤسسة فلسطينية رائدة تأسست عام 1998, وتلتزم بتوفير الدعم والحماية والإرشاد الاجتماعي لضحايا العنف, وخدمات التوعية المجتمعية, حيث تتمثل أولوية المؤسسة في مناهضة كافة أشكال العنف والإساءة والإهمال ضد النساء والأطفال, وتسعى للتشبيك مع الجهات والأطراف المجتمعية ذات الصلة لنشر وترويج قيم الإنسانية والمساواة على أساس النوع الإجتماعي بهدف إيجاء حياة كريمة للأفراد ومجتمع أكثر أمناً"

class AboutDtos {
  int? id;
  String? content;
  String? contentEn;

  AboutDtos({this.id, this.content, this.contentEn});

  AboutDtos.fromJson(dynamic json) {
    id = json['id'];
    content = json['content'];
    contentEn = json['contentEn'];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['content'] = content;
    map['contentEn'] = contentEn;
    return map;
  }
}
