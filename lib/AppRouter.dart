



import 'package:cocodatasetwebexp/Data/%20WebService/CocoApiCall.dart';
import 'package:cocodatasetwebexp/Data/Repository/DataRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'BusinessLogic/dataset_cubit.dart';
import 'View/Screens/HomePage.dart';

class AppRouter{
  Route? generateRout(RouteSettings settings){
    DataRepo imagesRepo=DataRepo(CocoApiCall());
    DatasetCubit datasetCubit=DatasetCubit(imagesRepo);

    switch (settings.name) {
      case "/":
        return MaterialPageRoute(builder: (_) =>
            BlocProvider(create: (BuildContext context) => datasetCubit,
                child: const HomePage()),);
    }}}
