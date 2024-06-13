import 'package:cached_network_image/cached_network_image.dart';
import 'package:currentwave/splash/viewmodel/newsview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../model/categoriesmodel.dart';
import 'detail_screen.dart';
import 'homescreen.dart';

class category extends StatefulWidget {
  const category({super.key});

  @override
  State<category> createState() => _categoryState();
}

class _categoryState extends State<category> {

  final spinkit2 = SpinKitDancingSquare(
    color: Colors.black, // Add color if needed
    size: 30,
  );
  newsview Newsview= newsview();

  String categoryname ='general';
  List<String> categorylist=[
    'General',
    'Entertainment',
    'Health',
    'Sports',
    'business',
    'Technology'
  ];
  final format = DateFormat('MMMM dd, yyyy');
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.sizeOf(context).height*1;
    final width =MediaQuery.sizeOf(context).width*1;
    return  Scaffold(
      appBar: AppBar(
        scrolledUnderElevation:0,
          title: Text('Category'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18,
        vertical: 10),
        child: Column(
          children: [
            SizedBox(height:50,
            child:ListView.builder(
              scrollDirection: Axis.horizontal,
                itemCount: categorylist.length,
                itemBuilder: (context,index){
                  return InkWell(
                    onTap: (){
                      categoryname = categorylist[index];
                      setState(() {

                      });
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 5),
                      child: Container(
                        width: 100,


                        decoration: BoxDecoration(
                          color: categoryname==categorylist[index]? Colors.grey.shade800:Colors.grey,
                          borderRadius: BorderRadius.circular(15),

                        ),
                        child: Center(child: Text(categorylist[index].toString(),style: GoogleFonts.poppins(fontSize:12.5,color:Colors.white),)),
                      ),
                    ),
                  );
                })
            ),
          Expanded(
            child: FutureBuilder<Categorymodel>(
                future: Newsview.fetchCategories(categoryname),
                builder:(BuildContext context,snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: SpinKitCubeGrid(
                        color: Colors.black,
                        size: 40,
                      ),
                    );
                  } else {
                    return ListView.builder(

                      itemCount:snapshot.data!.articles!.length ,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString(),);
                        return Padding(
                          padding: const EdgeInsets.only(top: 10),
                        child: InkWell(
                        onTap: () {
                        Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => Newsdetails(
                        newImage: snapshot.data!.articles![index].urlToImage ?? 'assets/images/splash.jpg',
                        newsTitle: snapshot.data!.articles![index].title ?? '',
                        newsDate: snapshot.data!.articles![index].publishedAt ?? '',
                        author: snapshot.data!.articles![index].author ?? '',
                        description: snapshot.data!.articles![index].description ?? '',
                        content: snapshot.data!.articles![index].content ?? '',
                        source: snapshot.data!.articles![index].source!.name ?? '',
                        ),
                        ),
                        );
                        },
                          child: Row(


                            children: [

                              ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: CachedNetworkImage(
                                  imageUrl:snapshot.data!.articles![index].urlToImage.toString(),
                                  fit: BoxFit.fill,
                                  height: height*.15,
                                  width: width*.5,
                                  placeholder: (context,url)=> Container(child: spinkit2,),
                                  errorWidget:(context,url,error)=> Icon(Icons.error_outline,color: Colors.red,),
                                ),
                              ),
                              Expanded(child:
                              Container(
                                height: height*.18,
                                padding:
                                EdgeInsets.symmetric(
                                  horizontal: 9.7,
                                  vertical: 15
                                ),
                                child: Column(
                                  children: [
                                  Text(snapshot.data!.articles![index].title.toString(),style: GoogleFonts.poppins(fontSize:15),overflow: TextOverflow.ellipsis,maxLines: 3,)
                                  ,Spacer(),
                                    Row(

                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(snapshot.data!.articles![index].source!.name.toString(),style: GoogleFonts.poppins(fontSize:height*0.009,fontWeight:FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                     Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize:height*0.01,fontWeight:FontWeight.bold),overflow: TextOverflow.ellipsis,),
                                     ],
                                    )

                                  ],
                                ),
                              ))
                            ],
                          ),
                        ));
                      },
                    );
                  }
                }),
          )]),

        ),
      );

  }
}
