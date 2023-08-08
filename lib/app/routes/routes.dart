import 'package:get/get.dart';
import 'package:smarter/app/global/bindings/edit_delivery_address_binding.dart';
import 'package:smarter/app/global/screens/full_screen_image.dart';
import 'package:smarter/app/global/screens/loading_screen.dart';
import 'package:smarter/app/modules/auth_module/bindings/auth_binding.dart';
import 'package:smarter/app/modules/auth_module/bindings/check_code_binding.dart';
import 'package:smarter/app/modules/auth_module/bindings/find_password_binding.dart';
import 'package:smarter/app/modules/auth_module/bindings/new_password_binding.dart';
import 'package:smarter/app/modules/auth_module/bindings/register_binding.dart';
import 'package:smarter/app/modules/auth_module/screens/auth_screen.dart';
import 'package:smarter/app/modules/auth_module/screens/check_code_screen.dart';
import 'package:smarter/app/modules/auth_module/screens/find_password_screen.dart';
import 'package:smarter/app/modules/auth_module/screens/new_password_screen.dart';
import 'package:smarter/app/modules/auth_module/screens/not_active_screen.dart';
import 'package:smarter/app/modules/auth_module/screens/register_screen.dart';
import 'package:smarter/app/modules/gym/class_payment_module/bindings/class_payment_detail_controller.dart';
import 'package:smarter/app/modules/gym/class_payment_module/screens/class_payment_detail_screen.dart';
import 'package:smarter/app/modules/gym/gym_class_module/bindings/edit_class_binding.dart';
import 'package:smarter/app/modules/gym/gym_class_module/screens/edit_class_screen.dart';
import 'package:smarter/app/modules/gym/gym_class_module/screens/gym_class_screen.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/bindings/create_notification_binding.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/bindings/modify_notification_binding.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/screens/create_notification_screen.dart';
import 'package:smarter/app/modules/gym/gym_notification_module/screens/modify_notification_screen.dart';
import 'package:smarter/app/modules/gym/home_module/bindings/gym_home_binding.dart';
import 'package:smarter/app/modules/gym/home_module/screens/gym_home_screen.dart';
import 'package:smarter/app/modules/gym/level_module/bindings/edit_level_binding.dart';
import 'package:smarter/app/modules/gym/level_module/screens/edit_level_screen.dart';
import 'package:smarter/app/modules/gym/level_module/screens/level_system_screen.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/attendance_binding.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/attendance_key_pad_binding.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/audition_detail_binding.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/audition_master_binding.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/create_audition_binding.dart';
import 'package:smarter/app/modules/gym/student_module/bindings/edit_studnet_binding.dart';
import 'package:smarter/app/modules/gym/student_module/screens/attendance_class_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/attendance_detail_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/attendance_key_pad_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/attendance_master_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/audition_detail_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/audition_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/create_audition_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/edit_student_screen.dart';
import 'package:smarter/app/modules/gym/student_module/screens/other_attendance_screen.dart';
import 'package:smarter/app/modules/my_page_module/bindings/change_binding.dart';
import 'package:smarter/app/modules/my_page_module/bindings/claim_binding.dart';
import 'package:smarter/app/modules/my_page_module/bindings/edit_my_info_binding.dart';
import 'package:smarter/app/modules/my_page_module/bindings/return_binding.dart';
import 'package:smarter/app/modules/my_page_module/screens/address_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/change_delivery_address_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/change_password_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/change_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/easy_order_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/edit_address_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/edit_delivery_address_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/edit_my_info_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/faq_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/my_coupons_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/my_drafts_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/order_and_delivery_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/order_detail_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/return_screen.dart';
import 'package:smarter/app/modules/my_page_module/screens/samrter_money_screen.dart';
import 'package:smarter/app/modules/notification_module/screens/notification_screen.dart';
import 'package:smarter/app/modules/shop/home_module/bindings/home_binding.dart';
import 'package:smarter/app/modules/shop/home_module/screens/shop_home_screen.dart';
import 'package:smarter/app/modules/shop/order_module/order_bindings/order_binding.dart';
import 'package:smarter/app/modules/shop/order_module/screens/order_screen.dart';
import 'package:smarter/app/modules/shop/product_module/bindings/product_binding.dart';
import 'package:smarter/app/modules/shop/product_module/screens/product_screen.dart';
import 'package:smarter/app/modules/shop/product_module/screens/search_product_screen.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/bindings/charge_binding.dart';
import 'package:smarter/app/modules/shop/smarter_money_module/screens/charge_screen.dart';

import '../modules/my_page_module/bindings/address_binding.dart';
import '../modules/my_page_module/bindings/change_password_binding.dart';

class Routes {
  static const String shop = '/shop';
  static const String shopHome = '/shop/home';
  static const String shopShopping = '/shop/shopping';
  static const String shopQuickOrder = '/shop/quickOrder';
  static const String shopMyPage = '/shop/myPage';

  static const String gym = '/gym';
  static const String gymHome = '/gym/home';
  static const String gymStudent = '/gym/student';
  static const String gymFee = '/gym/fee';
  static const String gymNotice = '/gym/notice';
  static const String gymCalendar = '/gym/calendar';
  static const String gymMyPage = '/gym/myPage';

  static const String auth = '/auth';
  static const String register = '/auth/register';
  static const String loading = '/loading';
  static const String product = '/product';
  static const String notification = '/notification';
  static const String myCoupons = '/myCoupons';
  static const String orderAndDelivery = '/order-and-delivery';
  static const String orderDetail = '/order-detail';
  static const String editMyInfo = '/edit-my-info';
  static const String smarterMoney = '/smarter-money';
  static const String searchProducts = '/search';
  static const String payment = '/payment';
  static const String returnProduct = '/return';
  static const String changeProduct = '/change';
  static const String order = '/order';
  static const String charge = '/charge';
  static const String faq = '/faq';
  static const String fullScreenImage = '/fullScreenImage';
  static const String address = '/address';
  static const String editAddress = '/editAddress';
  static const String notActive = '/notActive';
  static const String changePassword = '/changePassword';
  static const String easyOrders = '/easyOrder';
  static const String gymClass = '/gymClass';
  static const String levelSystem = '/levelSystem';
  static const String student = '/student';
  static const String createAudition = '/createAudition';
  static const String auditionDetail = '/audition';
  static const String audition = '/auditionMaster';
  static const String attendance = '/attendance';
  static const String attendanceMaster = '/attendanceMaster';
  static const String attendanceDetail = '/attendanceDetail';
  static const String otherAttendance = '/otherAttendance';
  static const String createNotification = '/createNotification';
  static const String modifyNotification = '/modifyNotification';
  static const String classPaymentDetail = '/classPaymentDetail';
  static const String attendanceKeyPad = '/attendanceKeyPad';
  static const String findPassword = '/findPassword';
  static const String checkCode = '/checkCode';
  static const String newPassword = '/newPassword';
  static const String changeDeliveryAddress = '/changeDeliveryAddress';
  static const String editDeliveryAddress = '/editDeliveryAddress';
  static const String myDrafts = '/myDrafts';
  static const String shopSpeedOrder = '/shop/speedOrder';

  static const _defaultTransition = Transition.cupertino;
  static const _duration = Duration(milliseconds: 500);

  static final getPages = [
    GetPage(
      name: changeProduct,
      page: () => const ChangeScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: ChangeBinding(),
    ),
    GetPage(
      name: returnProduct,
      page: () => const ReturnScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: ReturnBinding(),
    ),
    GetPage(
      name: auth,
      page: () => const AuthScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: AuthBinding(),
    ),
    GetPage(
      name: loading,
      page: () => const LoadingScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: shop,
      page: () => const ShopHomeScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: HomeBinding(),
    ),
    GetPage(
      name: notification,
      page: () => const NotificationScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: orderAndDelivery,
      page: () => const OrderAndDeliveryScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$product/:id',
      page: () => const ProductScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: ProductBinding(),
    ),
    GetPage(
      name: '$orderDetail/:id',
      page: () => const OrderDetailScreen(),
      transition: _defaultTransition,
      binding: ClaimBinding(),
      transitionDuration: _duration,
    ),
    GetPage(
      name: editMyInfo,
      page: () => const EditMyInfoScreen(),
      transition: _defaultTransition,
      binding: EditMyInfoBinding(),
      transitionDuration: _duration,
    ),
    GetPage(
      name: smarterMoney,
      page: () => const SmarterMoneyScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: register,
      page: () => const RegisterScreen(),
      binding: RegisterBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: searchProducts,
      page: () => const SearchProductScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$order/:id',
      page: () => const OrderScreen(),
      binding: OrderBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: charge,
      page: () => const ChargeScreen(),
      binding: ChargeBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: faq,
      page: () => const FaqScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: fullScreenImage,
      page: () => const FullImageScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: address,
      page: () => const AddressScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: editAddress,
      page: () => const EditAddressScreen(),
      transition: _defaultTransition,
      binding: AddressBinding(),
      transitionDuration: _duration,
    ),
    GetPage(
      name: notActive,
      page: () => const NotActiveScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: changePassword,
      page: () => const ChangePasswordScreen(),
      binding: ChangePasswordBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: easyOrders,
      page: () => const EasyOrderScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: gym,
      page: () => const GymHomeScreen(),
      transition: _defaultTransition,
      binding: GymHomeBinding(),
      transitionDuration: _duration,
    ),
    GetPage(
      name: gymClass,
      page: () => const GymClassScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$gymClass/:id',
      page: () => const EditClassScreen(),
      binding: EditClassBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: levelSystem,
      page: () => const LevelSystemScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$levelSystem/:id',
      page: () => const EditLevelScreen(),
      binding: EditLevelBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$student/:id',
      page: () => const EditStudentScreen(),
      binding: EditStudentBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: createAudition,
      page: () => const CreateAuditionScreen(),
      binding: CreateAuditionBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$auditionDetail/:id',
      page: () => const AuditionDetailScreen(),
      binding: AuditionDetailBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: audition,
      page: () => const AuditionScreen(),
      binding: AuditionMasterBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: attendance,
      page: () => const AttendanceClassScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$attendanceMaster/:id',
      page: () => const AttendanceMasterScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$attendanceDetail/:id',
      page: () => const AttendanceDetailScreen(),
      binding: AttendanceBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: otherAttendance,
      page: () => const OtherAttendanceScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: createNotification,
      page: () => const CreateNotificationScreen(),
      binding: CreateNotificationBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: modifyNotification,
      page: () => const ModifyNotificationScreen(),
      binding: ModifyNotificationBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: '$classPaymentDetail/:id',
      page: () => const ClassPaymentDetailScreen(),
      transition: _defaultTransition,
      binding: ClassPaymentDetailBinding(),
      transitionDuration: _duration,
    ),
    GetPage(
      name: attendanceKeyPad,
      page: () => const AttendanceKeyPadScreen(),
      binding: AttendanceKeyPadBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: findPassword,
      page: () => const FindPasswordScreen(),
      binding: FindPasswordBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: checkCode,
      page: () => const CheckCodeScreen(),
      binding: CheckCodeBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: newPassword,
      page: () => const NewPasswordScreen(),
      binding: NewPasswordBinding(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: myCoupons,
      page: () => const MyCouponsScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: changeDeliveryAddress,
      page: () => const ChangeDeliveryAddressScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
    GetPage(
      name: editDeliveryAddress,
      page: () => const EditDeliveryAddressScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
      binding: EditDeliveryAddressBinding(),
    ),
    GetPage(
      name: myDrafts,
      page: () => const MyDraftsScreen(),
      transition: _defaultTransition,
      transitionDuration: _duration,
    ),
  ];
}
