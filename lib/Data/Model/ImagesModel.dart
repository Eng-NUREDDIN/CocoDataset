
class ImagesModel {
  int ?id;
  String? cocoUrl;
  String ?flickrUrl;
  List ?segment;
  ImagesModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    cocoUrl = json['coco_url'];
    flickrUrl = json['flickr_url'];
    segment = json['segments']  ;
  }


}