class ConstantTexts {

  static const String appName = "FreshPick";


  //Routes
  static const String homeRoute = "/Home";


  //Database
  static const String usersCollection = "Users";
  static const String userCartCollection = "Carts";
  static const String userAddressesCollection = "Addresses";
  static const String categoriesCollection = "Categories";
  static const String itemsCollection = "Items";
  static const String ordersCollection = "Orders";
  static const String orderDetailsCollection = "Details";
  static const String orderDetailsDoc = "OrderDetails";
  static const String cartItemsCollection = "CartItems";
  static const String itemDetailsCollection = "Details";
  static const String itemDetailsDoc = "ItemDetails";
  static const String itemImagesCollection = "ItemImages";
  static const String bannersCollection = "Banners";
  static const String homeBannerDoc = "HomeBanners";
  static const String feedsCollection = "Feeds";
  static const String feedLikesCollection = "Likes";
  static const String feedReportCollection = "Reports";

  //Firebase Storage
  static const String itemImagesFolder = "ItemImages";
  static const String feedImagesFolder = "FeedImages";

  //Category
  static const Map<String, String> categoryTypes = {
    "Fruit": "Fruits",
    "Vegetable": "Vegetables",
  };

  //User fields
  static const String uid = "uid";
  static const String name = "name";
  static const String userFirstName = "first";
  static const String userLastName = "last";
  static const String userPhone = "phone";
  static const String userPic = "pic";

  //Address fields
  static const String addressNickName = "nickName";
  static const String addressName = "name";
  static const String addressAddress = "address";
  static const String addressPhone = "phoneNumber";
  static const String addressHouseNo = "no";
  static const String addressApartmentName = "apartment_building";
  static const String addressStreet = "street";
  static const String addressLine1 = "line1";
  static const String addressLine2 = "line2";
  static const String addressCityTown = "city_town";
  static const String addressPostal = "postalCode";
  static const String addressDistrict = "district";
  static const String addressProvince = "province";
  static const String addressIsSelected = "isSelected";
  static const String addressLocation = "location";
  static const String addressLatitude = "latitude";
  static const String addressLongitude = "longitude";
  static const String addressGeoFirePoint = "geopoint";



  // Item fields
  static const String itemId = "id";
  static const String itemTitle = "title";
  static const String itemMainCat = "mainCategory";
  static const String itemSubCat = "subCategory";
  static const String itemUnitPrice = "unitPrice";
  static const String itemAvailableQuantity = "availableQuantity";
  static const String itemUnitType = "unitType";
  static const String itemMainPic = "mainPic";
  static const String itemOwner = "owner";
  static const String itemOwnerName = "ownerName";
  static const String itemPublished = "published";
  static const String itemDescription = "description";
  static const String itemImages = "images";
  static const String itemUnpublishedDate = "unpublishedDate";
  static const String itemPickupLocation = "pickupLocation";
  static const String itemPickupLatitude = "pickupLatitude";
  static const String itemPickupLongitude = "pickupLongitude";
  static const String itemPickupAddress = "pickupAddress";
  static const String itemPhone = "phone";
  static const String itemImageUrl = "itemImageUrl";

  //CartItem fields
  static const String cartItemQuantity = "quantity";
  static const String cartItemPrice = "price";

  //Order fields
  static const String orderId = "orderId";
  static const String orderedBy = "orderedBy";
  static const String orderedFrom = "orderedFrom";
  static const String sellerId = "sellerId";
  static const String sellerName = "sellerName";
  static const String orderTotalAmount = "totalAmount";
  static const String orderDateTime = "orderDateTime";
  static const String orderPaymentMethod = "paymentMethod";
  static const String orderBuyerName = "buyerName";
  static const String orderAddress = "buyerAddress";
  static const String orderLocation = "buyerLocation";
  static const String orderPhone = "buyerPhone";
  static const String orderStatus = "status";
  static const String totalCartPrice = "totalCartPrice";
  static const String orderItems = "items";
  static const String orderItemCount = "itemCount";
  static const String sellerAddress = "sellerAddress";
  static const String sellerLocation = "sellerLocation";
  static const String sellerPhone = "sellerPhone";
  static const String tradingItem = "tradingItem";

  //Feed fields

  static const String feedId = "feedId";
  static const String feedUid = "uid";
  static const String feedName = "name";
  static const String feedProPic = "proPic";
  static const String feedImageURL = "imageURL";
  static const String feedTitle = "title";
  static const String feedDescription = "description";
  static const String feedLikes = "likesCount";
  static const String feedReports = "reportCount";
  static const String feedIsLiked = "isLiked";
  static const String feedDateTime = "dateTime";
  static const String feedLiked = "liked";


  //Global Texts

  //OnBoarding Texts
  static const String onBoardingTitle1 = "Choose your product";
  static const String onBoardingTitle2 = "Select Payment Method";
  static const String onBoardingTitle3 = "Deliver at your door step";

  static const String onBoardingSubTitle1 = "Shop Fresh, Eat Healthy – Your Organic Choice!";
  static const String onBoardingSubTitle2 = "freshPay: Our Very Own Way to Trade Fresh, Live Fresh!";
  static const String onBoardingSubTitle3 = "From Our Doorstep to Yours - Swift, Secure, and Contactless Delivery!";

  //Auth Form Texts
  static const String firstName = "First Name";
  static const String lastName = "Last Name";
  static const String email = "E-Mail";
  static const String password = "Password";
  static const String confirmPassword = "Confirm password";
  static const String newPassword = "New Password";
  static const String username = "Username";
  static const String phoneNo = "Phone Number";
  static const String rememberMe = "Remember Me";
  static const String forgetPassword = "Forget Password";
  static const String logIn = "Log In";
  static const String createAccount = "Create Account";
  static const String orContinueWith = "Or Continue With";
  static const String iAgreeTo = "I agree to";
  static const String privacyPolicy = "Privacy Policy";
  static const String termsOfUse = "Terms of use";
  static const String verificationCode = "Verification Code";
  static const String resendEmail = "Resend E-Mail";
  static const String sendEmail = "Send E-Mail";
  static const String continueText = "Continue";


  //Auth Headings Texts
  static const String loginTitle = "Welcome back,";
  static const String loginSubTitle = "Connecting communities, promoting healthy living.";
  static const String registerTitle = "Let's get started,";
  static const String registerSubTitle = "Register to buy and sell local organic produce effortlessly.";
  static const String forgetPasswordTitle = "Forget password";
  static const String forgetPasswordSubTitle = "Don't worry, it happens! Enter your email address below, and we'll send you a password reset link.";
  static const String changeYourPasswordTitle = "Password Reset Email Sent.";
  static const String changeYourPasswordSubTitle = "Your Account Security is Our Priority! We've Sent You a Secure Link to Safely Change Your Password and Keep Your Account Protected.";
  static const String verifyEmailTitle = "Verify your Email address!";
  static const String verifyEmailSubTitle = "Almost there! A verification link has been sent to your email address. Please verify your email to continue.";
  static const String emailNotReceivedMessage = "Didn't get the email? Check your junk/spam or resend it.";
  static const String yourAccountCreatedTitle = "Your account successfully created!";
  static const String yourAccountCreatedSubTitle = "Welcome to your Ultimate Shopping Destination: Yout Account is Created, Unleash the Joy of Seamless Online Shopping!";

  //Navigation Texts
  static const String selItem = "Sell Item";
  static const String postFeed = "Post";

  //Sell Texts
  static const String sellTitle = "Sell";
  static const String myItemsTitle = "My Items";
  static const String publishedItems = "Published Items";
  static const String unpublishedItems = "Unpublished Items";
  static const String publish = "Publish";
  static const String unpublish = "Unpublish";
  static const String unpublishedIn = "Unpublished in:";
  static const String noUnpublishedItemsTitle = "No Unpublished Items";
  static const String noUnpublishedItemsSubTitle = "Add items to sell and they will appear here before publishing.";
  static const String noPublishedItemsTitle = "No Published Items";
  static const String noPublishedItemsSubTitle = "Publish items and they will appear here. Swipe left to publish items.";

  //Home Texts
  static const String homeAppbarTitle = "Fresh foods, Happy Life.";
  static const String section1Title = "Nearest Items";

  //Settings Texts
  static const String account = "Account";


  static const String accountSettings = "Account Settings";

  static const String addressTileTitle = "My Address";
  static const String addressTileSubTitle = "Manage delivery addresses";
  static const String cartTileTitle = "My Cart";
  static const String cartTileSubTitle = "Add, remove products and move to checkout";
  static const String orderTileTitle = "My Orders";
  static const String orderTileSubTitle = "In-progress and Completed Orders";
  static const String accountDeleteTileTitle = "Delete my Account";
  static const String accountDeleteTileSubTitle = "Delete your account permanently.";

  static const String appSettings = "App Settings";

  static const String appearanceTileTitle = "Appearance";
  static const String appearanceTileSubTitle = "Dark and Light Themes";
  static const String communicationTileTitle = "Communication";
  static const String communicationTileSubTitle = "Contacts and Marketing";
  static const String locationTileTitle = "Geolocation";
  static const String locationTileSubTitle = "Get recommendations based on location";
  static const String syncTileTitle = "Sync Data";

  static const String logout = "Logout";

  //Location Select Texts
  static const String locationSelectTitle = "Select Location";
  static const String selectLocation = "Select Location";

  // user
  //TODO: remove these
  static const String userNameValue= "first last";
  static const String nameValue = "Firstname Lastname";
  static const String userIdValue = "0001";
  static const String userEmailValue = "email.@email.com";
  static const String userPhoneValue = "+941234567";
  static const String userGenderValue = "Male";
  static const String userBirthDateValue = "01-01-2024";



  // profile
  static const String profileInformation = "Profile Information";
  static const String personalInformation = "Personal Information";

  static const String userNameTitle = "User Name";
  static const String nameTitle = "Name";
  static const String userIdTitle = "User ID";
  static const String userEmailTitle = "Email";
  static const String userPhoneTitle = "Phone Number";
  static const String userGenderTitle = "Gender";
  static const String userBirthDateTitle = "Date of Birth";

  static const String closeAccount = "Delete Account";

  // address

  static const String addressTitle = "Addresses";
  static const String addNewAddress = "Add New Address";
  static const String addressNickNameField = "Nick Name";
  static const String addressNickNameFieldHint = "Home, Work, etc.";
  static const String addressNameField = "Name";
  static const String addressAddressField = "Address";
  static const String addressPhoneField = "Contact Number";
  static const String addressHouseNoField = "No";
  static const String addressApartmentNameField = "Apartment/Building";
  static const String addressStreetField = "Street";
  static const String addressLine1Field = "Line 1";
  static const String addressLine2Field = "Line 2";
  static const String addressCityTownField = "City / Town";
  static const String addressPostalField = "Postal Code";
  static const String addressDistrictField = "District";
  static const String addressProvinceField = "Province";
  static const String addressSaveButton = "Save";
  static const String noAddressesTitle = "No addresses to display";
  static const String noAddressesSubTitle = "Add new address or refresh to load your existing addresses from cloud.";
  static const String locationSelectId = "location";

  //Order
  static const String orderPageTitle = "My Orders";
  static const String orderCardOrderedDateTitle = "Ordered on";
  static const String orderCardItemsCount = "Items Count";

  // appearance
  static const String appearanceDark = "Dark";
  static const String appearanceLight= "Light";
  static const String appearanceSystem= "System";

  //Cart
  static const String cartAppbarTitle = "Cart";
  static const String checkout = "Checkout LKR";
  static const String seller = "Seller";
  static const String sellerTotal = "Seller total LKR";
  static const String lkr = "LKR";
  static const String unitPrice = "Unit price";
  static const String cartItems = "cartItems";
  static const String cartEmptyTitle = "Your cart is empty";
  static const String cartEmptySubTitle = "Add items to your cart and they will appear here.";
  static const String quantity = "Quantity: ";

  //Checkout
  static const String checkoutTitle = "Checkout";
  static const String orderReview = "Order Review";
  static const String checkoutLkr = "Checkout LKR ";
  static const String subTotal = "Subtotal";
  static const String discount = "Discount";
  static const String shippingFee = "Shipping Fee";
  static const String taxFee = "Tax Fee";
  static const String orderTotal = "Order Total";
  static const String apply = "Apply";
  static const String shippingAddress = "Shipping Address";
  static const String paymentMethod = "Payment Method";
  static const String shippingAddressNotSelectedMessage = "Please select a shipping address.";
  static const String changeButtonText = "Change";
  static const String selectedAddressId = "selectedAddress";
  static const String couponCodeHint = "Have a Promo Code? Enter here";

  //FreshPay Order Review
  static const String tradingFor = "Trading for";

  //Seller Order Details
  static const String sellerOrderDetailsTitle = "Order Details";
  static const String acceptOrder = "Accept Order";
  static const String declineOrder = "Decline Order";
  static const String markCompleted = "Mark Completed";
}