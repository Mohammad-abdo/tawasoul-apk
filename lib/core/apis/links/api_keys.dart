/// Class to store all API keys (request and response keys)
/// أي key جاي من API يتم حفظه هنا
class ApiKeys {
  // ========== Auth Keys ==========
  static const username = "username";
  static const password = "password";
  static const confirmPassword = "confirmPassword";
  static const email = "email";
  static const firstName = "firstName";
  static const lastName = "lastName";
  static const nationalId = "nationalId";
  static const otp = "otp";
  static const newPassword = "newPassword";

  // ========== Token Keys ==========
  static const accessToken = "accessToken";
  static const refreshToken = "refreshToken";
  static const token = "token";
  static const expiresInMins = "expiresInMins";

  // ========== User Keys ==========
  static const id = "id";
  static const user = "user";
  static const admin = "Admin";
  static const role = "role";
  static const age = "age";
  // ========== Profile Keys ==========
  static const profilePicture = "profile_picture_file";
  static const profilePictureUrl = "profile_picture"; // response URL
  static const phone = "phone";
  static const userEmail = "user_email";
  static const name = "name";
  static const avatar = "avatar";
  static const contactNumber = "contactNumber";
  static const countryCode = "countryCode";
  static const userType = "userType";
  static const gender = "gender";
  static const address = "address";
  static const serviceId = "serviceId";
  static const carModel = "carModel";
  static const carColor = "carColor";
  static const carPlateNumber = "carPlateNumber";
  static const carProductionYear = "carProductionYear";
  static const bankName = "bankName";
  static const accountHolderName = "accountHolderName";
  static const accountNumber = "accountNumber";
  static const bankIban = "bankIban";
  static const bankSwift = "bankSwift";
  static const carImage = "carImage";
  static const documents = "documents";
  static const latitude = "latitude";
  static const longitude = "longitude";
  static const isOnline = "isOnline";
  static const isAvailable = "isAvailable";
  static const referralCode = "referralCode";
  static const createdAt = "createdAt";
  static const emailStatus = "email_status";

  // ========== Pagination Keys ==========
  static const limit = "limit";
  static const skip = "skip";
  static const sortBy = "sortBy";
  static const order = "order";

  // ========== Banner Keys ==========
  static const image = "image";
  static const imageUrl = "imageUrl";

  // ========== Booking / Create Ride Keys ==========
  static const vehicleId = "vehicle_id";
  static const shipmentSizeId = "shipmentSize_id";
  static const shipmentWeightId = "shipmentWeight_id";
  static const paymentMethod = "paymentMethod";
  static const fromKey = "from";
  static const toKey = "to";
  static const totalPrice = "totalPrice";
  static const lat = "lat";
  static const lng = "lng";

  // ========== General Keys ==========
  static const message = "message";
  static const code = "code";
  static const success = "success";
  static const error = "error";
  static const data = "data";
  static const status = "status";
  static const statusCode = "statusCode";
}
