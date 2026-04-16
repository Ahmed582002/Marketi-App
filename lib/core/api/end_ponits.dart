class EndPoint {
  static String baseUrl = "https://supermarket-dan1.onrender.com/api/v1";
  static String signIn = "/auth/signIn";
  static String signUp = "/auth/signUp";
  static String categories = "/home/categories";
  static String brands = "/home/brands";
  static String products = "/home/products";
  static String productsByCategory = "/home/products/category";
  static String productsByBrand = "/home/products/brand";
  static String productsFilter = "/home/productsFilter";
  static String addFavorite = "/user/addFavorite";
  static String deleteFavorite = "/user/deleteFavorite";
  static String getFavorite = "/user/getFavorite";
  static String addCart = "/user/addCart";
  static String deleteCart = "/user/deleteCart";
  static String getCart = "/user/getCart";
  static String userDate = "/portfoilo/userData";
}

class ApiKey {
  // Api
  static String status = "status";
  static String errorMessage = "ErrorMessage";
  // User Data
  static String email = "email";
  static String password = "password";
  static String token = "token";
  static String message = "message";
  static String id = "_id";
  static String name = "name";
  static String phone = "phone";
  static String confirmPassword = "confirmPassword";
  static String address = "address";
  static String userImage = "image";
  // Brands
  static String brandName = "name";
  static String brandEmoji = "emoji";
  // Categories
  static String categorieSlug = 'slug';
  static String categorieName = "name";
  static String categorieUrl = "url";
  static String categorieImage = "image";
  // Profucts
  static String productId = "id";
  static String productTitle = "title";
  static String productDescription = "description";
  static String productCategory = "category";
  static String productPrice = "price";
  static String productDiscountPercentage = "discountPercentage";
  static String productRating = "rating";
  static String productStock = "stock";
  static String productTags = "tags";
  static String productBrand = "brand";
  static String productThumbnail = "thumbnail";
  static String productImages = "images";
  static String productReviews = "reviews";
  // Reviews
  static String reviewRating = "rating";
  static String reviewComment = "comment";
  static String reviewDate = "date";
  static String reviewReviewerName = "reviewerName";
  static String reviewReviewerEmail = "reviewerEmail";
}
