import 'package:flutter/material.dart';

class Parser {
  static List parseRow(List<String> row, bool hasInnerTag, String link) {
    int offset = hasInnerTag ? 0 : -2;
    return [
      parseInteger(row[5 + offset]),
      parseInteger(row[7 + offset]),
      parseInteger(row[9 + offset]),
      parseInteger(row[11 + offset]),
      parseInteger(row[13 + offset]),
      parseInteger(row[15 + offset]),
      parseInteger(row[17 + offset]),
      parseDouble(row[19 + offset]),
      link
    ];
  }

  static int parseInteger(String s) {
    try {
      return int.parse(s.split("<")[0].replaceAll(",", "").replaceAll("+", ""));
    } catch (e) {
      return 0;
    }
  }

  static double parseDouble(String s) {
    try {
      return double.parse(
          s.split("<")[0].replaceAll(",", "").replaceAll("+", ""));
    } catch (e) {
      return 0;
    }
  }

  static String getInnerString(String source, String a, String b) {
    return source.split(a)[1].split(b)[0];
  }

  static String normalizeName(String n) {
    return n
        .replaceAll("&ccedil;", "ç")
        .replaceAll("&eacute;", "é")
        .split("<")[0];
  }

  static Map<String, List> getCountryData(String body) {
    Map<String, List> countryData = {};
    var row =
        body.split("<tr class=\"total_row\">")[1].split("</tr>")[0].split(">");

    countryData["Global"] = parseRow(row, true, "");

    var tbody = getInnerString(body, "<tbody>", "</tbody>");
    var rows = tbody.split("<tr style=\"\">");
    rows.skip(1).forEach((rawRow) {
      row = rawRow.split(">");
      bool hasInnerTag = rawRow.contains("</a>") || rawRow.contains("</span>");
      countryData[normalizeName(row[hasInnerTag ? 2 : 1])] = parseRow(
          row,
          hasInnerTag,
          rawRow.contains("</a>")
              ? getInnerString(rawRow, "href=\"", "\"")
              : null);
    });

    return countryData;
  }

  static var arabicCountries = {
    'Global': 'عالميا',
    'China': 'الصين',
    'Italy': 'إيطاليا',
    'USA': 'الولايات المتحدة الأمريكية',
    'Spain': 'إسبانيا',
    'Germany': 'ألمانيا',
    'Iran': 'إيران',
    'France': 'فرنسا',
    'Switzerland': 'سويسرا',
    'S. Korea': 'كوريا الجنوبية',
    'UK': 'المملكة المتحدة',
    'Netherlands': 'هولندا',
    'Austria': 'النمسا',
    'Belgium': 'بلجيكا',
    'Portugal': 'البرتغال',
    'Norway': 'النرويج',
    'Canada': 'كندا',
    'Sweden': 'السويد',
    'Australia': 'أستراليا',
    'Brazil': 'البرازيل',
    'Israel': 'إسرائيل',
    'Turkey': 'تركيا',
    'Malaysia': 'ماليزيا',
    'Denmark': 'الدنمارك',
    'Czechia': 'التشيك',
    'Ireland': 'أيرلندا',
    'Japan': 'اليابان',
    'Chile': 'تشيلي',
    'Luxembourg': 'لوكسمبورج',
    'Ecuador': 'إكوادور',
    'Pakistan': 'باكستان',
    'Poland': 'بولندا',
    'Thailand': 'تايلاند',
    'Romania': 'رومانيا',
    'Saudi Arabia': 'المملكة العربية السعودية',
    'Finland': 'فنلندا',
    'Indonesia': 'إندونيسيا',
    'Greece': 'اليونان',
    'Iceland': 'أيسلندا',
    'Diamond Princess': 'Diamond Princess',
    'South Africa': 'جنوب أفريقيا',
    'Russia': 'روسيا',
    'Philippines': 'الفلبين',
    'Singapore': 'سنغافورة',
    'India': 'الهند',
    'Slovenia': 'سلوفينيا',
    'Qatar': 'قطر',
    'Panama': 'بنما',
    'Egypt': 'مصر',
    'Bahrain': 'البحرين',
    'Croatia': 'كرواتيا',
    'Peru': 'بيرو',
    'Hong Kong': 'هونج كونج',
    'Mexico': 'المكسيك',
    'Estonia': 'إستونيا',
    'Dominican Republic': 'جمهورية الدومنيكان',
    'Argentina': 'الأرجنتين',
    'Serbia': 'صربيا',
    'Colombia': 'كولومبيا',
    'Iraq': 'العراق',
    'Lebanon': 'لبنان',
    'UAE': 'الإمارات العربية المتحدة',
    'Armenia': 'أرمينيا',
    'Algeria': 'الجزائر',
    'Lithuania': 'ليتوانيا',
    'Taiwan': 'تايوان',
    'Hungary': 'هنغاريا',
    'Latvia': 'لاتفيا',
    'Bulgaria': 'بلغاريا',
    'Slovakia': 'سلوفاكيا',
    'New Zealand': 'نيوزيلاندا',
    'Kuwait': 'الكويت',
    'Uruguay': 'أوروغواي',
    'Andorra': 'أندورا',
    'San Marino': 'سان مارينو',
    'Costa Rica': 'كوستا ريكا',
    'North Macedonia': 'مقدونيا الشمالية',
    'Tunisia': 'تونس',
    'Morocco': 'المغرب',
    'Bosnia and Herzegovina': 'البوسنة والهرسك',
    'Jordan': 'الأردن',
    'Albania': 'ألبانيا',
    'Vietnam': 'فيتنام',
    'Faeroe Islands': 'جزر فاروس',
    'Malta': 'مالطا',
    'Moldova': 'مولدوفا',
    'Cyprus': 'قبرص',
    'Burkina Faso': 'بوركينا فاسو',
    'Ukraine': 'أوكرانيا',
    'Brunei': 'بروناي',
    'Sri Lanka': 'سيريلانكا',
    'Oman': 'سلطنة عمان',
    'Senegal': 'السنغال',
    'Réunion': 'ريونيون',
    'Cambodia': 'كمبوديا',
    'Venezuela': 'فنزويلا',
    'Azerbaijan': 'أذربيجان',
    'Belarus': 'روسيا البيضاء',
    'Kazakhstan': 'كازاخستان',
    'Afghanistan': 'أفغانستان',
    'Guadeloupe': 'غواديلوب',
    'Georgia': 'جورجيا',
    'Ivory Coast': 'ساحل العاج',
    'Cameroon': 'الكاميرون',
    'Ghana': 'غانا',
    'Palestine': 'فلسطين',
    'Martinique': 'مارتينيك',
    'Trinidad and Tobago': 'ترينداد وتوباغو',
    'Uzbekistan': 'أوزبكستان',
    'Montenegro': 'الجبل الأسود',
    'Liechtenstein': 'ليختنشتاين',
    'DRC': 'الكونغو الديمقراطية',
    'Mauritius': 'موريشيوس',
    'Cuba': 'كوبا',
    'Nigeria': 'نيجيريا',
    'Kyrgyzstan': 'قيرغيزستان',
    'Rwanda': 'رواندا',
    'Bangladesh': 'بنغلاديش',
    'Channel Islands': 'جزر القناة',
    'Paraguay': 'باراغواي',
    'Honduras': 'هندوراس',
    'Mayotte': 'مايوت',
    'Bolivia': 'بوليفيا',
    'Macao': 'ماكاو',
    'Jamaica': 'جامايكا',
    'French Polynesia': 'بولينيزيا الفرنسية',
    'Kenya': 'كينيا',
    'Monaco': 'موناكو',
    'French Guiana': 'غيانا الفرنسية',
    'Isle of Man': 'جزيرة آيل أوف مان',
    'Togo': 'توجو',
    'Guatemala': 'غواتيمالا',
    'Madagascar': 'مدغشقر',
    'Barbados': 'بربادوس',
    'Aruba': 'أروبا',
    'Gibraltar': 'جبل طارق',
    'New Caledonia': 'كاليدونيا الجديدة',
    'Uganda': 'أوغندا',
    'Maldives': 'جزر المالديف',
    'Ethiopia': 'أثيوبيا',
    'Tanzania': 'تنزانيا',
    'Zambia': 'زامبيا',
    'Djibouti': 'جيبوتي',
    'Mongolia': 'منغوليا',
    'El Salvador': 'السلفادور',
    'Equatorial Guinea': 'غينيا الإستوائية',
    'Saint Martin': 'القديس مارتن',
    'Niger': 'النيجر',
    'Dominica': 'دومينيكا',
    'Haiti': 'هايتي',
    'Namibia': 'ناميبيا',
    'Seychelles': 'سيشيل',
    'Suriname': 'سورينام',
    'Cayman Islands': 'جزر كايمان',
    'Curaçao': 'كوراساو',
    'Gabon': 'الغابون',
    'Benin': 'بنين',
    'Bermuda': 'برمودا',
    'Guyana': 'غيانا',
    'Bahamas': 'جزر البهاما',
    'Fiji': 'فيجي',
    'Greenland': 'جرينلاند',
    'Cabo Verde': 'كابو فيردي',
    'Congo': 'الكونغو',
    'Guinea': 'غينيا',
    'Vatican City': 'مدينة الفاتيكان',
    'Eswatini': 'Eswatini',
    'Gambia': 'غامبيا',
    'Sudan': 'السودان',
    'Zimbabwe': 'زيمبابوي',
    'Nepal': 'نيبال',
    'Angola': 'أنغولا',
    'Antigua and Barbuda': 'أنتيغوا وبربودا',
    'CAR': 'CAR',
    'Chad': 'تشاد',
    'Laos': 'لاوس',
    'Liberia': 'ليبيريا',
    'Mozambique': 'موزمبيق',
    'Myanmar': 'ميانمار',
    'St. Barth': 'سانت بارث',
    'Saint Lucia': 'القديسة لوسيا',
    'Bhutan': 'بوتان',
    'Guinea-Bissau': 'غينيا - بيساو',
    'Mali': 'مالي',
    'Mauritania': 'موريتانيا',
    'Nicaragua': 'نيكاراغوا',
    'Sint Maarten': 'سينت مارتن',
    'Belize': 'بليز',
    'Eritrea': 'إريتريا',
    'Grenada': 'غرينادا',
    'Libya': 'ليبيا',
    'Montserrat': 'مونتسيرات',
    'Papua New Guinea': 'بابوا غينيا الجديدة',
    'St. Vincent Grenadines': 'سانت فنسنت غرينادين',
    'Somalia': 'الصومال',
    'Syria': 'سوريا',
    'Timor-Leste': 'تيمور ليشتي',
    'Turks and Caicos': 'جزر تركس وكايكوس',
  };

  static getArabicCountry(String country) {
    return arabicCountries[country] ?? country;
  }

  static getArabicCountryKey(String arabicCountry){
    return arabicCountries.keys.firstWhere(
            (k) => arabicCountries[k] == arabicCountry, orElse: () => null);
  }

  static List<String> getCategories(String s) {
    return s
        .split("categories: [")[1]
        .split("]")[0]
        .replaceAll("\"", "")
        .split(",");
  }

  static List<int> getDataPoints(String s) {
    return s
        .split("data: [")[1]
        .split("]")[0]
        .split(",")
        .map(int.parse)
        .toList();
  }

  static List<Color> gradientColorsTotal = [
    Colors.grey[600],
    Colors.grey[800],
  ];
  static List<Color> gradientColorsRecovered = [
    Colors.lightGreen,
    Colors.green[800],
  ];
  static List<Color> gradientColorsDeaths = [
    Colors.orange[800],
    Colors.red,
  ];

  static List getChartsData(String body) {
    var textToParse = body.split("text: 'Total Cases'")[1];
    var xLabels = getCategories(textToParse);
    var values = getDataPoints(textToParse);

    textToParse = body.split("text: '(Number of Infected People)")[1];
    var xLabels2 = getCategories(textToParse);
    var values2 = getDataPoints(textToParse);

    textToParse = body.split("text: 'Total Deaths'")[1];
    var xLabels3 = getCategories(textToParse);
    var values3 = getDataPoints(textToParse);

    values2.asMap().forEach((index, value) {
      values2[index] = values[index] - values3[index] - value;
    });

    return [
      [xLabels, values, gradientColorsTotal],
      [xLabels2, values2, gradientColorsRecovered],
      [xLabels3, values3, gradientColorsDeaths],
    ];
  }

  static List getEmptyChart() {
    return [
      [
        ["0", "1"],
        [0, 1],
        gradientColorsTotal
      ],
      [
        ["0", "1"],
        [0, 1],
        gradientColorsRecovered
      ],
      [
        ["0", "1"],
        [0, 1],
        gradientColorsDeaths
      ],
      false,
      false,
      false
    ];
  }
}
