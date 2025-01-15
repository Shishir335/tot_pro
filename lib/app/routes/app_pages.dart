import 'package:tot_pro/app/modules/account_delete_request/bindings/account_delete_request_binding.dart';
import 'package:tot_pro/app/modules/account_delete_request/views/account_delete_request_view.dart';
import 'package:tot_pro/app/modules/change_password/bindings/dashboard_binding.dart';
import 'package:tot_pro/app/modules/change_password/views/change_password_view.dart';
import 'package:tot_pro/app/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:tot_pro/app/modules/dashboard/views/dashboard_view.dart';
import 'package:tot_pro/app/modules/face_id/views/face_id_view.dart';
import 'package:tot_pro/app/modules/invoice/bindings/invoice_binding.dart';
import 'package:tot_pro/app/modules/invoice/views/invoice_view.dart';
import 'package:tot_pro/app/modules/job_history/bindings/job_history_binding.dart';
import 'package:tot_pro/app/modules/job_history/views/job_history_view.dart';
import 'package:tot_pro/app/modules/job_hsitory_details/bindings/job_history_details_binding.dart';
import 'package:tot_pro/app/modules/job_hsitory_details/views/job_history_details_view.dart';
import 'package:tot_pro/app/modules/login/bindings/dashboard_binding.dart';
import 'package:tot_pro/app/modules/login/views/login_view.dart';
import 'package:tot_pro/app/modules/payment_transaction/bindings/payment_transaction_binding.dart';
import 'package:tot_pro/app/modules/payment_transaction/views/payment_transction_view.dart';
import 'package:tot_pro/app/modules/register/bindings/register_binding.dart';
import 'package:tot_pro/app/modules/register/views/register_view.dart';
import 'package:tot_pro/app/modules/request_call/views/request_call_view.dart';
import 'package:tot_pro/app/modules/settings/bindings/settings_binding.dart';
import 'package:tot_pro/app/modules/settings/views/settings_view.dart';
import 'package:tot_pro/app/modules/splash_screen/bindings/splash_screen_binding.dart';
import 'package:tot_pro/app/modules/splash_screen/views/splash_screen_view.dart';
import 'package:tot_pro/app/modules/transaction/views/transction_view.dart';
import 'package:tot_pro/app/modules/user_profile/bindings/user_profile_binding.dart';
import 'package:tot_pro/app/modules/user_profile/views/user_profile_view.dart';
import 'package:tot_pro/app/modules/work_complete_details/views/work_complete_details_view.dart';
import '../../main.dart';
import '../modules/face_id/bindings/face_id_binding.dart';
import '../modules/home/bindings/edge_submit_binding.dart';
import '../modules/home/views/submit_edge_view.dart';
import '../modules/transaction/bindings/transaction_binding.dart';
import '../modules/work_complete_details/bindings/work_complete_details_binding.dart';

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
      page: () => SubmitEdgeView(),
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

    //faceIdAuth
  ];
}
