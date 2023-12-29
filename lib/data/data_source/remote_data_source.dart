import 'package:json_annotation/json_annotation.dart';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:firebase_storage/firebase_storage.dart';
import 'package:intl/intl.dart';
import 'package:rababa/app/end_points/constant.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/data/model/complaint_model.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/rate_model.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/data/model/suggestion_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/presentation/common/freezed_data_classes.dart';

import '../model/chat_model.dart';
import '../model/order_model.dart';
@JsonSerializable(explicitToJson: true)
 abstract class RemoteDataSource {
  Future<UserModel> register(RegisterRequest registerRequest);
  Future<bool> login(LoginRequest loginRequest);
  Future<UserModel> updateProfile(UserModel userModel);
  Future<UserModel> getProfile();
  Stream<DocumentSnapshot<Map<String, dynamic>>>? getProfileStream();
  Future<UserModel> getUser(String uid);
  Future<String?> uploadFileToFirebase(String collection , String name,File file);
  Future<PostModel?> createNewPost(PostModel post);
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> listenToPost(PostModel post);
  Future<List<PostModel>?> getAllUserPosts(String uid);
  Future<void> resetPassword(String newPassword);
  Future<void> forgetPassword(String email);
  Future<void>  addCreditCard(CardModel cardModel);
  Future<List<CardModel>?>  getAllCards();
  Future<void>  addSuggestion(SuggestionModel suggestionModel);
  Future<void>  deletePost(PostModel postModel);
  Future<void>  updatePost(PostModel postModel);
  Future<void>  addToLovePost(PostModel postModel);
  Future<void>  removeFromLovePost(PostModel postModel);
  Future<void>  sharePost(PostModel postModel);
  Future<List<UserModel>?>  getAllUsers();
  Future<bool>  postIsLiked(String postId);
  Future<void>  addComment(PostModel post,CommentModel comment);
  Future<List<Map<String,dynamic>>?> getAllComments(String postId);
  Future<void> addLovePost(PostModel post);
  Future<void> removeLovePost(PostModel post);
  Future<List<PostModel>?> getAllLovePosts();
  Future<void> followUser(String userId);
  Future<void> unFollowUser(String userId);
  Future<void>? ratingTeacher(RateModel rate);
  Future<List<RateModel>>? getRatingTeacher(String teacherId);
  Future<void>? addCertificates(String certificate , String certificateName);
  Future<void> unblockUser(String userId);
  Future<void> blockUser(String userId);
  Future<List<UserModel>?> getListOfUsers(List<String> users);
  Stream<QuerySnapshot<Map<String, dynamic>>>? chat(String antherId);
  Stream<QuerySnapshot<Map<String, dynamic>>>? unSeen(String antherId);
  Stream<DocumentSnapshot<Map<String, dynamic>>>? lastMessage(String antherId);
  Future<void>? sendMessage(ChatModel chatModel ,  String antherId);
  Future<void>? cleanUnSeen(String antherId);
  Future<void>? pay(OrderModel orderModel);
  Future<List<OrderModel>>? getAllPayOperations();
  Future<List<OrderModel>>? getAllOrders();
  Future<List<OrderModel>>? getTeacherOrders(DateTime date);
  Future<List<String>>? getListOfChatUsersUnFollow();
  Future<void> logout();

  // ------------------- admin ------------------------
  Future<List<ComplaintModel>?> getAllComplaint ();
  Future<void> addShop (ShopModel shopModel);
  Future<List<ShopModel>?> getAllShops ();
  Future<void> deleteShop (ShopModel shopModel);
  Future<List<UserModel>?> getAllTeacher();
  Future<void> addActionToTeacher(UserModel teacher);

}

class RemoteDataSourceImpl implements RemoteDataSource {
  final FirebaseFirestore _firebaseFirestore;
  final FirebaseStorage _firebaseStorage ;
  final FirebaseAuth _auth ;

  RemoteDataSourceImpl(this._firebaseFirestore , this._auth , this._firebaseStorage);
  @override
  Future<UserModel> register(RegisterRequest registerRequest) async{
    final result =  await _auth.createUserWithEmailAndPassword(
        email: registerRequest.email,
        password: registerRequest.password);
    final user =  UserModel(registerRequest.userName, registerRequest.userName,
        registerRequest.email , '', result.user!.uid , [], [],[],AppConstant.userType.userString()) ;
    result.user!.sendEmailVerification();
    final result1 = await updateProfile(user);
    AppConstant.userObject =  UserObject(
        result1.name,
        result1.username ,
        result1.email ,
        result1.bio ,
        result1.imgUrl ,
        result1.uid ,
        result1.userType ,
        result1.musicInstrument ,
        result1. likes ,
        result1. followers ,
        result1. following ,
        result1.country ,
        result1.certificate ,
        result1.certificates ,
        result1.isAccepted  ,
        result1.isBlocked ,
        result1.blockers ,
        result1. price ,
        result1. rate
    ) ;
    return user ;
  }
  @override
  Future<UserModel> updateProfile(UserModel userModel) async {
   await _firebaseFirestore.collection(AppConstant.users).doc(userModel.uid)
        .set(userModel.toJson());
     return userModel;
  }

  @override
  Future<bool> login(LoginRequest loginRequest) async{
    final result =  await _auth.signInWithEmailAndPassword(email: loginRequest.email, password: loginRequest.password) ;
    print(result.user!.emailVerified);
    final result1 = await getProfile();
    AppConstant.userObject =  UserObject(
        result1.name,
        result1.username ,
        result1.email ,
        result1.bio ,
        result1.imgUrl ,
        result1.uid ,
        result1.userType ,
        result1.musicInstrument ,
        result1. likes ,
        result1. followers ,
        result1. following ,
        result1.country ,
        result1.certificate ,
        result1.certificates ,
        result1.isAccepted  ,
        result1.isBlocked ,
        result1.blockers ,
        result1. price ,
        result1. rate
    ) ;
    AppConstant.userType =  AppConstant.userObject!.userType!.userType();
    return result.user?.uid!=null && result1.isBlocked!=true;
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>> getProfileStream()  {
    return _firebaseFirestore.collection(AppConstant.users).doc(_auth.currentUser!.uid).snapshots();

  }
  @override
  Future<UserModel> getProfile() async{
    var result1 = UserModel.fromJson((await _firebaseFirestore.collection(AppConstant.users).doc(_auth.currentUser!.uid).get()).data()) ;
    AppConstant.userObject =  UserObject(
        result1.name,
        result1.username ,
        result1.email ,
        result1.bio ,
        result1.imgUrl ,
        result1.uid ,
        result1.userType ,
        result1.musicInstrument ,
        result1. likes ,
        result1. followers ,
        result1. following ,
        result1.country ,
        result1.certificate ,
        result1.certificates ,
        result1.isAccepted  ,
        result1.isBlocked ,
        result1.blockers ,
        result1. price ,
        result1. rate
    ) ;
    AppConstant.userType =  AppConstant.userObject!.userType!.userType();
    return result1 ;
  }

  @override
  Future<String?> uploadFileToFirebase(String collection , String name,File file)async{
    final result = await _firebaseStorage.ref().child('$collection/$name').putFile(file) ;
    return await result.ref.getDownloadURL();
  }

  @override
  Future<PostModel?> createNewPost(PostModel post) async{
     var result0 = await _firebaseFirestore.collection(AppConstant.posts).add(post.toJson());
     post.id = result0.id ;
     await _firebaseFirestore.collection(AppConstant.posts).doc(result0.id).set(post.toJson());
     return post ; 
  }

  @override
  Future<List<PostModel>?> getAllUserPosts(String uid) async{
    var result0 = await _firebaseFirestore.collection(AppConstant.posts)
        .where(AppConstant.author,isEqualTo: uid).get();
     return result0.docs.map((e) => PostModel.fromJson(e.data())).toList();
   }
  @override
  Future<void> resetPassword(String newPassword)async {
   await _auth.currentUser!.updatePassword(newPassword) ;
  }

  @override
  Future<void> forgetPassword(String email) async{
   await _auth.sendPasswordResetEmail(email: email);
  }

  @override
  Future<void> addCreditCard(CardModel cardModel) async{
    await _firebaseFirestore.collection(AppConstant.users).doc(_auth.currentUser!.uid).collection(AppConstant.cards)
        .doc(cardModel.cardNumber).set(cardModel.toJson());
  }

  @override
  Future<List<CardModel>?> getAllCards() async{
    var result =  await _firebaseFirestore.collection(AppConstant.users).doc(_auth.currentUser!.uid).collection(AppConstant.cards).get() ;
    return result.docs.map((e) => CardModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> addSuggestion(SuggestionModel suggestionModel)async {
     var result = await _firebaseFirestore.collection(AppConstant.suggestions).add(suggestionModel.toJson());
     suggestionModel.id  = result.id;  
     await  _firebaseFirestore.collection(AppConstant.suggestions).doc(result.id).set(suggestionModel.toJson());
  }

  @override
  Future<void> deletePost(PostModel postModel) async{
   await _firebaseFirestore.collection(AppConstant.posts).doc(postModel.id).delete();
   await _firebaseStorage.ref('${AppConstant.posts}/${postModel.fileName}').delete();
   await _firebaseStorage.ref('${AppConstant.postsStacker}/${postModel.fileName}').delete();
  }

  @override
  Future<void> sharePost(PostModel postModel) {
    // TODO: implement sharePost
    throw UnimplementedError();
  }

  @override
  Future<void> updatePost(PostModel postModel) async{
    await _firebaseFirestore.collection(AppConstant.posts).doc(postModel.id).set(postModel.toJson());
  }

  @override
  Future<List<UserModel>> getAllUsers() async{
    var result =  await _firebaseFirestore.collection(AppConstant.users).where(AppConstant.uid,isNotEqualTo: _auth.currentUser!.uid)
        .where('isBlocked',isEqualTo: false).get();

    for(var i in  result.docs)
      {
        print('all User : ${i.data()}') ;
      }
    return result.docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> addToLovePost(PostModel postModel) {
    // TODO: implement addToLovePost
    throw UnimplementedError();
  }

  @override
  Future<void> removeFromLovePost(PostModel postModel) {
    // TODO: implement removeFromLovePost
    throw UnimplementedError();
  }

  @override
  Future<bool> postIsLiked(String postId)async {
   var result =  PostModel.fromJson(( await _firebaseFirestore.collection(AppConstant.posts).doc(postId).get()).data()!);
     for (var element in result.likes) {
       if(element==AppConstant.userObject!.uid)
         {
           return true ;
         }
     }
     return false ;
  }

  @override
  Future<void> addComment(PostModel post, CommentModel comment) async{
   var result = await _firebaseFirestore.collection(AppConstant.posts).doc(post.id).collection(AppConstant.comments).add(comment.toJson());
   comment.id = result.id;
   post.comments!.add(comment.id!);
   await _firebaseFirestore.collection(AppConstant.posts).doc(post.id).set(post.toJson());
   await _firebaseFirestore.collection(AppConstant.posts).doc(post.id).collection(AppConstant.comments).doc(comment.id).set(comment.toJson());
  }

  @override
  Future<List<Map<String,dynamic>>?> getAllComments(String postId) async{
    List<Map<String,dynamic>> listMap = [] ;
    var result = await _firebaseFirestore.collection(AppConstant.posts).doc(postId).collection(AppConstant.comments).orderBy('date').get();
    if(result.docs.isNotEmpty) {
      for(var item in result.docs){
        CommentModel commentModel = CommentModel.fromJson(item.data());
       UserModel user =  await getUser(commentModel.userId!);
       listMap.add({
         commentModel.id!: commentModel ,
         user.uid!: user
       });
    }
    }
    return listMap;
  }

  @override
  Future<void> addLovePost(PostModel post) async{
 // _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).collection(AppConstant.lovePosts).doc(post.id).set(post.toJson());
     _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
       AppConstant.likes : FieldValue.arrayUnion([post.id])
     });
     _firebaseFirestore.collection(AppConstant.posts).doc(post.id).update({
       AppConstant.likes : FieldValue.arrayUnion([AppConstant.userObject!.uid])
     });

  }

  @override
  Future<void> removeLovePost(PostModel post) async{
   // _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).collection(AppConstant.lovePosts).doc(post.id).delete();
    _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
    AppConstant.likes : FieldValue.arrayRemove([post.id])
    });
    _firebaseFirestore.collection(AppConstant.posts).doc(post.id).update({
      AppConstant.likes : FieldValue.arrayRemove([AppConstant.userObject!.uid])
    });
  }

  @override
  Future<List<PostModel>?> getAllLovePosts() async{
    List<PostModel> posts = [] ;
    for(var e in AppConstant.userObject!.likes!){
      var postResponse = await _firebaseFirestore.collection(AppConstant.posts).doc(e).get();
      if(postResponse.exists)
        {
          posts.add(PostModel.fromJson(postResponse.data()!));
        }
      else
        {
          _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
            AppConstant.likes : FieldValue.arrayRemove([e])
          });
        }
    }
    return posts;
  }

  @override
  Future<void> logout() async{
   await _auth.signOut();
   AppConstant.userObject = null;
  }
  @override
  Future<void> followUser(String userId)async{
    await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
      AppConstant.following : FieldValue.arrayUnion([userId])
    });
    await _firebaseFirestore.collection(AppConstant.users).doc(userId).update({
      AppConstant.followers : FieldValue.arrayUnion([AppConstant.userObject!.uid])
    });
  }

  @override
  Future<void> unFollowUser(String userId) async {
    try {
    await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
      AppConstant.following : FieldValue.arrayRemove([userId])
    });

      await _firebaseFirestore.collection(AppConstant.users).doc(userId).update(
          {
            AppConstant.followers: FieldValue.arrayRemove(
                [AppConstant.userObject!.uid])
          });
    }catch(error){
      print(error) ;
    }
  }

  @override
  Future<void> unblockUser(String userId)async {
    await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
      AppConstant.blockers : FieldValue.arrayRemove([userId])
    });
   }
   @override
  Future<void> blockUser(String userId) async{
    await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
       AppConstant.blockers : FieldValue.arrayUnion([userId])
     });
  }

  // ----------------- admin --------------------------
  @override
  Future<List<ComplaintModel>?> getAllComplaint() async{
    List<ComplaintModel> list  = [] ;
    var result =  await _firebaseFirestore.collection(AppConstant.suggestions).get();
    for (var e in result.docs){
      var returned  = ComplaintModel.fromJson(e.data());
      var res = await _firebaseFirestore.collection(AppConstant.users).doc(returned.uid).get();
      var user  = UserModel.fromJson(res.data()) ;
      returned.email = user.email ;
      returned.name = user.name ;
      print(user.name);
      list.add(returned);
    }
    return list ;
  }

  @override
  Future<void> addShop(ShopModel shopModel) async{

    int shopNumber = Random().nextInt(1000);
    while((await _firebaseFirestore.collection(AppConstant.shops).doc(shopNumber.toString()).get()).exists)
      {
        shopNumber = Random().nextInt(1000);
      }
    shopModel.id = shopNumber.toString() ;
      _firebaseFirestore.collection(AppConstant.shops).doc(shopModel.id).set(shopModel.toJson());

  }

  @override
  Future<List<ShopModel>?> getAllShops() async{
    return (await _firebaseFirestore.collection(AppConstant.shops).get()).docs.map((e) => ShopModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> deleteShop(ShopModel shopModel)async{
    await _firebaseFirestore.collection(AppConstant.shops).doc(shopModel.id).delete() ;
  }

  @override
  Future<List<UserModel>?> getAllTeacher() async{
    return (await _firebaseFirestore.collection(AppConstant.users).where('userType',isEqualTo: UserType.teach.userString()).get()).docs.map((e) => UserModel.fromJson(e.data())).toList();
  }

  @override
  Future<void> addActionToTeacher(UserModel teacher) async{
    return await _firebaseFirestore.collection(AppConstant.users).doc(teacher.uid).set(teacher.toJson());

  }

  @override
  Future<UserModel> getUser(String uid) async{
    return UserModel.fromJson(( await _firebaseFirestore.collection(AppConstant.users).doc(uid).get()).data());
  }

  @override
  Future<List<UserModel>?> getListOfUsers(List<String> users) async{
    List<UserModel>? list = [] ;
    int index = 0 ;
    for(var user in users){
      var item = (await _firebaseFirestore.collection(AppConstant.users).doc(user)
          .get()).data();
      print(item);
      list.add(UserModel.fromJson(
          item));
      index++ ;
    }
    print(list);
    return list ;
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> chat(String antherId) {
    return   _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid!).
    collection(AppConstant.messages).doc(antherId).collection(AppConstant.messages).orderBy('date').snapshots() ;
  }


  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>? unSeen(String antherId) {
    return   _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid!).
    collection(AppConstant.messages).doc(antherId).collection(AppConstant.unseen).orderBy('date').snapshots() ;
  }
  @override
  Future<void> sendMessage(ChatModel chatModel ,  String antherId) async{
    // sender
   await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).collection(AppConstant.messages)
   .doc(antherId)
   .collection(AppConstant.messages)
   .add(chatModel.toJson());
   // receiver
   await _firebaseFirestore.collection(AppConstant.users).doc(antherId).collection(AppConstant.messages)
       .doc(AppConstant.userObject!.uid)
       .collection(AppConstant.messages)
       .add(chatModel.toJson());
   // Un Seen

   await _firebaseFirestore.collection(AppConstant.users).doc(antherId).collection(AppConstant.messages)
       .doc(AppConstant.userObject!.uid)
       .collection(AppConstant.unseen)
       .add(chatModel.toJson());
   // last message
   await _firebaseFirestore.collection(AppConstant.users).doc(antherId).collection(AppConstant.messages)
       .doc(AppConstant.userObject!.uid)
       .set(chatModel.toJson());
   // last message
   await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).collection(AppConstant.messages)
       .doc(antherId)
       .set(chatModel.toJson());
  }

  @override
  Stream<DocumentSnapshot<Map<String, dynamic>>>? lastMessage(String antherId) {
    return _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid!).
    collection(AppConstant.messages).doc(antherId).snapshots() ;
  }

  @override
  Future<void>? pay(OrderModel orderModel) async{

     await _firebaseFirestore.collection(AppConstant.orders).add(orderModel.toJson()) ;


  }

  @override
  Future<List<OrderModel>>? getAllOrders()async {
    return (await _firebaseFirestore.collection(AppConstant.orders).where('studentId',isEqualTo: AppConstant.userObject!.uid).get()).docs.map((e) => OrderModel.fromJson(e.data())).toList() ;
  }

  @override
  Future<void> addCertificates(String certificate , String certificateName) async{
    print("new certificate to ${AppConstant.userObject!.uid}") ;
    await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).update({
      AppConstant.certificates_2 : FieldValue.arrayUnion([certificate])  ,
      AppConstant.certificate : certificateName,
    });
  }

  @override
  Future<List<OrderModel>>? getAllPayOperations()async {
     return (await _firebaseFirestore.collection(AppConstant.orders).get()).docs.map((e) => OrderModel.fromJson(e.data())).toList() ;
  }

  @override
  Future<List<OrderModel>>? getTeacherOrders(DateTime date)async {

     var dayStart = timestampFromDate(date);
     var dayEnd = timestampFromDate(DateTime(date.year,date.month,date.day).add(const Duration(days: 1)));
     print('start $dayStart -- end $dayEnd');
    return (await _firebaseFirestore.collection(AppConstant.orders)
        .where('teacherId',isEqualTo: AppConstant.userObject!.uid)
/*        .where('date',isGreaterThanOrEqualTo: dayStart)
*//*
        .where('date',isLessThan: dayEnd)
*/
        .get()).docs.map((e) => OrderModel.fromJson(e.data())).toList() ;

  }

  @override
  Future<void>? cleanUnSeen(String antherId) async{
       for (var element in (await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid!).
    collection(AppConstant.messages).doc(antherId).collection(AppConstant.unseen).get()).docs) {
         await element.reference.delete();
       }
  }

  @override
  Future<void> ratingTeacher(RateModel rate)async {
      await _firebaseFirestore.collection(AppConstant.users).doc(rate.teacherId).collection(AppConstant.rate).add(rate.toJson());
  }

  @override
  Future<List<RateModel>>? getRatingTeacher(String teacherId) async{
    return (await _firebaseFirestore.collection(AppConstant.users).doc(teacherId).collection(AppConstant.rate).get()).docs.map((e) => RateModel.fromJson(e.data())) .toList();
  }

  @override
  Future<List<String>>? getListOfChatUsersUnFollow() async{
    var listDocs =  (await _firebaseFirestore.collection(AppConstant.users).doc(AppConstant.userObject!.uid).collection(AppConstant.messages).get()).docs;
    List<String> ids = [] ;
    for(var item in listDocs){
      ids.add(item.id)  ;
    }
    return ids ;
  }

  @override
  Future<Stream<DocumentSnapshot<Map<String, dynamic>>>> listenToPost(PostModel post) async{
      return  _firebaseFirestore.collection(AppConstant.posts)
        .doc(post.id).snapshots();
  }


}

// Function to convert a DateTime object to a timestamp that only includes the date portion
Timestamp timestampFromDate(DateTime date) {
  final DateFormat formatter = DateFormat('yyyy-MM-dd');
  final String formatted = formatter.format(date);
  return Timestamp.fromDate(DateTime.parse(formatted));
}