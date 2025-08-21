

class CardTypeModel {
  String cardLogoPath;
  String cardType;
  
  CardTypeModel({required this.cardLogoPath, required this.cardType});
}

List<CardTypeModel> cardTypeList = [
  CardTypeModel(cardLogoPath: 'assets/images/visa.svg', cardType: 'Visa'),
  CardTypeModel(cardLogoPath: 'assets/images/master.svg', cardType: 'MasterCard'),
  CardTypeModel(cardLogoPath: 'assets/images/paypal.svg', cardType: 'PayPal'),
];

