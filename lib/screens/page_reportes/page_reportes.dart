import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class PageReportes extends StatefulWidget {
  PageReportes({Key? key}) : super(key: key);

  @override
  _PageReportesState createState() => _PageReportesState();
}

class _PageReportesState extends State<PageReportes> {

  bool _isLoading = false;
  int _currentIndex=0;
  String _valorTotalOrden="0";
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds:1),(){
      setState(() {
        _isLoading= true;
        _valorTotalOrden="200";
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:const Color(0xff161621),
      appBar: AppBar(
        title:const Text('Reportes'),
        backgroundColor: Colors.black
      ),
      /*
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            onPressed:(){}, 
            icon: Icon(Icons.notifications,color:Colors.blueGrey)
          ),
          IconButton(
            onPressed:(){}, 
            icon: Icon(Icons.more_vert,color:Colors.blueGrey)
          )
        ],
        leading: IconButton(
            onPressed:(){}, 
            icon: Icon(Icons.search,color:Colors.blueGrey)
        )
      ),
      */
      /*
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor:Colors.white,
        margin: EdgeInsets.only(
          bottom: 30,
          top:10,
          right:20,
          left: 20
        ),
        onTap: (index){
          setState(() {
            _currentIndex=index;
            
          });
        },
        items: [
         SalomonBottomBarItem(
           icon: Icon(Icons.home),
           title: Text('HOME'),
           selectedColor: Colors.white
         ),
         SalomonBottomBarItem(
           icon: Icon(Icons.explore_outlined),
           title: Text('LIKES'),
           selectedColor: Colors.pink
         ),
         SalomonBottomBarItem(
           icon: Icon(Icons.data_usage),
           title: Text('SEARCH'),
           selectedColor: Colors.orange
         ),
         SalomonBottomBarItem(
           icon: Icon(Icons.settings),
           title: Text('PROFILE'),
           selectedColor: Colors.teal
         ), 
        ],
      ),
      */
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innetIsScrolled){
          return[
            SliverToBoxAdapter(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Text('ORDENES', style: TextStyle(
                            color: Colors.blueGrey.shade300,
                            fontSize: 20
                          )),
                          SizedBox(height: 20),
                          Text('\$ ${_valorTotalOrden}', style: TextStyle(
                            fontSize: 40,
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                          )),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 250,
                      child: LineChart(
                        mainData(),
                        swapAnimationDuration: Duration(milliseconds: 1000),
                        swapAnimationCurve: Curves.linear,
                      ),
                    )
                  ],
                ),
              ),
            )
          ];
        },
        body: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MaterialButton(
                    elevation: 0,
                    onPressed: (){
                      setState(() {
                        _isLoading = !_isLoading;
                        _valorTotalOrden="200";
                      });
                    },
                    //color: Color(0xff02d39a).withOpacity(0.7),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical:15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                      side: BorderSide(
                        color: Color(0xff02d39a).withOpacity(0.4), width: 1
                      )
                    ),
                    splashColor: Color(0xff02d39a).withOpacity(0.4),
                    highlightColor: Color(0xff02d39a).withOpacity(0.4),
                    child: Row(
                      children: [
                        Icon(Icons.wallet_giftcard, color: Colors.white),
                        SizedBox(width: 20),
                        Text("Revisar", style: TextStyle(
                          color: Colors.white
                        ))
                      ],
                    ),
                  ),
                  SizedBox(width: 20),
                  MaterialButton(
                    elevation: 0,
                    onPressed: (){},
                    color: Color(0xff02d39a).withOpacity(0.7),
                    padding: EdgeInsets.symmetric(horizontal: 30,vertical:15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.arrow_back,color: Colors.white),
                        SizedBox(width: 20),
                        Text("Regresar", style: TextStyle(
                          color: Colors.white
                        ))
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(height: 40),
              Text("ORDENES RECIENTES", style:TextStyle(
                color: Colors.blueGrey.shade300,
                fontSize: 16
              )),
              SizedBox(height: 20),
              Expanded(
                child: Container(
                  child: ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 5,
                    itemBuilder: (context,index){
                      return Container(
                        padding: EdgeInsets.symmetric(horizontal: 20,vertical: 20),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.blueGrey.withOpacity(0.3), width: 1),
                          borderRadius: BorderRadius.circular(10)
                        ),
                        margin: EdgeInsets.only(bottom: 15),
                        child: Row(
                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(Icons.arrow_back, color: Colors.blueGrey),
                            SizedBox(width: 10),
                            Text('ORDEN', style:TextStyle(color:Colors.blueGrey)),
                            SizedBox(width: 10),
                            Text('\$ 123.00', style:TextStyle(color:Colors.blueGrey,fontWeight: FontWeight.bold)),
                            SizedBox(width: 10),
                            Text('12:00 pm', style:TextStyle(color:Colors.blueGrey,fontSize: 12)),
                            
                          ],
                        ),
                      );
                    }
                  ),
                )
              )
            ],
          ),
        ),        
      ),
    );
  }
   LineChartData mainData() {
    return LineChartData(
      gridData: FlGridData(
        show: true,
        drawVerticalLine: false,
        horizontalInterval: 1.6,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            dashArray: [3,3],
            color: const Color(0xff37434d).withOpacity(0.2),
            strokeWidth: 1,
          );
        },

      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: SideTitles(showTitles: false),
        topTitles: SideTitles(showTitles: false),
        bottomTitles: SideTitles(
          showTitles: true,
          reservedSize: 22,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
              color: Color(0xff68737d),
              fontWeight: FontWeight.bold,
              fontSize: 11),
          getTitles: (value) {
            switch (value.toInt()) {
              case 2:
                return 'MAR';
              case 5:
                return 'JUN';
              case 8:
                return 'SEP';
              case 11:
                return 'OCT';
            }
            return '';
          },
          margin: 8,
        ),
        leftTitles: SideTitles(
          showTitles: true,
          interval: 1,
          getTextStyles: (context, value) => const TextStyle(
            color: Color(0xff67727d),
            fontWeight: FontWeight.bold,
            fontSize: 15,
          ),
          getTitles: (value) {
            switch (value.toInt()) {
              case 1:
                return '10k';
              case 3:
                return '30k';
              case 5:
                return '50k';
            }
            return '';
          },
          reservedSize: 25,
          margin: 12,
        ),
      ),
      borderData: FlBorderData(
          show: false,
          border: Border.all(color: const Color(0xff37434d), width: 1)),
      minX: 0,
      maxX: 11,
      minY: 0,
      maxY: 6,
      lineBarsData: [
        LineChartBarData(
          spots:_isLoading ? [
            FlSpot(0, 3),
            FlSpot(2.6, 2),
            FlSpot(4.9, 5),
            FlSpot(6.8, 3.1),
            FlSpot(8, 4),
            FlSpot(9.5, 3),
            FlSpot(11, 4),
          ]:[
            FlSpot(0, 0),
            FlSpot(2.6, 0),
            FlSpot(4.9, 0),
            FlSpot(6.8, 0),
            FlSpot(8, 0),
            FlSpot(9.5, 0),
            FlSpot(11, 0),
          ]
          ,
          isCurved: true,
          colors: gradientColors,
          barWidth: 2,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradientFrom: Offset(0,0),
            gradientTo: Offset(0,1), 
            colors: [
              Color(0xff02d39a).withOpacity(0.1),
              Color(0xff02d39a).withOpacity(0)
            ]
          ),
        ),
      ],
    );
  }
  List<Color> gradientColors = [
    const Color(0xff23b6e6),
    const Color(0xff02d39a),
  ];
}






  