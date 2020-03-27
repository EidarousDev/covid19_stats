import 'package:admob_flutter/admob_flutter.dart';
import 'package:covid19stats/parser.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as dev;

class SelectionScreen extends StatefulWidget {
  SelectionScreen({this.countries, this.selectedCountry}) : super();
  final List countries;
  final String selectedCountry;

  @override
  _SelectionScreenState createState() => _SelectionScreenState();
}

class _SelectionScreenState extends State<SelectionScreen> {
  final scrollController = ScrollController();
  final GlobalKey key = new GlobalKey();

  /*
      "Italy" : "🇮🇹",
    "China" : "🇨🇳",
    "Spain" : "🇪🇸",
    "USA" : "🇺🇸",
    "Germany" : "🇩🇪",
    "Iran" : "🇮🇷",
    "France" : "🇫🇷",
    "S. Korea" : "🇰🇷",
    "Switzerland" : "🇨🇭",
    "UK" : "🇬🇧",
    "Netherlands" : "🇳🇱",
    "Belgium" : "🇧🇪",
    "Austria" : "🇦🇹",
    "Norway" : "🇳🇴",
    "Sweden" : "🇸🇪",
    "Portugal" : "🇵🇹",
    "Denmark" : "🇩🇰",
    "Australia" : "🇦🇺",
   */
  var countryFlags = {
    "Diamond Princess": "🛳",
    "Ascension Island": "🇦🇨",
    "Andorra": "🇦🇩",
    "UAE": "🇦🇪",
    "Afghanistan": "🇦🇫",
    "Antigua and Barbuda": "🇦🇬",
    "Anguilla": "🇦🇮",
    "Albania": "🇦🇱",
    "Armenia": "🇦🇲",
    "Angola": "🇦🇴",
    "Antarctica": "🇦🇶",
    "Argentina": "🇦🇷",
    "American Samoa": "🇦🇸",
    "Austria": "🇦🇹",
    "Australia": "🇦🇺",
    "Aruba": "🇦🇼",
    "Åland Islands": "🇦🇽",
    "Azerbaijan": "🇦🇿",
    "Bosnia and Herzegovina": "🇧🇦",
    "Barbados": "🇧🇧",
    "Bangladesh": "🇧🇩",
    "Belgium": "🇧🇪",
    "Burkina Faso": "🇧🇫",
    "Bulgaria": "🇧🇬",
    "Bahrain": "🇧🇭",
    "Burundi": "🇧🇮",
    "Benin": "🇧🇯",
    "St. Barth": "🇧🇱",
    "Bermuda": "🇧🇲",
    "Brunei": "🇧🇳",
    "Bolivia": "🇧🇴",
    "Caribbean Netherlands": "🇧🇶",
    "Brazil": "🇧🇷",
    "Bahamas": "🇧🇸",
    "Bhutan": "🇧🇹",
    "Bouvet Island": "🇧🇻",
    "Botswana": "🇧🇼",
    "Belarus": "🇧🇾",
    "Belize": "🇧🇿",
    "Canada": "🇨🇦",
    "Cocos (Keeling) Islands": "🇨🇨",
    "DRC": "🇨🇩",
    "CAR": "🇨🇫",
    "Congo": "🇨🇬",
    "Switzerland": "🇨🇭",
    "Côte d’Ivoire": "🇨🇮",
    "Cook Islands": "🇨🇰",
    "Chile": "🇨🇱",
    "Cameroon": "🇨🇲",
    "China": "🇨🇳",
    "Colombia": "🇨🇴",
    "Clipperton Island": "🇨🇵",
    "Costa Rica": "🇨🇷",
    "Cuba": "🇨🇺",
    "Cabo Verde": "🇨🇻",
    "Curaçao": "🇨🇼",
    "Christmas Island": "🇨🇽",
    "Cyprus": "🇨🇾",
    "Czechia": "🇨🇿",
    "Germany": "🇩🇪",
    "Diego Garcia": "🇩🇬",
    "Djibouti": "🇩🇯",
    "Denmark": "🇩🇰",
    "Dominica": "🇩🇲",
    "Dominican Republic": "🇩🇴",
    "Algeria": "🇩🇿",
    "Ceuta & Melilla": "🇪🇦",
    "Ecuador": "🇪🇨",
    "Estonia": "🇪🇪",
    "Egypt": "🇪🇬",
    "Western Sahara": "🇪🇭",
    "Eritrea": "🇪🇷",
    "Spain": "🇪🇸",
    "Ethiopia": "🇪🇹",
    "European Union": "🇪🇺",
    "Finland": "🇫🇮",
    "Fiji": "🇫🇯",
    "Falkland Islands": "🇫🇰",
    "Micronesia": "🇫🇲",
    "Faeroe Islands": "🇫🇴",
    "France": "🇫🇷",
    "Gabon": "🇬🇦",
    "UK": "🇬🇧",
    "Grenada": "🇬🇩",
    "Georgia": "🇬🇪",
    "French Guiana": "🇬🇫",
    "Guernsey": "🇬🇬",
    "Ghana": "🇬🇭",
    "Gibraltar": "🇬🇮",
    "Greenland": "🇬🇱",
    "Gambia": "🇬🇲",
    "Guinea": "🇬🇳",
    "Guadeloupe": "🇬🇵",
    "Equatorial Guinea": "🇬🇶",
    "Greece": "🇬🇷",
    "South Georgia & South Sandwich Islands": "🇬🇸",
    "Guatemala": "🇬🇹",
    "Guam": "🇬🇺",
    "Guinea-Bissau": "🇬🇼",
    "Guyana": "🇬🇾",
    "Hong Kong": "🇭🇰",
    "Heard & McDonald Islands": "🇭🇲",
    "Honduras": "🇭🇳",
    "Croatia": "🇭🇷",
    "Haiti": "🇭🇹",
    "Hungary": "🇭🇺",
    "Canary Islands": "🇮🇨",
    "Indonesia": "🇮🇩",
    "Ireland": "🇮🇪",
    "Israel": "🇮🇱",
    "Isle of Man": "🇮🇲",
    "India": "🇮🇳",
    "British Indian Ocean Territory": "🇮🇴",
    "Iraq": "🇮🇶",
    "Iran": "🇮🇷",
    "Iceland": "🇮🇸",
    "Italy": "🇮🇹",
    "Jersey": "🇯🇪",
    "Jamaica": "🇯🇲",
    "Jordan": "🇯🇴",
    "Japan": "🇯🇵",
    "Kenya": "🇰🇪",
    "Kyrgyzstan": "🇰🇬",
    "Cambodia": "🇰🇭",
    "Kiribati": "🇰🇮",
    "Comoros": "🇰🇲",
    "St. Kitts & Nevis": "🇰🇳",
    "North Korea": "🇰🇵",
    "S. Korea": "🇰🇷",
    "Kuwait": "🇰🇼",
    "Cayman Islands": "🇰🇾",
    "Kazakhstan": "🇰🇿",
    "Laos": "🇱🇦",
    "Lebanon": "🇱🇧",
    "Saint Lucia": "🇱🇨",
    "Liechtenstein": "🇱🇮",
    "Sri Lanka": "🇱🇰",
    "Liberia": "🇱🇷",
    "Lesotho": "🇱🇸",
    "Lithuania": "🇱🇹",
    "Luxembourg": "🇱🇺",
    "Latvia": "🇱🇻",
    "Libya": "🇱🇾",
    "Morocco": "🇲🇦",
    "Monaco": "🇲🇨",
    "Moldova": "🇲🇩",
    "Montenegro": "🇲🇪",
    "Saint Martin": "🇲🇫",
    "Madagascar": "🇲🇬",
    "Marshall Islands": "🇲🇭",
    "North Macedonia": "🇲🇰",
    "Mali": "🇲🇱",
    "Myanmar (Burma)": "🇲🇲",
    "Mongolia": "🇲🇳",
    "Macao": "🇲🇴",
    "Northern Mariana Islands": "🇲🇵",
    "Martinique": "🇲🇶",
    "Mauritania": "🇲🇷",
    "Montserrat": "🇲🇸",
    "Malta": "🇲🇹",
    "Mauritius": "🇲🇺",
    "Maldives": "🇲🇻",
    "Malawi": "🇲🇼",
    "Mexico": "🇲🇽",
    "Malaysia": "🇲🇾",
    "Mozambique": "🇲🇿",
    "Namibia": "🇳🇦",
    "New Caledonia": "🇳🇨",
    "Niger": "🇳🇪",
    "Norfolk Island": "🇳🇫",
    "Nigeria": "🇳🇬",
    "Nicaragua": "🇳🇮",
    "Netherlands": "🇳🇱",
    "Norway": "🇳🇴",
    "Nepal": "🇳🇵",
    "Nauru": "🇳🇷",
    "Niue": "🇳🇺",
    "New Zealand": "🇳🇿",
    "Oman": "🇴🇲",
    "Panama": "🇵🇦",
    "Peru": "🇵🇪",
    "French Polynesia": "🇵🇫",
    "Papua New Guinea": "🇵🇬",
    "Philippines": "🇵🇭",
    "Pakistan": "🇵🇰",
    "Poland": "🇵🇱",
    "St. Pierre & Miquelon": "🇵🇲",
    "Pitcairn Islands": "🇵🇳",
    "Puerto Rico": "🇵🇷",
    "Palestine": "🇵🇸",
    "Portugal": "🇵🇹",
    "Palau": "🇵🇼",
    "Paraguay": "🇵🇾",
    "Qatar": "🇶🇦",
    "Réunion": "🇷🇪",
    "Romania": "🇷🇴",
    "Serbia": "🇷🇸",
    "Russia": "🇷🇺",
    "Rwanda": "🇷🇼",
    "Saudi Arabia": "🇸🇦",
    "Solomon Islands": "🇸🇧",
    "Seychelles": "🇸🇨",
    "Sudan": "🇸🇩",
    "Sweden": "🇸🇪",
    "Singapore": "🇸🇬",
    "St. Helena": "🇸🇭",
    "Slovenia": "🇸🇮",
    "Svalbard & Jan Mayen": "🇸🇯",
    "Slovakia": "🇸🇰",
    "Sierra Leone": "🇸🇱",
    "San Marino": "🇸🇲",
    "Senegal": "🇸🇳",
    "Somalia": "🇸🇴",
    "Suriname": "🇸🇷",
    "South Sudan": "🇸🇸",
    "São Tomé & Príncipe": "🇸🇹",
    "El Salvador": "🇸🇻",
    "Sint Maarten": "🇸🇽",
    "Syria": "🇸🇾",
    "Eswatini": "🇸🇿",
    "Tristan Da Cunha": "🇹🇦",
    "Turks & Caicos Islands": "🇹🇨",
    "Chad": "🇹🇩",
    "French Southern Territories": "🇹🇫",
    "Togo": "🇹🇬",
    "Thailand": "🇹🇭",
    "Tajikistan": "🇹🇯",
    "Tokelau": "🇹🇰",
    "Timor-Leste": "🇹🇱",
    "Turkmenistan": "🇹🇲",
    "Tunisia": "🇹🇳",
    "Tonga": "🇹🇴",
    "Turkey": "🇹🇷",
    "Trinidad and Tobago": "🇹🇹",
    "Tuvalu": "🇹🇻",
    "Taiwan": "🇹🇼",
    "Tanzania": "🇹🇿",
    "Ukraine": "🇺🇦",
    "Uganda": "🇺🇬",
    "U.S. Outlying Islands": "🇺🇲",
    "United Nations": "🇺🇳",
    "USA": "🇺🇸",
    "Uruguay": "🇺🇾",
    "Uzbekistan": "🇺🇿",
    "Vatican City": "🇻🇦",
    "St. Vincent Grenadines": "🇻🇨",
    "Venezuela": "🇻🇪",
    "British Virgin Islands": "🇻🇬",
    "U.S. Virgin Islands": "🇻🇮",
    "Vietnam": "🇻🇳",
    "Vanuatu": "🇻🇺",
    "Wallis & Futuna": "🇼🇫",
    "Samoa": "🇼🇸",
    "Kosovo": "🇽🇰",
    "Yemen": "🇾🇪",
    "Mayotte": "🇾🇹",
    "South Africa": "🇿🇦",
    "Zambia": "🇿🇲",
    "Zimbabwe": "🇿🇼",
    "England": "🏴󠁧",
    "Scotland": "🏴󠁧",
    "Wales": "🏴󠁧",
  };

  final TextEditingController _controller = new TextEditingController();
  FocusNode textFieldFocusNode;
  bool searchFieldVisible = false;
  List arabicCountries = [];
  List filteredArabicCountries = [];
  bool newSearch = true;

  @override
  void initState() {
    super.initState();

    for (String country in widget.countries) {
      arabicCountries.add(Parser.getArabicCountry(country));
    }

    filteredArabicCountries = arabicCountries;
    textFieldFocusNode = new FocusNode();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 50), () {
        var index = widget.countries.indexOf(widget.selectedCountry);
        double height = MediaQuery.of(context).size.height - (4 * 56);
        double scrollTo = (56 * (index).toDouble() - height);
        dev.log(scrollTo.toString());
        if (scrollTo > 0)
          scrollController.animateTo(scrollTo,
              duration:
                  Duration(milliseconds: (678 * (1 + (index / 30))).toInt()),
              curve: Curves.ease);
      });
    });
  }

  @override
  void dispose() {
    textFieldFocusNode.dispose();
    super.dispose();
  }

  void toggleSearchField() {
    setState(() {
      searchFieldVisible = !searchFieldVisible;

      filteredArabicCountries = [];

      for (String country in widget.countries) {
        filteredArabicCountries.add(Parser.getArabicCountry(country));
      }

      newSearch = true;
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xff232d37),
        appBar: AppBar(
          title: Text('إختر دولة'),
          actions: <Widget>[
            IconButton(onPressed: toggleSearchField, icon: Icon(Icons.search)),
          ],
        ),
        body: Stack(
          children: <Widget>[
            Scrollbar(
              child: ListView.builder(
                key: key,
                controller: scrollController,
                shrinkWrap: true,
                itemCount: filteredArabicCountries.length,
                itemBuilder: (context, i) {
                  return getListTile(context, i,
                      firstInSearch: searchFieldVisible && i == 0,
                      animated: newSearch && i == 0);
                },
              ),
            ),
            new AnimatedContainer(
              duration: Duration(milliseconds: 250),
              height: searchFieldVisible ? 80 : 0,
              onEnd: () {
                if (searchFieldVisible) textFieldFocusNode.requestFocus();
              },
              child: new Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipRect(
                  clipBehavior: Clip.hardEdge,
                  child: new Card(
                    child: new ListTile(
                      leading: new Icon(Icons.search),
                      title: new TextField(
                        focusNode: textFieldFocusNode,
                        enabled: searchFieldVisible,
                        controller: _controller,
                        decoration: new InputDecoration(
                            hintText: 'البحث عن دولة',
                            border: InputBorder.none),
                        textAlign: TextAlign.right,
                        onTap: () {
                          if (newSearch = true) newSearch = false;
                        },
                        onChanged: (String value) {
                          setState(() {
                            newSearch = false;

                            filteredArabicCountries = arabicCountries
                                .where((s) => s.contains(value))
                                .toList();
                          });
                        },
                      ),
                      trailing: new IconButton(
                        icon: new Icon(Icons.cancel),
                        onPressed: toggleSearchField,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ));
  }

  Widget getListTile(context, i,
      {bool firstInSearch = false, bool animated = false}) {
    return InkWell(
      onTap: () {
        Navigator.pop(
            context, Parser.getArabicCountryKey(filteredArabicCountries[i]));
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: animated ? 250 : 0),
        height: 56,
        margin: EdgeInsets.only(top: firstInSearch ? 72 : 0),
        padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: new BoxDecoration(
            color: i % 2 == 0
                ? Colors.transparent
                : Color.fromARGB(10, 255, 255, 255)),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Text(
                filteredArabicCountries[i] +
                    (countryFlags.containsKey(Parser.getArabicCountryKey(
                            filteredArabicCountries[i]))
                        ? "  " +
                            countryFlags[Parser.getArabicCountryKey(
                                filteredArabicCountries[i])]
                        : ""),
                style: TextStyle(color: Colors.white, fontSize: 22),
              ),
              SizedBox(
                width: 15,
              ),
              Parser.getArabicCountryKey(filteredArabicCountries[i]) == "Global"
                  ? Icon(
                      Icons.public,
                      color: Colors.white,
                    )
                  : SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
