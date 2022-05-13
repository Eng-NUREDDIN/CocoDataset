
import 'dart:convert';

import 'package:http/http.dart' as http;
class CocoApiCall{
  List imageData=[];
  List <dynamic> bigSegments=[];
  int index=0;
  List <dynamic> data=[];
  Future<List> imagesId(int id,bool moreData) async {
    List <dynamic> images=[];
    if(moreData){
      images=await imageReq(data);
    }else{
      var headers = {
        'authority': 'us-central1-open-images-dataset.cloudfunctions.net',
        'accept': '*/*',
        'accept-language': 'en-US,en;q=0.9,ar;q=0.8',
        'content-type': 'application/x-www-form-urlencoded; charset=UTF-8'
      };

      var request = http.Request('POST', Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'));
      request.body = '''category_ids%5B%5D=$id&querytype=getImagesByCats''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String stringData = (await response.stream.bytesToString()).toString();
        data = json.decode(stringData) ;
        images=await imageReq(data);
      }
      else {
        print(response.reasonPhrase);
      }
    }


    return images;
  }

  Future<List> imageReq(List <dynamic> data) async {
    List ofsetList=[];
    var headers = {
      'authority': 'us-central1-open-images-dataset.cloudfunctions.net',
      'accept': '*/*',
      'accept-language': 'en-US,en;q=0.9',
      'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
      'origin': 'https://cocodataset.org',
      'referer': 'https://cocodataset.org/',
      'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="101", "Google Chrome";v="101"',
      'sec-ch-ua-mobile': '?0',
      'sec-ch-ua-platform': '"Windows"',
      'sec-fetch-dest': 'empty',
      'sec-fetch-mode': 'cors',
      'sec-fetch-site': 'cross-site',
      'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36'
    };
    var request = http.Request('POST', Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'));

    request.body = '''image_ids%5B%5D=${data[index]}&image_ids%5B%5D=${data[index+1]}&image_ids%5B%5D=${data[index+2]}&image_ids%5B%5D=${data[index+3]}&image_ids%5B%5D=${data[index+4]}&querytype=getImages''';
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
       imageData = json.decode(await response.stream.bytesToString()) ;
       ofsetList= await segmentList(imageData);
       combineLists(ofsetList);
    }
    else {
      print(response.reasonPhrase);
    }

    return imageData;
  }

  Future<List> segmentList(List images) async {
    List <dynamic> segments=[];
      var headers = {
        'authority': 'us-central1-open-images-dataset.cloudfunctions.net',
        'accept': '*/*',
        'accept-language': 'en-US,en;q=0.9',
        'content-type': 'application/x-www-form-urlencoded; charset=UTF-8',
        'origin': 'https://cocodataset.org',
        'referer': 'https://cocodataset.org/',
        'sec-ch-ua': '" Not A;Brand";v="99", "Chromium";v="101", "Google Chrome";v="101"',
        'sec-ch-ua-mobile': '?0',
        'sec-ch-ua-platform': '"Windows"',
        'sec-fetch-dest': 'empty',
        'sec-fetch-mode': 'cors',
        'sec-fetch-site': 'cross-site',
        'user-agent': 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/101.0.4951.54 Safari/537.36'
      };
      var request = http.Request('POST', Uri.parse('https://us-central1-open-images-dataset.cloudfunctions.net/coco-dataset-bigquery'));
      request.body = '''image_ids%5B%5D=${images[0]["id"]}&image_ids%5B%5D=${images[1]["id"]}&image_ids%5B%5D=${images[2]["id"]}&image_ids%5B%5D=${images[3]["id"]}&image_ids%5B%5D=${images[4]["id"]}&querytype=getInstances''';
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        segments = json.decode(await response.stream.bytesToString()) ;
    }
    else {
    print(response.reasonPhrase);
    }
      bigSegments.addAll(segments);
    index+=5;
    return bigSegments;
  }

  void combineLists(List ofSets){
    List temp=[];
    for(var element in imageData){
      List tempList=ofSets.where((elementSet) => element["id"]==elementSet["image_id"]).toList();
      for(var item in tempList){
        var dataType=json.decode(item["segmentation"]);
        if(dataType is List){
          temp.add(item["segmentation"]);
        }
      }
      element["segments"]=temp.toList();
      temp.clear();
    }
  }

}