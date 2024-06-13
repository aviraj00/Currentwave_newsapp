import 'package:currentwave/model/headline_model.dart';
import 'package:currentwave/splash/Category.dart';
import 'package:currentwave/splash/viewmodel/newsview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';

import '../model/categoriesmodel.dart';
import 'detail_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _homeState();
}
enum FilterList {bbcNews , thetimesofindia,crypto,espn,CNN,Hindustan_Times,India_Today}
class _homeState extends State<Home> {
  newsview Newsview= newsview();
  FilterList? selectedmenu;
  String name ='bbc-news';
  @override
  Widget build(BuildContext context) {
    final height =MediaQuery.sizeOf(context).height*1;
    final width =MediaQuery.sizeOf(context).width*1;
    const spinkit2 = SpinKitDancingSquare(
      color: Colors.black, // Add color if needed
      size: 30,
    );
    final format = DateFormat('MMMM dd, yyyy');
    return  Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        leading: IconButton(
          icon: Image.asset('assets/images/menu.png',height: 35,
          width: 30,)
        ,onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) =>const category()));
        },),
        title: Text('News',style: GoogleFonts.poppins(fontSize:24,fontWeight:FontWeight.bold),),
       actions: [
         PopupMenuButton<FilterList>(
           initialValue: selectedmenu,
             onSelected: (FilterList item){
             if(FilterList.bbcNews.name==item.name){
               name = 'bbc-news';
             }
             if(FilterList.thetimesofindia.name==item.name){
               name = 'the-times-of-india';
             }
             if(FilterList.espn.name==item.name){
               name = 'espn';
             }
             if(FilterList.CNN.name==item.name){
               name = 'cnn';
             }
             if(FilterList.crypto.name==item.name){
               name = 'crypto-coins-news';
             }
             setState(() {
                selectedmenu =item;
             });
             },
             itemBuilder: (context)=> <PopupMenuEntry<FilterList>>[
               const PopupMenuItem<FilterList>(

                 value: FilterList.bbcNews,
                 child: Text('BBC News'),
               ),
               const PopupMenuItem<FilterList>(

                 value: FilterList.thetimesofindia,
                 child: Text('The Times Of India'),
               ),
               const PopupMenuItem<FilterList>(

                 value: FilterList.CNN,
                 child: Text('CNN'),
               ),

               const PopupMenuItem<FilterList>(

                 value: FilterList.espn,
                 child: Text('ESPN'),
               ),
               const PopupMenuItem<FilterList>(

                 value: FilterList.crypto,
                 child: Text('Crypto Coins news'),
               ),
             ]
         )
       ],

      ),
      body:  SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: height * 0.55,
              width: width * 1,
              child: FutureBuilder<HeadlineModel>(
                future: Newsview.fetchHeadlines(name),
                builder: (BuildContext context, AsyncSnapshot<HeadlineModel> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: SpinKitCubeGrid(
                        color: Colors.black,
                        size: 40,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text('Error: ${snapshot.error}'),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.articles == null) {
                    return const Center(
                      child: Text('No data available'),
                    );
                  } else {
                    return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: snapshot.data!.articles!.length,
                      itemBuilder: (context, index) {
                        DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                        return InkWell(
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
                          child: SizedBox(
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  height: height * 0.6,
                                  width: width * 0.9,
                                  padding: EdgeInsets.symmetric(horizontal: height * 0.02),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(16),
                                    child: snapshot.data!.articles![index].urlToImage != null && snapshot.data!.articles![index].urlToImage!.isNotEmpty
                                        ? CachedNetworkImage(
                                      imageUrl: snapshot.data!.articles![index].urlToImage!,
                                      fit: BoxFit.fill,
                                      placeholder: (context, url) => Container(child: spinkit2),
                                      errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                                    )
                                        : Image.asset('assets/images/splash.jpg', fit: BoxFit.fill),
                                  ),
                                ),
                                Positioned(
                                  bottom: 22,
                                  child: Card(
                                    elevation: 5,
                                    color: Colors.white,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(7),
                                      alignment: Alignment.bottomCenter,
                                      height: height * 0.22,
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Text(
                                              snapshot.data!.articles![index].title ?? '',
                                              maxLines: 3,
                                              overflow: TextOverflow.ellipsis,
                                              style: GoogleFonts.poppins(fontSize: 17, fontWeight: FontWeight.w700),
                                            ),
                                          ),
                                          const Spacer(),
                                          SizedBox(
                                            width: width * 0.7,
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  snapshot.data!.articles![index].source!.name ?? '',
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),
                                                ),
                                                Text(
                                                  format.format(dateTime),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w700),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
            FutureBuilder<Categorymodel>(
              future: Newsview.fetchCategories('general'),
              builder: (BuildContext context, AsyncSnapshot<Categorymodel> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return  Center(
                    
                    child: Container(
                      margin: const EdgeInsets.all(15),
                      child: const SpinKitCubeGrid(
                        color: Colors.black,
                        size: 40,
                      ),
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.articles == null) {
                  return const Center(
                    child: Text('No data available'),
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: snapshot.data!.articles!.length,
                    itemBuilder: (context, index) {
                      DateTime dateTime = DateTime.parse(snapshot.data!.articles![index].publishedAt.toString());
                      return Padding(
                        padding: const EdgeInsets.only(top: 10, left: 10),
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
                                  imageUrl: snapshot.data!.articles![index].urlToImage ?? 'assets/images/splash.jpg',
                                  fit: BoxFit.fill,
                                  height: height * 0.15,
                                  width: width * 0.5,
                                  placeholder: (context, url) => Container(child: spinkit2),
                                  errorWidget: (context, url, error) => const Icon(Icons.error_outline, color: Colors.red),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  height: height * 0.18,
                                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                                  child: Column(
                                    children: [
                                      Text(
                                        snapshot.data!.articles![index].title ?? '',
                                        style: GoogleFonts.poppins(fontSize: 15),
                                        overflow: TextOverflow.ellipsis,
                                        maxLines: 3,
                                      ),
                                      const Spacer(),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            snapshot.data!.articles![index].source!.name ?? '',
                                            style: GoogleFonts.poppins(fontSize: height * 0.01, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          Text(
                                            format.format(dateTime),
                                            style: GoogleFonts.poppins(fontSize: height * 0.01, fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}