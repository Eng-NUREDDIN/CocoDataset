import 'package:cocodatasetwebexp/Data/%20WebService/CocoApiCall.dart';
import 'package:cocodatasetwebexp/Data/Model/ImagesModel.dart';

class DataRepo{
  final  CocoApiCall apiCall;
 DataRepo(this.apiCall);
  Future <List<ImagesModel>> storeImages(int id,bool moreData)async{
    final imagesData=await apiCall.imagesId(id,moreData);
    return imagesData.map((images) => ImagesModel.fromJson(images)).toList();
  }
}