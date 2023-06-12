import 'dart:convert';
import 'dart:developer';
import 'package:barterit_app/homescreen.dart';
import 'package:barterit_app/model/item.dart';
import 'package:barterit_app/model/myconfig.dart';
import 'package:barterit_app/model/user.dart';
import 'package:barterit_app/ownerdetailsscreen.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

class ExploreScreen extends StatefulWidget {
  final User user;
  const ExploreScreen({super.key, required this.user});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late List<Widget> tabchildren;
  String maintitle = "Browse Trades";
  late double screenHeight, screenWidth;
  late int axiscount = 2;
  List<Item> itemList = <Item>[];
  final TextEditingController searchController = TextEditingController();
  List<String> itemlist = [
    "Electronics",
    "Home & Furniture",
    "Fashion & Accessories",
    "Books & Media",
    "Sports & Fitness",
    "Toys & Games",
    "Automotive",
    "Beauty & Personal Care",
    "Other",
  ];

  
  List<String> imageList = [
    "assets/electronic.png",
    "assets/furniture.png",
    "assets/fashion.png",
    "assets/book.png",
    "assets/sports.png",
    "assets/games.png",
    "assets/automotive.png",
    "assets/beauty.png",
    "assets/other.png"
  ];

  @override
    void initState() {
      super.initState();
      _loadExploreItems();
      print("Explore");
    }

  @override
  void dispose() {
    super.dispose();
    print("dispose");
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth > 600) {
      axiscount = 3;
    } else {
      axiscount = 2;
    }
    return Scaffold(
      appBar: AppBar(
  title: Text(maintitle),
  backgroundColor: Colors.amber,
  actions: [
    IconButton(
      onPressed: showCategory,
      icon: const Icon(Icons.filter_list),
    ),
  ],
  bottom: PreferredSize(
    preferredSize: Size.fromHeight(50.0),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0.8),
          ),
          hintText: "Search...",
          prefixIcon: IconButton(
            onPressed: () {
              String search = searchController.text;
              searchItem(search);
            },
            icon: const Icon(Icons.search),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.clear),
            onPressed: () {
              searchController.text = "";
            },
          ),
          filled: true,
          fillColor: Colors.white,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0.8, color: Colors.black),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30.0),
            borderSide: const BorderSide(width: 0.8, color: Colors.black),
          ),
        ),
      ),
    ),
  ),
),

      body: itemList.isEmpty
          ? const Center(
              child: Text("No Data", style:TextStyle(fontSize: 15)),
            )
          : Column(children: [
              const SizedBox(height: 12,),
              const Padding(
                padding: EdgeInsets.only(left: 18.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Results",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10,),              
              Expanded(
                  child: GridView.count(
                      crossAxisCount: axiscount,
                      children: List.generate(
                        itemList.length,
                        (index) {
                          return Card(
                            child: InkWell(
                              onTap: () {
                                Item useritem =
                                    Item.fromJson(itemList[index].toJson());
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (content) =>
                                            OwnerDetailsScreen(
                                              user: widget.user,
                                              useritem: useritem,
                                            )));
                              },                             
                              child: Column(children: [
                                CachedNetworkImage(
                                  width: screenWidth,
                                  fit: BoxFit.cover,
                                  imageUrl:
                                      "${MyConfig().SERVER}/barterlt_app/assets/items/${itemList[index].itemId}_1.png",
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                Text(
                                  itemList[index].itemName.toString(),
                                  style: const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "${itemList[index].itemQty} available",
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ]),
                            ),
                          );
                        },
                      )))
            ]),);
  }
  
  void _loadExploreItems() {
    if (widget.user.id == "na") {
      setState(() {

      });
      return;
    }

    http.post(Uri.parse("${MyConfig().SERVER}/barterlt_app/php/load_items.php"),
        body: {"userid": widget.user.id}).then((response) {
      //print(response.body);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
  
  void showCategory() {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    builder: (BuildContext context) {
      return Material(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              GridView.count(
                crossAxisCount: axiscount,
                children: List.generate(
                  imageList.length,
                  (index) {
                    //print(index);
                    return Card(
                      child: InkWell(
                        onTap: () {
                          String selectedCategory = itemlist[index];
                          searchCategory(selectedCategory);
                          Navigator.pop(context); 
                        },
                        child: Column(
                          children: [
                            Image.asset(imageList[index]),
                            Text(
                              itemlist[index].toString(),
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),

              Positioned(
                bottom: 16,
                right: 16,
                child: FloatingActionButton(
                backgroundColor: Colors.amber,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 32,
                  color: Colors.white,
                ),),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  void searchItem(search) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt_app/php/load_items.php"),
        body: {"search": search}).then((response) {
      //print(response.body);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }

  void searchCategory(type) {
    http.post(Uri.parse("${MyConfig().SERVER}/barterlt_app/php/load_items.php"),
        body: {"type": type}).then((response) {
      //print(response.body);
      //log(response.body);
      itemList.clear();
      if (response.statusCode == 200) {
        var jsondata = jsonDecode(response.body);
        if (jsondata['status'] == "success") {
          var extractdata = jsondata['data'];
          extractdata['items'].forEach((v) {
            itemList.add(Item.fromJson(v));
          });
          print(itemList[0].itemName);
        }
        setState(() {});
      }
    });
  }
}
