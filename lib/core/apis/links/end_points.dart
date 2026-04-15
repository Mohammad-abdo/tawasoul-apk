class EndPoints {
  /// Must end with / so Dio builds full URL correctly: baseUrl + path
  static const String _baseUrl = "https://jadwa.developteam.site/api/user/";
  static String get baseUrl => _baseUrl;

  /// Paths are relative to baseUrl (e.g. baseUrl + path).

  // ========== Driver Auth ==========
  /// POST - Register new driver with full details + vehicle + documents
  static const String register = "auth/register";

  /// POST - Login with phone + password
  static const String login = "auth/login";

  /// POST - Forget OTP (generate phone password)
  static const String forgetPassword = "auth/forgot-password";

  /// POST - Reset password (require token)
  static const String resetPassword = "auth/reset-password";

  static const String resendOtp = "auth/resend-otp";
  static const String sendOtp = "auth/send-otp";
  static const String submitOtp = "auth/submit-otp";
  static String get currentLocation => "auth/current-location";
  static String get services => "services";

  /// POST - Logout
  static const String logOut = "auth/logout";

  // ========== Driver Profile ==========
  /// GET - Get driver profile (points, stars, order, bank, wallet)
  static const String profile = "profile";

  /// PUT - Update personal info + avatar
  static const String profileUpdate = "profile/update";

  /// PUT - Update registration status + missing documents
  static const String profileStatus = "profile/status";

  /// PUT - Update bank account
  static const String bankAccountUpdate = "bank-account/update";

  //* ========== Driver Vehicle ==========
  /// PUT - Update vehicle info + image
  static const String driverVehicleUpdate = "vehicle/update";

  //* ========== Driver Documents ==========
  /// GET - Get all document types (for registration form)
  static const String driverDocumentsRequired = "documents/required";

  /// GET - Get my uploaded documents
  static const String driverDocuments = "documents";

  /// POST - Upload document
  static const String driverDocumentsUpload = "documents/upload";

  //* ========== Driver Status ==========
  /// POST - Update driver availability + location
  static const String driverStatusUpdateLocation = "status/update-location";

  /// POST - Update GPS location (during ride or idle)
  static const String driverStatusUpdateGps = "status/update-gps";

  /// POST
  static const String statusDriver = "status/go-online";

  //* ========== Driver Rides ==========
  /// GET - Get my ride history (planned, done, cancelled)
  static const String driverRides = "rides";

  /// GET - Get single ride details (path, pickup, payments, ratings, negotiations)
  static String driverRideById(String id) => "rides/$id";

  /// POST - Accept a ride request
  static const String driverRidesRequest = "rides/request";

  /// POST - Update ride status (pickup + done)
  static const String driverRidesStart = "rides/start";

  /// POST - Complete a ride (paid not paid, payment gateway + wallet)
  static const String driverRidesComplete = "rides/complete";

  /// POST - Cancel a ride from driver side
  static const String driverRidesCancel = "rides/cancel";

  /// POST - Apply bid on a ride request
  static const String driverRidesApplyBid = "rides/apply-bid";

  //* ========== Driver Ratings ==========
  /// GET - Get all ratings received from client (with average)
  static const String driverRatings = "ratings";

  //* ========== Driver Wallet ==========
  /// GET - Get wallet balance
  static const String driverWallet = "wallet";

  /// GET - Get wallet transaction history
  static const String driverWalletHistory = "wallet/history";

  /// GET - Get wallet operations (explained)
  static const String driverWalletOperations = "wallet/operations";

  /// GET
  static const String walletOperationsFilter = "wallet/operations/filter";

  /// GET - Get earnings summary (balance, totals, rides)
  static const String walletEarnings = "wallet/earnings";

  /// POST - Submit a new withdrawal request
  static const String driverWalletWithdraw = "withdrawals";

  //* ========== Driver Complaints ==========
  /// POST - File a complaint about a ride or driver
  static const String driverComplaints = "complaints";

  /// GET - Get complaint details
  static String driverComplaintById(String id) => "complaints/$id";

  //* ========== Driver Negotiation ==========
  /// GET - Get negotiation timer settings
  static const String driverNegotiationSettings = "negotiation/settings";

  /// POST - Counter offer on a ride bid
  static const String driverNegotiationSend = "negotiation/send";

  /// POST - Accept a negotiation bid
  static const String driverNegotiationAccept = "negotiation/accept";

  /// POST - Reject a negotiation bid
  static const String driverNegotiationReject = "negotiation/reject";

  /// GET - Get negotiation history for a ride
  static String driverNegotiationHistoryByRideId(String rideId) =>
      "negotiation/history/$rideId";

  //* ========== Driver Notifications ==========
  /// GET - Get driver notifications (paginated)
  static const String driverNotifications = "notifications";

  /// PUT - Mark a notification as read
  static String driverNotificationRead(String id) => "notifications/$id/read";

  /// PUT - Mark all notifications as read
  static const String driverNotificationsReadAll = "notifications/read-all";

  //* ========== Driver Static ==========
  /// GET - Get Privacy Policy
  static const String driverStaticPrivacyPolicy = "static/privacy-policy";

  /// GET - Get Terms and Conditions
  static const String driverStaticTerms = "static/terms";

  /// GET - Get Help Center + FAQs
  static const String driverStaticHelpCenter = "static/help-center";
}
