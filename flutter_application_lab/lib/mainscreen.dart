import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_application_lab/splashscreen.dart';
import 'profilescreen.dart';
import 'package:http/http.dart' as http;
import 'package:country_picker/country_picker.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    super.initState();
    tabchildren = const [
      MainScreen(),
    ];
  }

  final _locationNameController = TextEditingController();

  late List<Widget> tabchildren;
  int _currentIndex = 0;
  var countryName = "Contry Name";
  var countryCode = "";
  var capital = "Capital";
  var currency = "Currency";
  var currencyCode = "Code";
  var gdp = 0.0;
  var region = "Region";
  var surface_area = 0.0;
  var population = 0.0;
  var maintitle = 'home';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(maintitle),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () {
                showCountryPicker(
                  context: context,
                  favorite: <String>['ID'],
                  showPhoneCode: false,
                  onSelect: (Country country) {
                    countryName = country.name;
                    countryCode = country.countryCode;
                    _loadCountry();
                  },
                  countryListTheme: CountryListThemeData(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0),
                    ),
                    inputDecoration: InputDecoration(
                      labelText: 'Search',
                      hintText: 'Start typing to search',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: const Color(0xFF8C98A8).withOpacity(0.2),
                        ),
                      ),
                    ),
                    searchTextStyle: const TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                    ),
                  ),
                );
              },
              child: const Text('Show country picker'),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              height: 125,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: Colors.blue, // set the desired color
                  width: 1, // set the desired border width
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ClipOval(
                    child: countryCode != ""
                        ? Image.network(
                            'https://flagsapi.com/${countryCode}/flat/64.png',
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          )
                        : Image.asset(
                            'assets/images/logo.png',
                            fit: BoxFit.contain,
                            width: 100,
                            height: 100,
                          ),
                  ),
                  Container(
                    width: 250,
                    color: Colors.white,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              countryName,
                              style: const TextStyle(
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Text(
                                  'Region',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(region),
                              ],
                            ),
                            Column(
                              children: [
                                const Text(
                                  'Capital',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(capital),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Container(
              width: double.infinity,
              height: 200,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        'Details',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Currency',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text('${currencyCode} (${currency})'),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'GDP',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(gdp.toString()),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          const Text(
                            'Surface Area',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(surface_area.toString()),
                        ],
                      ),
                      Column(
                        children: [
                          const Text(
                            'Population',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(population.toString()),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Profile",
            icon: Icon(Icons.person),
          )
        ],
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        maintitle = "Home";
        //  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>ProfileScreen()));
      }
      if (_currentIndex == 1) {
        maintitle = "Profile";
      }
    });
  }

  Future<void> _loadCountry() async {
    var apiKey = "jqcug/MrfF8SPGv43I0aAg==isN46Amn1E7V5sPL";
    var api_url =
        Uri.parse('https://api.api-ninjas.com/v1/country?name=${countryName}');
    var response = await http.get(api_url, headers: {'X-Api-Key': apiKey});
    print(response.body);

    if (response.statusCode == 200) {
      var jsonData = response.body;
      var parsedData = json.decode(jsonData);
      countryName = parsedData[0]['name'];
      countryCode = parsedData[0]['iso2'];
      region = parsedData[0]['region'];
      capital = parsedData[0]['capital'];
      gdp = parsedData[0]['gdp'];
      surface_area = parsedData[0]['surface_area'];
      population = parsedData[0]['population'];
      currency = parsedData[0]['currency']['name'];
      currencyCode = parsedData[0]['currency']['code'];
      setState(() {});
    }
  }
}
