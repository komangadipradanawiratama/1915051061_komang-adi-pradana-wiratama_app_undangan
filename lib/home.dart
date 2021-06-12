import 'package:flutter/material.dart';
import 'package:undangan/undanganList.dart';
import 'qr.dart';
import 'select_figure.dart';
import 'package:undangan/model/Undangan.dart';
import 'package:undangan/webservice/apiUndangan.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ApiUndangan? apiUndangan;
  @override
  void initState() {
    super.initState();
    apiUndangan = ApiUndangan();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PARTY-INVITATION'),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.black, size: 30),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectFigure()),
            );
          },
        ),
        backgroundColor: Colors.greenAccent,
      ),
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => UndanganList()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent
                ),
                child: Text(
                  "UNDANGAN",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              flex: 1,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => QRViewExample()));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.greenAccent
                ),
                child: Text(
                  "QR",
                  style: TextStyle(fontSize: 40, color: Colors.white),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Card(
                    child: FutureBuilder<List<Undangan>?>(
                        future: apiUndangan!.getUndanganAll(),
                        builder:
                            (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text("Error ${snapshot.error.toString()}"),
                            );
                          } else if (snapshot.hasData) {
                            List<Undangan>? _undangan = snapshot.data;
                            if (_undangan != null) {
                              return ListTile(
                                  leading: Icon(Icons.people, color: Colors.red,),
                              title: Text("Total Undangan : ${_undangan.length}"));
                            } else {
                              return Text("0");
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    ),
                  Card(
                    child:FutureBuilder<List<Undangan>?>(
                        future: apiUndangan!.getUndanganHadir(),
                        builder:
                            (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text("Error ${snapshot.error.toString()}"),
                            );
                          } else if (snapshot.hasData) {
                            List<Undangan>? _undangan = snapshot.data;
                            if (_undangan != null) {
                              return ListTile(
                                leading: Icon(Icons.star, color: Colors.yellow),
                                title: Text("Hadir : ${_undangan.length}"));
                            } else {
                              return Text("0");
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                  ),
                  Card(
                    child: FutureBuilder<List<Undangan>?>(
                        future: apiUndangan!.getUndanganTidakHadir(),
                        builder:
                            (BuildContext context, AsyncSnapshot<List<Undangan>?> snapshot) {
                          if (snapshot.hasError) {
                            print(snapshot.error.toString());
                            return Center(
                              child: Text("Error ${snapshot.error.toString()}"),
                            );
                          } else if (snapshot.hasData) {
                            List<Undangan>? _undangan = snapshot.data;
                            if (_undangan != null) {
                              return  ListTile(
                                  leading: Icon(Icons.person_outline, color: Colors.blue,),
                              title: Text("Belum Hadir : ${_undangan.length}"));
                            } else {
                              return Text("0");
                            }
                          } else {
                            return CircularProgressIndicator();
                          }
                        }),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
