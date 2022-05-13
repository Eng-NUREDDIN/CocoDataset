part of 'dataset_cubit.dart';

@immutable
abstract class DatasetState {}

class DatasetInitial extends DatasetState {}
class DataLoaded extends DatasetState{
final List<ImagesModel> listOfdData;
DataLoaded(this.listOfdData);
}
class DataLoading extends DatasetState{}