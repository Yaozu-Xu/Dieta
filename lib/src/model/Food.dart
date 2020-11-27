class FoodFields {
  String itemName;
  int itemType;
  String itemDescription;
  String brandName;
  String itemId;
  dynamic nfCalories;
  dynamic nfProtein;
  dynamic nfSugars;
  dynamic nfTotalFat;

  FoodFields(
      {this.brandName,
      this.itemDescription,
      this.itemName,
      this.itemType,
      this.itemId,
      this.nfCalories,
      this.nfProtein,
      this.nfSugars,
      this.nfTotalFat});

  factory FoodFields.fromJson(Map<String, dynamic> json) {
    return FoodFields(
        itemName: json['item_name'],
        itemType: json['item_type'],
        itemDescription: json['item_description'],
        brandName: json['brand_name'],
        itemId: json['item_id'],
        nfCalories: json['nf_calories'],
        nfProtein: json['nf_protein'],
        nfSugars: json['nf_sugars'],
        nfTotalFat: json['nf_total_fat']);
  }
}

class FoodHits {
  String index;
  String type;
  String id;
  dynamic score;
  FoodFields fields;

  FoodHits({this.index, this.type, this.id, this.score, this.fields});

  factory FoodHits.fromJson(Map<String, dynamic> json) {
    return FoodHits(
        index: json['_index'],
        type: json['_type'],
        id: json['_id'],
        score: json['_score'],
        fields: FoodFields.fromJson(json['fields']));
  }
}

class FoodResponse {
  int total;
  dynamic maxScore;
  List<FoodHits> hits;

  FoodResponse({this.total, this.maxScore, this.hits});

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    var hitsObjsJson = json['hits'] as List;
    List<FoodHits> _hits =
        hitsObjsJson.map((tagJson) => FoodHits.fromJson(tagJson)).toList();
    return FoodResponse(
        total: json['total'], maxScore: json['max_score'], hits: _hits);
  }
}
