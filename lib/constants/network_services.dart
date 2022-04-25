// ignore_for_file: constant_identifier_names

const String BaseUrl = "https://tours.eastus.cloudapp.azure.com/";
const String Register = 'api/Auth/register';
const String Login = 'api/Auth/Login';
const String VIewMoreCategories = 'api/Categories/GetCategories';
const String GetCategoriesInCity = 'api/Categories/GetCategoriesInCity';
const String GetPlaceInDetails = 'api/Places/GetPlace';
const String GetTopPlacesInCategoryInHome =
    BaseUrl + 'api/Places/GetTopPlacesInCategory';
const String GetRecommendedPlacesInHome = 'api/Places/GetRecommendedPlaces';
const String GetCities = 'api/Cities/GetCities';
const String GetGovernorates = 'api/Cities/GetGovernorates';
const String GetPlaceReviews = 'api/Reviews/GetPlaceReviews';
const String PostReview = 'api/Reviews/PostReview';
const String RESET_PASS_TOKEN = BaseUrl + "api/Auth/ResetPasswordToken";
const String RESET_PASS = BaseUrl + "api/Auth/ResetPassword";
const String CHANGE_PASS = BaseUrl + "api/Auth/ChangePassword";
const String GetTopCategories = BaseUrl + "api/Categories/GetTopCategories";
const String GetCitySearch = BaseUrl + "api/Cities/GetPlacesCities";
const String AddToFavourite = BaseUrl + "api/Places/SavePlace";
const String RemoveFromFavourite = BaseUrl + "api/Places/UnsavePlace";
const String EDIT_USER_PROFILE = BaseUrl + "api/Client/EditProfile";
const String SEARCH_DATA = BaseUrl + "api/Places/SearchPlaces";
