import 'package:tot_pro/screens/account_delete_request/bindings/account_delete_request_binding.dart';
import 'package:tot_pro/screens/account_delete_request/views/account_delete_request_view.dart';
import 'package:tot_pro/screens/category/bindings/edge_submit_binding.dart';
import 'package:tot_pro/screens/category/views/category.dart';
import 'package:tot_pro/screens/change_password/bindings/dashboard_binding.dart';
import 'package:tot_pro/screens/change_password/views/change_password_view.dart';
import 'package:tot_pro/screens/contact_us/bindings/contact_us_binding.dart';
import 'package:tot_pro/screens/contact_us/views/contact_us.dart';
import 'package:tot_pro/screens/dashboard/bindings/dashboard_binding.dart';
import 'package:tot_pro/screens/dashboard/views/dashboard_view.dart';
import 'package:tot_pro/screens/face_id/views/face_id_view.dart';
import 'package:tot_pro/screens/invoice/bindings/invoice_binding.dart';
import 'package:tot_pro/screens/invoice/views/invoice_view.dart';
import 'package:tot_pro/screens/job_history/bindings/job_history_binding.dart';
import 'package:tot_pro/screens/job_history/views/job_history_view.dart';
import 'package:tot_pro/screens/job_hsitory_details/bindings/job_history_details_binding.dart';
import 'package:tot_pro/screens/job_hsitory_details/views/job_history_details_view.dart';
import 'package:tot_pro/screens/join_us/bindings/join_binding.dart';
import 'package:tot_pro/screens/join_us/views/join.dart';
import 'package:tot_pro/screens/login/bindings/dashboard_binding.dart';
import 'package:tot_pro/screens/login/views/login_view.dart';
import 'package:tot_pro/screens/payment_transaction/bindings/payment_transaction_binding.dart';
import 'package:tot_pro/screens/payment_transaction/views/payment_transction_view.dart';
import 'package:tot_pro/screens/quote/bindings/quote_binding.dart';
import 'package:tot_pro/screens/quote/views/quote.dart';
import 'package:tot_pro/screens/register/bindings/register_binding.dart';
import 'package:tot_pro/screens/register/views/register_view.dart';
import 'package:tot_pro/screens/request_call/views/request_call_view.dart';
import 'package:tot_pro/screens/review/bindings/review_binding.dart';
import 'package:tot_pro/screens/review/views/review.dart';
import 'package:tot_pro/screens/settings/bindings/settings_binding.dart';
import 'package:tot_pro/screens/settings/views/settings_view.dart';
import 'package:tot_pro/screens/splash_screen/bindings/splash_screen_binding.dart';
import 'package:tot_pro/screens/splash_screen/views/splash_screen_view.dart';
import 'package:tot_pro/screens/transaction/views/transction_view.dart';
import 'package:tot_pro/screens/user_profile/bindings/user_profile_binding.dart';
import 'package:tot_pro/screens/user_profile/views/user_profile_view.dart';
import 'package:tot_pro/screens/work_complete_details/views/work_complete_details_view.dart';
import '../../main.dart';
import '../../screens/face_id/bindings/face_id_binding.dart';
import '../../screens/home/bindings/edge_submit_binding.dart';
import '../../screens/home/views/submit_edge_view.dart';
import '../../screens/transaction/bindings/transaction_binding.dart';
import '../../screens/work_complete_details/bindings/work_complete_details_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  //static const INITIAL = Routes.SPLASH;
  // static const INITIAL = localStoreSRF.getString('token')? Routes.LOGIN;

  static String INITIAL = localStoreSRF.getString('token') != null
      ? localStoreSRF.getBool('isFaceId') == true
          ? Routes.faceIdAuth
          : Routes.DASHBOARD
      : Routes.LOGIN;

  static final routes = [
    GetPage(
        name: _Paths.SPLASH,
        page: () => const SplashScreendView(),
        binding: SplashScreenBinding()),
    GetPage(
      name: _Paths.HOME,
      page: () => const SubmitEdgeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.DASHBOARD,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),

    ///--------------
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: _Paths.REGISTER,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: _Paths.CHANGEPASSWORD,
      page: () => const ChangePasswordView(),
      binding: ChangePasswordBinding(),
    ),
    GetPage(
      name: _Paths.USERPROFILE,
      page: () => const UserProfileView(),
      binding: UserProfileBinding(),
    ),
    GetPage(
      name: _Paths.JOBHISTORY,
      page: () => const JobHistoryView(),
      binding: JobHistoryBinding(),
    ),
    GetPage(
      name: _Paths.JOBHISTORYDETAILS,
      page: () => const JobHistoryDetailsView(),
      binding: JobHistoryDetailsBinding(),
    ),
    GetPage(
      name: _Paths.REQUESTCALL,
      page: () => const RequestCallView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENTTRANSACTION,
      page: () => const PaymentTransactionView(),
      binding: PaymentTransactBinding(),
    ),

    GetPage(
      name: _Paths.Transaction,
      page: () => const TransactionView(),
      binding: TransactBinding(),
    ),

    GetPage(
      name: _Paths.Invoice,
      page: () => const InvoiceView(),
      binding: InvoiceBinding(),
    ),
    GetPage(
      name: _Paths.accountDeleteRequest,
      page: () => const AccountDeleteRequestView(),
      binding: AccountDeleteRequestBinding(),
    ),

    GetPage(
      name: _Paths.workCompleteDetails,
      page: () => const WorkCompleteDetailsView(),
      binding: WorkCompleteDetailsBinding(),
    ),

    GetPage(
      name: _Paths.faceIdAuth,
      page: () => const FaceIdAuthView(),
      binding: FaceIdAuthBinding(),
    ),

    /// settings
    GetPage(
      name: _Paths.settings,
      page: () => const SettingsView(),
      binding: SettingsBinding(),
    ),

    GetPage(
        name: _Paths.category,
        page: () => const CategoryView(),
        binding: CategoryBinding()),

    GetPage(
        name: _Paths.review,
        page: () => const ReviewView(),
        binding: ReviewBinding()),

    GetPage(
        name: _Paths.joinUs,
        page: () => const JoinUsView(),
        binding: JoinUsBinding()),

    GetPage(
        name: _Paths.quote,
        page: () => const QuoteView(),
        binding: QuoteBinding()),

    GetPage(
        name: _Paths.contactUs,
        page: () => const ContactUsView(),
        binding: ContactUsBinding()),

    GetPage(
        name: _Paths.category,
        page: () => const CategoryView(),
        binding: CategoryBinding()),

    //faceIdAuth
  ];
}
