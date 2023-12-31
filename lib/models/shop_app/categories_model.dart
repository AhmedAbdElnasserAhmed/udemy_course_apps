class CategoriesModel
{
  late bool status;
  late CategoriesDataModel data;

  CategoriesModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = CategoriesDataModel.fromJson(json['data']);
  }
}

class CategoriesDataModel
{
  late int currentPage;
  late List<DataModel> data = [];
  // late String firstPageUrl;
  // late int from;
  // late int lastPage;
  // late int lastPageUrl;
  // late String nextPageUrl;  //return in api null
  // late String path;
  // late int perPage;
  // late String perPageUrl;  //return in api null
  // late int to;
  // late int total;

  CategoriesDataModel.fromJson(Map<String , dynamic> json)
  {
    currentPage = json['current_page'];

    json['data'].forEach((element)
    {
      data.add(DataModel.fromJson(element));
    });
    
    // firstPageUrl = json['first_page_url'];
    // from = json['from'];
    // lastPage = json['last_page'];
    // lastPageUrl = json['last_page_url'];
    // nextPageUrl = json['next_page_url'];
    // path = json['path'];
    // perPage = json['per_page'];
    // perPageUrl = json['prev_page_url'];
    // to = json['to'];
    // total = json['total'];
  }
}

class DataModel
{
  late int id;
  late String name;
  late String image;

  DataModel.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    name = json['name'];
    image = json['image'];
  }
}