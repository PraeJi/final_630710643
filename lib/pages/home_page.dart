import 'package:final_630710643/models/fifa_item.dart';
import 'package:final_630710643/pages/vote_page.dart';
import 'package:flutter/material.dart';

import '../services/api.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FifaItem>? _fifaList;
  var _isLoading = false;
  String? _errMessage;

  @override
  void initState() {
    super.initState();
    _fetchFifaData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
              image: AssetImage('assets/images/bg.png'),
              fit: BoxFit.cover,
            )),
          ),
          Column(
            children: [
              Positioned(
                bottom: 600.0,
                left: 0.0,
                right: 0.0,
                child: Container(
                  height: 200.0,
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12.0),
                      image: DecorationImage(
                        image: AssetImage('assets/images/logo.jpg'),
                        //fit: BoxFit.cover
                      )),
                ),
              ),
              Expanded(
                  child: Stack(
                children: [
                  if (_fifaList != null)
                    ListView.builder(
                      itemBuilder: _buildListItem,
                      itemCount: _fifaList!.length,
                    ),
                  if (_isLoading)
                    const Center(child: CircularProgressIndicator()),
                  if (_errMessage != null && !_isLoading)
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Text(_errMessage!),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _fetchFifaData();
                            },
                            child: const Text('RETRY'),
                          ),
                        ],
                      ),
                    )
                ],
              )),
              Positioned(
                  child: Container(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => VotePage()),
                          );
                        },
                        child: const Text(
                          'VIEW RESULT',
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  void _fetchFifaData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      var data = await Api().fetch('fifas');
      setState(() {
        _fifaList =
            data.map<FifaItem>((item) => FifaItem.fromJson(item)).toList();
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errMessage = e.toString();
        _isLoading = false;
      });
    }
  }

  Widget _buildListItem(BuildContext context, int index) {
    var fifaItem = _fifaList![index];

    return Card(
      child: InkWell(
        onTap: () {},
        child: Row(
          children: [
            Image.network(
              fifaItem.flagImage,
              width: 80.0,
              height: 80.0,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 8.0),
            Column(
              children: [
                Text(fifaItem.team),
                Text('GROUP' + fifaItem.group),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
