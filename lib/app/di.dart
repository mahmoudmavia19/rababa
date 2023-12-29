import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/data_source/local_data_source.dart';
import 'package:rababa/data/data_source/remote_data_source.dart';
import 'package:rababa/data/network/network_info.dart';
import 'package:rababa/data/repository/repository_impl.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/add_comment.dart';
import 'package:rababa/domain/usecase/add_credit_card_usecase.dart';
import 'package:rababa/domain/usecase/add_suggestion_usecase.dart';
import 'package:rababa/domain/usecase/admin_usecases/add_action_to_teacher_usecase.dart';
import 'package:rababa/domain/usecase/admin_usecases/admin_add_shop_usecase.dart';
import 'package:rababa/domain/usecase/admin_usecases/delete_shop_usecase.dart';
import 'package:rababa/domain/usecase/block_user_usecase.dart';
import 'package:rababa/domain/usecase/check_login_usecase.dart';
import 'package:rababa/domain/usecase/create_post_usecase.dart';
import 'package:rababa/domain/usecase/delete_post_usecase.dart';
import 'package:rababa/domain/usecase/follow_user_usecase.dart';
import 'package:rababa/domain/usecase/getAllTeacher.dart';
import 'package:rababa/domain/usecase/get_all_cards.dart';
import 'package:rababa/domain/usecase/chat_usecases/get_all_chat_usecase.dart';
import 'package:rababa/domain/usecase/get_all_love_posts_usecase.dart';
import 'package:rababa/domain/usecase/get_all_orders.dart';
import 'package:rababa/domain/usecase/get_all_pay_operations_usecase.dart';
import 'package:rababa/domain/usecase/get_all_user_posts_usecase.dart';
import 'package:rababa/domain/usecase/get_all_users_usecase.dart';
import 'package:rababa/domain/usecase/get_comments_usecase.dart';
import 'package:rababa/domain/usecase/get_list_of_users_usecase.dart';
import 'package:rababa/domain/usecase/get_profile_usecase.dart';
import 'package:rababa/domain/usecase/list_to_post_usease.dart';
import 'package:rababa/domain/usecase/login_usecase.dart';
import 'package:rababa/domain/usecase/register_usecase.dart';
import 'package:rababa/domain/usecase/reset_password_usecase.dart';
import 'package:rababa/domain/usecase/update_profile_usercase.dart';
import 'package:rababa/domain/usecase/upload_img_usecase.dart';
import 'package:rababa/presentation/screens/admin/main/view_model/main_view_model.dart';
import 'package:rababa/presentation/screens/admin/pay/view_model/admin_pay_view_model.dart';
import 'package:rababa/presentation/screens/admin/teacher/view_model/teacher_view_model.dart';
import 'package:rababa/presentation/screens/authentication/forget_password_screen/view_model/forget_password_view_model.dart';
import 'package:rababa/presentation/screens/authentication/login/view_model/login_view_model.dart';
import 'package:rababa/presentation/screens/authentication/register/view_model/register_view_model.dart';
import 'package:rababa/presentation/screens/authentication/reset_password_screen/view_model/reset_password_view_model.dart';
import 'package:rababa/presentation/screens/student/add_comment/view_model/add_comment_view_model.dart';
import 'package:rababa/presentation/screens/student/add_credit_card/view_model/add_credit_card_view_model.dart';
import 'package:rababa/presentation/screens/student/add_suggestion_screen/view_model/add_suggestion_view_model.dart';
import 'package:rababa/presentation/screens/student/chat/view_model/chat_view_model.dart';
import 'package:rababa/presentation/screens/student/create_post_screen/view_model/create_post_view_model.dart';
import 'package:rababa/presentation/screens/student/group_item/groups_view_model/view_model/group_view_model.dart';
import 'package:rababa/presentation/screens/student/group_item/shops_view_model/view_model/view_model.dart';
import 'package:rababa/presentation/screens/student/main_screen/view_model/main_view_model.dart';
import 'package:rababa/presentation/screens/student/pay/view_model/pay_view_model.dart';
import 'package:rababa/presentation/screens/student/profile_screen/view_model/student_profile_view_model.dart';
import 'package:rababa/presentation/screens/student/show_added_card_screen/view_model/show_added_card_view_model.dart';
import 'package:rababa/presentation/screens/student/show_all_teacher/view_model/show_teacher_view_model.dart';
import 'package:rababa/presentation/screens/student/show_users/view_model/show_users_view_model.dart';
import 'package:rababa/presentation/screens/student/update_profile_screen/view_model/update_profile_view_model.dart';
import 'package:rababa/presentation/screens/student/view_user_posts/view_model/view_users_posts_view_model.dart';

import '../domain/usecase/add_certificate_usecase.dart';
import '../domain/usecase/admin_usecases/get_all_complaint_usecase.dart';
import '../domain/usecase/admin_usecases/get_all_shops_usecase.dart';
import '../domain/usecase/chat_usecases/clean_unseen_usecase.dart';
import '../domain/usecase/chat_usecases/last_message.dart';
import '../domain/usecase/chat_usecases/send_message_usecase.dart';
import '../domain/usecase/chat_usecases/unseen_usecase.dart';
import '../domain/usecase/forget_password_usecase.dart';
import '../domain/usecase/get_chat_users_unfollow_usecase.dart';
import '../domain/usecase/get_rating_teacher_usecase.dart';
import '../domain/usecase/get_teacher_orders_usecase.dart';
import '../domain/usecase/pay_usecase.dart';
import '../domain/usecase/rating_teacher_usecase.dart';
import '../presentation/screens/admin/complaint_screen/view_model/complaint_view_model.dart';
import '../presentation/screens/admin/shops/view_model/shops_view_model.dart';
import '../presentation/screens/student/live/view_model/rate_view_model.dart';
import '../presentation/screens/student/student_courses/view_model/courses_view_model.dart';
import '../presentation/screens/teacher/course_dates/view_model/courses_dates_view_model.dart';
import '../presentation/screens/teacher/teacher_certificate/view_model/teacher_certificate_view_model.dart';
import '../presentation/screens/teacher/teacher_main_screen/view_model/Teacher_main_view_model.dart';
import '../presentation/screens/teacher/teahcer_profile/view_model/teacher_prfile_view_model.dart';
import '../presentation/splach/view_model/splach_view_model.dart';

final instance = GetIt.instance;

Future<void> initAppModule() async {
  // app module, its a module where we put all generic dependencies

  // network info
  instance.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(InternetConnectionChecker()));

  //app service client
  final firebaseAuth = FirebaseAuth.instance;
  firebaseAuth.setLanguageCode(AppConstant.ar);

  instance.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  instance.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  instance
      .registerLazySingleton<FirebaseStorage>(() => FirebaseStorage.instance);

  // remote data source
  instance.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
      instance<FirebaseFirestore>(),
      instance<FirebaseAuth>(),
      instance<FirebaseStorage>()));
  // local data source
  instance.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
      instance<FirebaseAuth>(),));

  // repository

  instance.registerLazySingleton<Repository>(
      () => RepositoryImpl(instance(), instance(), instance()));


  instance.registerLazySingleton<MainViewModel>(() => MainViewModel());
  instance.registerFactory<CheckLoginUseCase>(() => CheckLoginUseCase(instance()));
  instance.registerFactory<SplashViewModel>(() => SplashViewModel(instance()));
}

initRegisterModule() {
  if (!GetIt.I.isRegistered<RegisterUseCase>()) {
     instance
        .registerFactory<RegisterUseCase>(() => RegisterUseCase(instance()));
    instance.registerFactory<RegisterViewModel>(
        () => RegisterViewModel(instance(),instance()));
  }
}

initLoginModule() {
  if (!GetIt.I.isRegistered<LoginUseCase>()) {
    instance.registerFactory<LoginUseCase>(() => LoginUseCase(instance()));
    instance.registerFactory<LoginViewModel>(() => LoginViewModel(instance()));
  }
}

initStudentProfileModule() {
  if (!GetIt.I.isRegistered<GetProfileUseCase>()) {
    instance.registerFactory<GetProfileUseCase>(
        () => GetProfileUseCase(instance()));
    instance.registerFactory<GetAllUserPostsUseCase>(
        () => GetAllUserPostsUseCase(instance()));
    instance.registerFactory<DeletePostUseCase>(
            () => DeletePostUseCase(instance()));
    instance.registerFactory<GetAllLovePostsUseCase>(
            () => GetAllLovePostsUseCase(instance()));
    instance.registerFactory<FollowUseCase>(
            () => FollowUseCase(instance()));
    instance.registerFactory<GetAllChatUseCase>(
            () => GetAllChatUseCase(instance()));
    instance.registerFactory<GetCommentsUseCase>(
            () => GetCommentsUseCase(instance()));
    instance.registerFactory<StudentShopsViewModel>(
            () => StudentShopsViewModel(instance(),));
    instance.registerFactory<ShowUsersViewModel>(
            () => ShowUsersViewModel(instance(),));
    instance.registerFactory<GetListOfUsersUseCase>(
            () => GetListOfUsersUseCase(instance(),));
    instance.registerFactory<BlockUserUseCase>(
            () => BlockUserUseCase(instance()));
    instance.registerFactory<PayUseCase>(
            () => PayUseCase(instance()));
    instance.registerFactory<PayViewModel>(() => PayViewModel(instance()));
    instance.registerFactory<ShowAllTeachersViewModel>(
            () => ShowAllTeachersViewModel(instance(),instance(),));
    instance.registerFactory<SendMessageUseCase>(
            () => SendMessageUseCase(instance())) ;
    instance.registerFactory<UnSeenUseCase>(
            () => UnSeenUseCase(instance()));
    instance.registerFactory<LastMessageUseCase>(
            () => LastMessageUseCase(instance()));
    instance.registerFactory<CleanUnSeenUseCase>(
            () => CleanUnSeenUseCase(instance()));
    instance.registerFactory<RatingTeacherUseCase>(
            () => RatingTeacherUseCase(instance()));
    instance.registerFactory<RateViewModel>(
            () => RateViewModel(instance(),instance(),));
    instance.registerFactory<GetRatingTeacherUseCase>(
            () => GetRatingTeacherUseCase(instance()));
    instance.registerFactory<GetChatUsersUnfollowUseCase>(
            () => GetChatUsersUnfollowUseCase(instance()));

    instance.registerFactory<ChatViewModel>(
            () => ChatViewModel(instance(),instance(),instance(),instance(),instance(),instance(),instance(),));
    instance.registerFactory<GetAllOrdersUseCase>(
            () => GetAllOrdersUseCase(instance()));
    instance.registerFactory<StudentCoursesViewModel>(
            () => StudentCoursesViewModel(instance()));
    instance.registerFactory<StudentProfileViewModel>(
        () => StudentProfileViewModel(instance(),instance(),instance(),instance(),instance(),instance()));
  }
}

initUpdateProfileModule() {
  if (!GetIt.I.isRegistered<UpdateProfileUseCase>()) {
    instance.registerFactory<UpdateProfileUseCase>(
        () => UpdateProfileUseCase(instance()));
    if (!GetIt.I.isRegistered<UploadFileToFirebaseUseCase>()) {
      instance.registerFactory<UploadFileToFirebaseUseCase>(
          () => UploadFileToFirebaseUseCase(instance()));
    }
    instance.registerFactory<UpdateProfileViewModel>(
        () => UpdateProfileViewModel(instance(), instance()));
  }
}

initCreatePostModule() {
  if (!GetIt.I.isRegistered<CreatePostUseCase>()) {
    instance.registerFactory<CreatePostUseCase>(
        () => CreatePostUseCase(instance()));
    if (!GetIt.I.isRegistered<UploadFileToFirebaseUseCase>()) {
      instance.registerFactory<UploadFileToFirebaseUseCase>(
          () => UploadFileToFirebaseUseCase(instance()));
    }
    instance.registerFactory<CreatePostViewModel>(
        () => CreatePostViewModel(instance(), instance()));
  }
}

initResetPasswordModule() {
  if (!GetIt.I.isRegistered<ResetPasswordUseCase>()) {
    instance.registerFactory<ResetPasswordUseCase>(
        () => ResetPasswordUseCase(instance()));
    instance.registerFactory<ResetPasswordViewModel>(
        () => ResetPasswordViewModel(instance(),instance(),));
  }
}

initForgetPasswordModule() {
  if (!GetIt.I.isRegistered<ForgetPasswordUseCase>()) {
    instance.registerFactory<ForgetPasswordUseCase>(
        () => ForgetPasswordUseCase(instance()));
    instance.registerFactory<ForgetPasswordViewModel>(
        () => ForgetPasswordViewModel(instance()));
  }
}

initAddCreditCardModule() {
  if (!GetIt.I.isRegistered<AddCreditCardUseCase>()) {
    instance.registerFactory<AddCreditCardUseCase>(
        () => AddCreditCardUseCase(instance()));
    instance.registerFactory<AddCreditCardViewModel>(
        () => AddCreditCardViewModel(instance()));
  }
}

initAddSuggestionModule() {
  if (!GetIt.I.isRegistered<AddSuggestionUseCase>()) {
    instance.registerFactory<AddSuggestionUseCase>(
        () => AddSuggestionUseCase(instance()));
    instance.registerFactory<AddSuggestionViewModel>(
        () => AddSuggestionViewModel(instance()));
  }
}

initGetAllUsersModule() {
  if (!GetIt.I.isRegistered<GetAllUsersUseCase>()) {
    instance.registerFactory<GetAllUsersUseCase>(
            () => GetAllUsersUseCase(instance()));
    instance.registerFactory<GroupViewModel>(
            () => GroupViewModel(instance()));
  }
}

initShowCreditCardModule() {
  if (!GetIt.I.isRegistered<GetAllCardsUseCase>()) {
    instance.registerFactory<GetAllCardsUseCase>(
            () => GetAllCardsUseCase(instance()));
    instance.registerFactory<ShowAddCardViewModel>(
            () => ShowAddCardViewModel(instance()));
  }
}

initUserPostsModule() {
  if (!GetIt.I.isRegistered<ViewUsersPostsViewModel>()) {
    instance.registerLazySingleton<ViewUsersPostsViewModel>(
            () => ViewUsersPostsViewModel(instance()));
    instance.registerFactory<AddCommentUseCase>(
            () => AddCommentUseCase(instance()));
    instance.registerFactory<ListToPostUseCase>(
            () => ListToPostUseCase(instance()));
    instance.registerLazySingleton<AddCommentViewModel>(
            () => AddCommentViewModel(instance(),instance(),));
  }
}

initAdmin() {
  if (!GetIt.I.isRegistered<AdminComplaintViewModel>()) {
    instance.registerFactory<AdminComplaintViewModel>(
            () => AdminComplaintViewModel(instance()));
    instance.registerFactory<GetAllComplaintUseCase>(
            () => GetAllComplaintUseCase(instance()));
    instance.registerFactory<AdminAddShopUseCase>(
            () => AdminAddShopUseCase(instance()));
    instance.registerFactory<GetAllShopsUseCase>(
            () => GetAllShopsUseCase(instance()));
    instance.registerFactory<DeleteShopUseCase>(
            () => DeleteShopUseCase(instance()));
    instance.registerFactory<GetAllPayOperationsUseCase>(
            () => GetAllPayOperationsUseCase(instance()));
    instance.registerFactory<AdminPayOperationsViewModel>(
            () => AdminPayOperationsViewModel(instance()));
    instance.registerFactory<ShopsViewModel>(
            () => ShopsViewModel(instance(), instance(), instance()));
    instance.registerFactory<GetAllTeacherUseCase>(
            () => GetAllTeacherUseCase(instance()));
    instance.registerFactory<AddActionToTeacherUseCase>(
            () => AddActionToTeacherUseCase(instance()));
    instance.registerLazySingleton<AdminMainViewModel>(
            () => AdminMainViewModel());
    instance.registerLazySingleton<TeacherViewModel>(
            () => TeacherViewModel(instance(),instance()));

  }
}

initTeacher(){
  if (!GetIt.I.isRegistered<TeacherMainViewModel>()) {
    instance.registerFactory<TeacherMainViewModel>(
            () => TeacherMainViewModel());
    instance.registerFactory<TeacherMainProfileViewModel>(
            () => TeacherMainProfileViewModel(instance(),instance(),instance(),instance(),instance(),instance(),instance(),));
    instance.registerFactory<TeacherCertificateViewModel>(
            () => TeacherCertificateViewModel(instance(),instance(),));
    instance.registerFactory<AddCertificateUseCase>(
            () => AddCertificateUseCase(instance(),));
    instance.registerFactory<GetTeacherOrdersUseCase>(
            () => GetTeacherOrdersUseCase(instance(),));
    instance.registerFactory<CoursesDatesViewModel>(
            () => CoursesDatesViewModel(instance(),instance(),));
  }
}


unRegister(){
/*  instance.unregister<ViewUsersPostsViewModel>() ;
  instance.unregister<AddCommentUseCase>() ;
  instance.unregister<AddCommentViewModel>() ;*/
}