import 'package:barterit_app/model/item.dart';
import 'package:barterit_app/model/myconfig.dart';
import 'package:barterit_app/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OwnerDetailsScreen extends StatefulWidget {
  final Item useritem;
  final User user;
  const OwnerDetailsScreen(
      {super.key, required this.useritem, required this.user});

  @override
  State<OwnerDetailsScreen> createState() => _OwnerDetailsScreenState();
}

class _OwnerDetailsScreenState extends State<OwnerDetailsScreen> {
  final df = DateFormat('dd-MM-yyyy hh:mm a');

  late double screenHeight, screenWidth, cardwitdh;
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text("Item Details"),
      backgroundColor: Colors.amber,
      actions: [
        IconButton(
          onPressed: () {
            // wishlist function
          },
          icon: const Icon(
            Icons.favorite,
            color: Colors.red,
          ),
        ),
        IconButton(
          onPressed: () {
            // Handle messenger action
          },
          icon: const Icon(Icons.chat, color: Colors.black,),
        ),  
      ],),
      body: Column(children: [
        Flexible(
            flex: 4,
            child: SizedBox(
              width: screenWidth,              
                  child: CachedNetworkImage(
                    width: screenWidth,
                    fit: BoxFit.fill,
                    imageUrl:
                        "${MyConfig().SERVER}/barterlt_app/assets/items/${widget.useritem.itemId}_1.png",
                    placeholder: (context, url) =>
                        const LinearProgressIndicator(),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),                  
                ),              
            )),
        Container(
            padding: const EdgeInsets.all(8),
            child: Text(
              widget.useritem.itemName.toString(),
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            )),
        Expanded(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 5, 16, 5),
            child: Table(
              columnWidths: const {
                0: FlexColumnWidth(5),
                1: FlexColumnWidth(5),
              },
              children: [
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Description",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemDesc.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Item Category",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemType.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Quantity",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemQty.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Original Price",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "RM ${double.parse(widget.useritem.itemPrice.toString()).toStringAsFixed(2)}",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Item Condition",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemCondition.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Preferred Item",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      widget.useritem.itemPrefer.toString(),
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Location",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      "${widget.useritem.itemLocality}/${widget.useritem.itemState}",
                    ),
                  )
                ]),
                TableRow(children: [
                  const TableCell(
                    child: Text(
                      "Date",
                      style: TextStyle(fontWeight: FontWeight.w900),
                    ),
                  ),
                  TableCell(
                    child: Text(
                      df.format(DateTime.parse(
                          widget.useritem.itemDate.toString())),
                    ),
                  )
                ]),
              ],
            ),
          ),
        )
      ]),
    );
  }
}