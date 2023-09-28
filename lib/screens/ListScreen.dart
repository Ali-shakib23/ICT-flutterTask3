import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' ;
import 'package:http/http.dart' as http ;
import 'package:task3/screens/prodctScreen.dart';

import '../data/models/product.dart';
import 'loginScreen.dart';

class ListScreen extends StatefulWidget {
  ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen>{

  Future<List<ProductData>> getData() async{
    final res= await http.get(Uri.parse('https://dummyjson.com/products'));

    List <ProductData> products=[];

    if (res.statusCode==200){
      Map <String, dynamic> data=jsonDecode(res.body);
      for (var item in data['products']){
        products.add(ProductData.fromJson(item));

      }
    }
    return products;
  }
  List <ProductData> mylist=[];
    @override
    void initState() {
      super.initState();
      Future.delayed(
        Duration.zero,
          () async{
              var data = await getData();
              setState((){
                mylist = data;
                isloading= false;
              });

      },
      );
      isloading ? print('true') : print ('false');
    }
    bool isloading= true;
    @override
    Widget build(BuildContext context) {
      return Scaffold(
          appBar:AppBar(
            backgroundColor: const Color(0xFF252837),
            title: const Text('Croma'),
            leading: InkWell(
                onTap: ()async {
              await FirebaseAuth.instance.signOut().whenComplete(() {
              Navigator.pushReplacement(
              context,
              MaterialPageRoute(
              builder: (context) => const LoginScreen(),
              ),
              );

              });
      },
                child: const Icon(
                  color: Colors.white,
                  Icons.logout,
                )
              ),
          ),
          backgroundColor: const Color(0xFFF6F7F8),
          body: isloading?
              const Center(
                child: CircularProgressIndicator(),
              ):
          SafeArea(
            child: GridView.builder(
                itemCount:mylist.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                        builder: (context) => ProductScreen(
                        datak: mylist[index],
                      )
                        )
                      );
                    },
                    child: Container(
                          height: MediaQuery.of(context).size.height * 0.2,
                          width:MediaQuery.of(context).size.height * 0.4,
                          decoration: BoxDecoration(
                              color: Color(0xffFFFFF),
                          borderRadius:BorderRadius.circular(30),
                          image: DecorationImage(
                            fit:BoxFit.fill,
                            image:Image.network(
                              mylist[index].image,
                            ).image,

                          ),
                          ),
                          alignment: Alignment.bottomCenter,
                          margin: const EdgeInsets.all(10),
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration:BoxDecoration(
                              color:Colors.white,
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30),
                                bottomRight: Radius.circular(30),
                              )
                            ) ,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: Text(
                                  mylist[index].name,
                              ),
                                ),

                                  Text(
                                    mylist[index].price.toString(),
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color:Colors.black,
                                    ),

                                  )


                      ],
                        ),
                          )
                      ),
                  );

                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2 ),
                ),
          )

        );

    }
  }

