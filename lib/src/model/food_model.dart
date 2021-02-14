class FoodFields {
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
        itemName: json['item_name'] as String,
        itemType: json['item_type'] as int,
        itemDescription: json['item_description'] as String,
        brandName: json['brand_name'] as String,
        itemId: json['item_id'] as String,
        nfCalories: json['nf_calories'],
        nfProtein: json['nf_protein'],
        nfSugars: json['nf_sugars'],
        nfTotalFat: json['nf_total_fat']);
  }

  String itemName;
  int itemType;
  String itemDescription;
  String brandName;
  String itemId;
  dynamic nfCalories;
  dynamic nfProtein;
  dynamic nfSugars;
  dynamic nfTotalFat;
}

class FoodHits {
  FoodHits({this.index, this.type, this.id, this.score, this.fields});

  factory FoodHits.fromJson(Map<String, dynamic> json) {
    return FoodHits(
        index: json['_index'] as String,
        type: json['_type'] as String,
        id: json['_id'] as String,
        score: json['_score'],
        fields: FoodFields.fromJson(json['fields'] as Map<String, dynamic>));
  }

  String index;
  String type;
  String id;
  dynamic score;
  FoodFields fields;
}

class FoodResponse {
  FoodResponse({this.total, this.maxScore, this.hits});

  factory FoodResponse.fromJson(Map<String, dynamic> json) {
    final List<dynamic> hitsObjsJson = json['hits'] as List<dynamic>;
    final List<FoodHits> _hits = hitsObjsJson
        .map((dynamic tagJson) =>
            FoodHits.fromJson(tagJson as Map<String, dynamic>))
        .toList();
    return FoodResponse(
        total: json['total'] as int, maxScore: json['max_score'], hits: _hits);
  }

  int total;
  dynamic maxScore;
  List<FoodHits> hits;
}
