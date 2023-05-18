class CategoriesModel{
  dynamic nameCategories;
  dynamic detailsCategories;
  String? imageCategories;
  String ?id;
  bool ?like;
  String? idOfPatients;
  CategoriesModel(this.nameCategories,this.detailsCategories,this.imageCategories,this.like,{this.id,this.idOfPatients});
  CategoriesModel.fromJson(Map<String,dynamic>json){
    nameCategories=json['nameCategories'];
    detailsCategories=json['detailsCategories'];
    imageCategories=json['imageCategories'];
    like=json['like'];
    id=json['id'];
    idOfPatients=json['idOfPatients'];
  }
  Map<String, dynamic> toMap() {
    return {
      'nameCategories': nameCategories,
      'detailsCategories': detailsCategories,
      'imageCategories': imageCategories,
      'like':like,
      'id':id,
'idOfPatients':idOfPatients,
    };
  }

}