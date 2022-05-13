import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cocodatasetwebexp/GlobalUtilities/AppColors.dart';
import 'package:flutter/material.dart';


import '../../BusinessLogic/dataset_cubit.dart';
import '../../Data/Model/ImagesModel.dart';
import '../Widgets/ImageButton.dart';
import '../Widgets/ImageWidget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  //*****variables
  TextEditingController searchController=TextEditingController();
   List<ImagesModel> listOfData=[];
  final ValueNotifier<int> dataLoaded = ValueNotifier<int>(0);
   bool show=false;
   int imageId=-1;
  var providerContext;
  //*****variables

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body:mainWidget(),
      ),
    );
  }

//*********Widgets

  Widget searchBar(){
    double height=MediaQuery.of(context).size.height;
    double width=MediaQuery.of(context).size.width;
    return Container(
      width: width*0.6,
      height: height*0.07,
      decoration: BoxDecoration(
        //color: Colors.white,
        borderRadius: BorderRadius.circular( 7 ),

      ),
      child: TextFormField(
        textAlignVertical:TextAlignVertical.center ,
        textAlign: TextAlign.start,
        controller:searchController ,
        //onChanged: (value){if(value.isEmpty){data=dbData;update.value+=1;}},
        decoration: InputDecoration(enabled: true,
          hintText: "Search" ,
          suffixIcon: Padding(
            padding: const EdgeInsets.only(top: 10.0, left:5),
            child: Container(
              child:InkWell(child: const Icon(Icons.search,color: Colors.black,),onTap:() {
                BlocProvider.of<DatasetCubit>(context).getDataFromRepo(-1,false);

              },) ,
              height: 0.035,
              width: 0.075,
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 10.0, right:10),
        ),
      ),
    );
  }
  Widget mainWidget(){
    return dataWidget();
  }
  Widget headerWidget(){
    return Container(
      padding:EdgeInsets.all(8),
      height: 100,
      width: double.infinity,
      color:AppColors.header,
      child: Row (
        mainAxisAlignment: MainAxisAlignment.spaceAround,
          children:[
            Image.asset("Images/LOGO.png"),
            searchBar(),
            IconButton(icon: Icon(Icons.grid_on_sharp),onPressed: (){objectsItem();},)
            //objectMenu()
          ]
      ),
    );
  }
  Widget dataWidget(){
    double ?h=MediaQuery.of(context).size.height;
    return Container(
      color: AppColors.brownBar.withOpacity(0.3),
      child: Column(
        mainAxisAlignment:MainAxisAlignment.start,
        children: [
          headerWidget(),
          Padding(
            padding: const EdgeInsets.only(top:8.0),
            child: BlocBuilder<DatasetCubit, DatasetState>(
              builder: (context, state) {
                providerContext=context;
                if(state is DataLoaded){
                  listOfData=state.listOfdData;
                  show=true;
                  return Column(
                    children: [
                      Container(
                        color: AppColors.background,
                        height:h*0.81 ,
                        child: ListView.builder(
                            itemCount: listOfData.length,
                            itemBuilder: (context,index) {
                              return ImageWidget(image: listOfData[index],);

                            }),
                      ),
                      Visibility(visible:show,
                          child: TextButton(onPressed: (){BlocProvider.of<DatasetCubit>(context).getDataFromRepo(imageId,true);}, child: Text("More data")))
                    ],
                  );
                }else if(state is DataLoading){
                  return const Center(child: CircularProgressIndicator(color: AppColors.brownBar,));
                }else{
                  return const Center(child: Text("press search icon to get data"));
                }

              },
            ),
          ),
        ],
      ),
    );
  }
  Widget iconsBuilder (){
    return GridView.builder( gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3,childAspectRatio: 0.85),
        itemCount: 80,
        itemBuilder: (context, index) {
          int id=index+1;
          switch(id){
            case 12:
              id=82;
              break;
            case 26:
              id=82;
              break;
            case 29:
              id=84;
              break;
            case 30:
              id=85;
              break;
            case 45:
              id=86;
              break;
            case 66:
              id=87;
              break;
            case 68:
              id=88;
              break;
            case 69:
              id=89;
              break;
            case 71:
              id=90;
              break;
          }
          return ImageButton(onTap:(){BlocProvider.of<DatasetCubit>(providerContext).getDataFromRepo(id,false);imageId=id;Navigator.pop(context);}, imagePath: "Images/$id.jpg");
        });
  }
  objectsItem(){
    showGeneralDialog(
        transitionBuilder: (context, a1, a2, widget) {
          return Transform.scale(
            alignment: Alignment.center,
            scale: a1.value,
            child: Opacity(
              opacity: a1.value,
              child: Dialog(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                elevation: 0.0,
                insetPadding: EdgeInsets.all(10),
                backgroundColor: Colors.white,
                child: Container(
                  height: 500,
                  //width:400,
                  color:AppColors.brownBar.withOpacity(0.4),
                  child: iconsBuilder (),
                ),
              ),
            ),
          );
        },
        transitionDuration: Duration(milliseconds: 200),
        barrierDismissible: true,
        barrierLabel: '',
        context: context,
        pageBuilder: (context, animation1, animation2) {return Container();});
  }

//*********Widgets

}

