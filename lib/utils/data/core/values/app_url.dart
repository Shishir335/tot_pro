class ApiURL {
  ApiURL._();

  ///------------- testing url --------
  static const String globalUrl1 = '';
  static const String baseApiUrl1 = '';

  ///-------------- live url -----------
  static const String globalUrl = 'https://www.totpro.net/';
  static const String baseApiUrl = 'https://www.totpro.net/api/';
  static const String categoryImageUrl =
      'https://www.totpro.net/images/category/';

  ///---------- Authentication  url path -----
  static const String loginUrl = '${baseApiUrl}login';
  static const String registerUrl = '${baseApiUrl}register';
  static const String updateProfileUrl = '${baseApiUrl}user-profile-update';
  static const String changePasswordUrl = '${baseApiUrl}password-change';
  static const String userDetailsUrl = '${baseApiUrl}user-details';

  /// ------------- Address ----------------
  static const String addressIndexUrl = '${baseApiUrl}additional-addresses';
  static const String createAddressUrl = '${baseApiUrl}additional-addresses';
  static const String addressUpdateByIdUrl =
      '${baseApiUrl}additional-addresses/1';

  ///------------ Work --------------
  static const String postEdgeSubmitWorkUrl = '${baseApiUrl}work';
  static const String updateEdgeSubmitWorkByIdUrl = '${baseApiUrl}work/';
  static const String getEdgeWorksUrl = '${baseApiUrl}works';
  static const String getEdgeWorkDetailsUrl = '${baseApiUrl}works/';
  static const String getCompleteWorkDetailsUrl =
      '${baseApiUrl}completed-work/';
  static const String getInvoiceUrl = '${baseApiUrl}work/invoice/';
  static const String getTransactionsUrl = '${baseApiUrl}work/transactions/';
  static const String deleteWorkByIdUrl = '${baseApiUrl}work/';

  /// payments
  static const String paymentUrl = '${baseApiUrl}all-transaction';
  static const String paypalPaymentStoreURl = '${baseApiUrl}paypal-payment';
  static const String accountDeleteThenLogoutUrl =
      '${baseApiUrl}check-available-user/'; // id

  ///------------- Request call -----------------------
  static const String requestCallUrl = '${baseApiUrl}call-back';

  /// account delete request
  static const String accountDeleteReqUrl =
      '${baseApiUrl}account-delete-request';

  static const String review = '${baseApiUrl}review';
  static const String category = '${baseApiUrl}get-category';
  static const String contactUs = '${baseApiUrl}contact-us';
  static const String quote = '${baseApiUrl}request-quote';
  static const String joinUs = '${baseApiUrl}join-us';
}
