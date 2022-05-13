import 'package:bloc/bloc.dart';
import 'package:cocodatasetwebexp/Data/Model/ImagesModel.dart';
import 'package:cocodatasetwebexp/Data/Repository/DataRepo.dart';
import 'package:meta/meta.dart';

part 'dataset_state.dart';

class DatasetCubit extends Cubit<DatasetState> {
  final  DataRepo repoData;
  List<ImagesModel> apiData=[];
  DatasetCubit(this.repoData) : super(DatasetInitial());

  Future<List<ImagesModel>> getDataFromRepo(int id,bool moreData) async {
    emit(DataLoading());
    await repoData.storeImages(id,moreData).then((data) {
      emit(DataLoaded(data));
      apiData=data;
    });
    return apiData;
  }
}
