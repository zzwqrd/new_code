// // Example Model using the custom helper functions with large data
// class LargeDataModel {
//   late int id;
//   late String title;
//   late String description;
//   late List<String> categories;
//   late Prodact productDetails;
//   late List<Names> contributors;
//   late DateTime? publishDate;
//   late DateTime? lastUpdatedDate;
//   late TimeOfDay? publishTime;
//   late File? mainImage;
//   late List<File> relatedImages;
//   late Map<String, dynamic>? additionalMetadata;
//
//   LargeDataModel.fromJson(Map<String, dynamic> json) {
//     id = fromJsonInt(json["id"]);
//     title = fromJsonString(json["title"]);
//     description = fromJsonString(json["description"]);
//     categories = fromJsonList<String>(
//         json['categories'], (item) => fromJsonString(item));
//     productDetails = fromJsonObject<Prodact>(
//         json['product_details'], (item) => Prodact.fromJson(item));
//     contributors = fromJsonList<Names>(
//         json['contributors'], (item) => Names.fromJson(item));
//     publishDate = fromJsonDateTime(json["publish_date"]);
//     lastUpdatedDate =
//         fromCustomDateTimeString(json["last_updated_date"], "dd/MM/yyyy");
//     publishTime = fromCustomTimeString(json["publish_time"], "HH:mm");
//     mainImage = fromJsonFile(json["main_image"]);
//     relatedImages = fromJsonFiles(json['related_images']);
//     additionalMetadata = json['metadata'] != null
//         ? Map<String, dynamic>.from(json['metadata'])
//         : {};
//   }
//
//   // Method to convert object to JSON
//   Map<String, dynamic> toJson(BuildContext context) {
//     return {
//       'id': id,
//       'title': title,
//       'description': description,
//       'categories': categories,
//       'product_details': productDetails.toJson(),
//       'contributors':
//       contributors.map((contributor) => contributor.toJson()).toList(),
//       'publish_date': publishDate?.toIso8601String(),
//       'last_updated_date': lastUpdatedDate != null
//           ? formatCustomDateTime(lastUpdatedDate, 'dd/MM/yyyy')
//           : null,
//       'publish_time': publishTime != null ? publishTime!.format(context) : null,
//       'main_image': mainImage?.path,
//       'related_images': relatedImages.map((image) => image.path).toList(),
//       'metadata': additionalMetadata,
//     };
//   }
// }
//
// // Example class for Names (contributors)
// class Names {
//   late String firstName;
//   late String lastName;
//
//   Names.fromJson(Map<String, dynamic> json) {
//     firstName = fromJsonString(json['first_name']);
//     lastName = fromJsonString(json['last_name']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'first_name': firstName,
//       'last_name': lastName,
//     };
//   }
// }
//
// // Example class for Prodact (product details)
// class Prodact {
//   late int id;
//   late String name;
//   late String description;
//
//   Prodact.fromJson(Map<String, dynamic> json) {
//     id = fromJsonInt(json['id']);
//     name = fromJsonString(json['name']);
//     description = fromJsonString(json['description']);
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'name': name,
//       'description': description,
//     };
//   }
// }
//
// void printModelData(LargeDataModel model) {
//   // طباعة الحقول الأساسية
//   print('ID: ${model.id}');
//   print('Title: ${model.title}');
//   print('Description: ${model.description}');
//
//   // طباعة الفئات (categories)
//   print('Categories:');
//   model.categories.forEach((category) {
//     print('- $category');
//   });
//
//   // طباعة تفاصيل المنتج (productDetails)
//   print('Product Details:');
//   print('Product ID: ${model.productDetails.id}');
//   print('Product Name: ${model.productDetails.name}');
//   print('Product Description: ${model.productDetails.description}');
//
//   // طباعة المساهمين (contributors)
//   print('Contributors:');
//   model.contributors.forEach((contributor) {
//     print('Name: ${contributor.firstName} ${contributor.lastName}');
//   });
//
//   // طباعة التواريخ
//   print('Publish Date: ${model.publishDate}');
//   print('Last Updated Date: ${model.lastUpdatedDate}');
//   print('Publish Time: ${model.publishTime}');
//
//   // طباعة الصورة الرئيسية
//   if (model.mainImage != null) {
//     print('Main Image: ${model.mainImage!.path}');
//   }
//
//   // طباعة الصور المرتبطة
//   print('Related Images:');
//   model.relatedImages.forEach((image) {
//     print('- ${image.path}');
//   });
//
//   // طباعة الميتاداتا الإضافية
//   print('Additional Metadata:');
//   model.additionalMetadata?.forEach((key, value) {
//     print('$key: $value');
//   });
// }
