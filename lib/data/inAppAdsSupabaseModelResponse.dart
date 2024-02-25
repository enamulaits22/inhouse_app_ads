class InAppAdsSupabaseModelResponse {
  InAppAdsSupabaseModelResponse({
    this.id,
    this.appName,
    this.iosLink,
    this.androidLink,
    this.appImage,
    this.appFeatures,
  });

  InAppAdsSupabaseModelResponse.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    appName = json['app_name'];
    iosLink = json['ios_link'];
    androidLink = json['android_link'];
    appImage =
        json['app_image'] != null ? json['app_image'].cast<String>() : [];
    appFeatures =
        json['app_features'] != null ? json['app_features'].cast<String>() : [];
  }
  num? id;
  String? appName;
  String? iosLink;
  String? androidLink;
  List<String>? appImage;
  List<String>? appFeatures;
  InAppAdsSupabaseModelResponse copyWith({
    num? id,
    String? appName,
    String? iosLink,
    String? androidLink,
    List<String>? appImage,
    List<String>? appFeatures,
  }) =>
      InAppAdsSupabaseModelResponse(
        id: id ?? this.id,
        appName: appName ?? this.appName,
        iosLink: iosLink ?? this.iosLink,
        androidLink: androidLink ?? this.androidLink,
        appImage: appImage ?? this.appImage,
        appFeatures: appFeatures ?? this.appFeatures,
      );
  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['app_name'] = appName;
    map['ios_link'] = iosLink;
    map['android_link'] = androidLink;
    map['app_image'] = appImage;
    map['app_features'] = appFeatures;
    return map;
  }
}
