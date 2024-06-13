import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Newsdetails extends StatefulWidget {
  String newImage ,newsTitle, newsDate, author, description, content, source;
   Newsdetails({Key?key,
  required this.newImage,required this.newsTitle,required this.newsDate,required this.author,required this.description,required this.content,required this.source
  }): super(key:key);

  @override
  State<Newsdetails> createState() => _NewsdetailsState();
}

class _NewsdetailsState extends State<Newsdetails> {
  @override

  Widget build(BuildContext context) {
    final format = DateFormat('MMMM dd, yyyy');
     DateTime dateTime=DateTime.parse(widget.newsDate);
    final height =MediaQuery.sizeOf(context).height*1;
    final width =MediaQuery.sizeOf(context).width*1;
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        title: Text('h'),
        elevation: 5,

      ),
      body: Stack(
        children: [
          Container(
            height: height*0.45,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(
                20
              ),
              child: CachedNetworkImage(
                imageUrl: widget.newImage,
                fit: BoxFit.fill,
                placeholder: (context,url)=> Center(child: CircularProgressIndicator(),),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: height *.4),
            padding: EdgeInsets.all(15),
            height: height*.6,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
              color: Colors.white
            ),
            child: ListView(
              children: [
                   Text(widget.newsTitle,style: GoogleFonts.poppins(fontSize:20),)
              ,     Container(
                  margin: EdgeInsets.only(top:height*0.05),
                child: Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(widget.source,style: GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.bold),),
                     Text(format.format(dateTime),style: GoogleFonts.poppins(fontSize:13,fontWeight:FontWeight.bold),)
                    ],

                ),

              ),
                Container(
                  margin: EdgeInsets.only(top: height*0.05),
                    child: Text(widget.description,style: GoogleFonts.poppins(fontSize:20),))

              ],
            ),
          )
        ],
      ),
    );
  }
}
