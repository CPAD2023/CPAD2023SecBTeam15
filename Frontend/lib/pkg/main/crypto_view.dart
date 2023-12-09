import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cryptoview/pkg/models/model.dart';

class CryptoView extends StatefulWidget {
  const CryptoView({super.key});

  @override
  State<CryptoView> createState() => _CryptoViewState();
}

class _CryptoViewState extends State<CryptoView> {

  List<ApiData> apiDataList = [];
  Color listColor = Colors.deepPurple;

  @override
  void initState(){
    super.initState();
    onInit();
  }

  void onInit() async{
    await callApi();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.deepPurple.shade300,
        onPressed: ()async{
          await callApi();
        },
        child: Icon(
          Icons.refresh,
          color: Colors.white,
        ),
      ),
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple.shade300,
        title: const Text(
            'Cryptos',
            style: TextStyle(
              color: Colors.white
            ),
        ),

      ),
      body: ListView.builder(
          scrollDirection: Axis.vertical,
          itemCount:apiDataList.length,
          itemBuilder: (context, index) {
            ApiData apiData = apiDataList[index];
            return InkWell(
              onTap: (){
                  print("pressed");
              },
              onHover: (isHovered){
                if(isHovered){
                  setState(() {
                    listColor = Colors.deepPurple.shade900;
                  });
                }

              },
              child: ListTile(
                title: Container(
                  width: MediaQuery.of(context).size.width/1.12,
                  height:65,
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: listColor, // Set the border color
                        width: 0.5,          // Set the border width
                      ),
                    ),
                    // borderRadius: BorderRadius.circular(10)
                  ),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                              apiData.name
                          ),
                          Text('Price: \$${apiData.current_price}')
                        ],
                      ),
                      Container(
                        child: IconButton(
                          onPressed: (){
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Column(
                                  children: [
                                    Transform.translate(
                                      offset: const Offset(0,-110),
                                      child: Container(
                                        height: 200,
                                        width: 200,
                                        decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                        ),
                                        child: Image.network(
                                          apiData.image,
                                        ),
                                      ),
                                    ),
                                SingleChildScrollView(
                                  child: Container(
                                    width: MediaQuery.of(context).size.width/1.3,
                                    padding: EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [

                                      SizedBox(height: 20,),
                                      Transform.translate(
                                        offset: const Offset(0, -120),
                                        child: Table(
                                          children: [
                                          TableRow(
                                            children: [
                                            TableCell(
                                              child: Text(
                                                'Name',
                                                style: TextStyle(
                                                fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ),
                                            TableCell(
                                            child: Text(apiData.name),
                                            ),
                                            ],
                                          ),
                                          TableRow(
                                          children: [
                                          TableCell(
                                          child: Text('Price',
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          ),
                                          TableCell(
                                          child: Text(apiData.current_price.toString()),
                                          ),
                                          ],
                                          ),
                                          TableRow(
                                          children: [
                                          TableCell(
                                          child: Text('Market cap',
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          ),
                                          TableCell(
                                          child: Text(apiData.market_cap.toString()),
                                          ),
                                          ],
                                          ),
                                          TableRow(
                                          children: [
                                          TableCell(
                                          child: Text('Market Cap Rank',
                                          style: TextStyle(
                                          fontWeight: FontWeight.bold
                                          ),
                                          ),
                                          ),
                                          TableCell(
                                          child:Text(apiData.market_cap_rank.toString()),
                                          ),
                                          ],
                                          ),
                                          TableRow(
                                            children: [
                                            TableCell(
                                              child: Text('Total Volume',
                                              style: TextStyle(
                                              fontWeight: FontWeight.bold
                                              ),
                                              ),
                                              ),
                                            TableCell(
                                            child: Text(apiData.total_volume.toString()),
                                            ),
                                            ],
                                          ),
                                            TableRow(
                                              children: [
                                                TableCell(
                                                  child: Text('Change',
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                TableCell(
                                                  child: Text(
                                                      apiData.price_change_percentage_24h_in_currency.toString(),
                                                      style: TextStyle(
                                                        color: apiData.price_change_percentage_24h_in_currency >= 0? Colors.green: Colors.red
                                                      ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                      ],
                                      ),
                                    ),
                                  )
                                    ]
                                );
                              },
                            );
                          },
                          icon: Icon(
                              Icons.arrow_right,

                          ),
                        ),
                      )
                    ],
                  )
                ), // Assuming current_price is a numeric field
                // Add more fields as needed
              ),
            );
          },
        ),
    );
  }

  Future<void> callApi()async{
    final uri = Uri(
        scheme: 'https',
        host: 'api.coingecko.com',
        path: '/api/v3/coins/markets',
        queryParameters: {
          'vs_currency': 'usd',
          'order': 'market_cap_desc',
          'per_page':'250',
          'page':'1',
          'sparkline':'true',
          'price_change_percentage':'24h'
        }
    );
    final response = await http.get(uri);

    if(response.statusCode == 200){
      List<dynamic> decodedJsonList = jsonDecode(response.body);
      setState(() {
        apiDataList = decodedJsonList.map((decodedJsonList) {
          return ApiData.fromJson(decodedJsonList);
        }).toList();
      });
    }
    else{
      print("Issue while calling API");
    }
  }
}