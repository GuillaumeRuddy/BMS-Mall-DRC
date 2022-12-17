class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> listeDesCategories = [
  Category(
    name: 'Gang de box',
    noOfCourses: 55,
    thumbnail: 'assets/img/glap.png',
  ),
  Category(
    name: 'PlayStation ',
    noOfCourses: 150,
    thumbnail: 'assets/img/ps4_console_blue_1.png',
  ),
  Category(
    name: 'Tshirt NIKE',
    noOfCourses: 16,
    thumbnail: 'assets/img/tshirt.png',
  ),
  Category(
    name: 'Adidas',
    noOfCourses: 55,
    thumbnail: 'assets/img/shoes2.png',
  ),
  Category(
    name: 'HP Core I3',
    noOfCourses: 55,
    thumbnail: 'assets/icons/laptop.jpg',
  ),
  Category(
    name: 'Ambourgeur ',
    noOfCourses: 20,
    thumbnail: 'assets/icons/accounting.jpg',
  ),
  Category(
    name: 'Photography',
    noOfCourses: 16,
    thumbnail: 'assets/icons/photography.jpg',
  ),
  Category(
    name: 'Product Design',
    noOfCourses: 25,
    thumbnail: 'assets/icons/design.jpg',
  ),
];
