import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/data/model/complaint_model.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/data/model/suggestion_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/data/network/requests.dart';

import '../../data/model/chat_model.dart';
import '../../data/model/order_model.dart';
import '../../data/model/rate_model.dart';
import '../../data/model/user_model.dart';

abstract class Repository {
  Future<Either<Failure, UserModel>> register (RegisterRequest registerRequest);
  Future<Either<Failure, bool>> login (LoginRequest registerRequest);
  Future<Either<Failure, UserModel>> getProfile ();
  Future<Either<Failure, UserModel>> updateProfile (UserModel userModel);
  Future<Either<Failure, void>> ratingTeacher (RateModel rate);
  Future<Either<Failure,List<RateModel>>>? getRatingTeacher(String teacherId);
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> getProfileStream();
  Future<Either<Failure, String>> uploadFileToFirebase (String collection , String name,File file);
  Future<Either<Failure, PostModel>> createPost  (PostModel post);
  Future<Either<Failure,List<PostModel>?>> getAllUserPosts(String uid);
  Future<Either<Failure,void>> resetPassword(String newPassword);
  Future<Either<Failure,void>> forgetPassword(String email);
  Future<Either<Failure,void>> addCreditCard(CardModel cardModel);
  Future<Either<Failure,List<CardModel>?>> getAllCards();
  Future<Either<Failure,void>> addSuggestion(SuggestionModel suggestionModel);
  Future<Either<Failure,void>>  deletePost(PostModel postModel);
  Future<Either<Failure,void>>  updatePost(PostModel postModel);
  Future<Either<Failure,void>>  sharePost(PostModel postModel);
  Future<Either<Failure,List<UserModel>?>>  getAllUsers();
  Future<Either<Failure,bool>>  postIsLiked(String postId);
  Future<Either<Failure,void>>  addComment(PostModel post, CommentModel comment);
  Future<Either<Failure, List<Map<String,dynamic>>?>>  getComments(PostModel post);
  Future<Either<Failure,void>>  addLovePost(PostModel post);
  Future<Either<Failure,void>>  removeLovePost(PostModel post);
  Future<Either<Failure,List<PostModel>?>>  getAllLovePosts();
  Future<Either<Failure,bool?>> checkIsLogin();
  Future<Either<Failure,void>>  followUser(String userId);
  Future<Either<Failure,void>>  addCertificates(String certificate , String certificateName);
  Future<Either<Failure,void>>  unfollowUser(String userId);
  Future<Either<Failure,void>>  blockUser(String userId);
  Future<Either<Failure,void>>  unblockUser(String userId);
  Future<Either<Failure,List<UserModel>>>  getListOfUsers(List<String> users);
  Future<Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>?>> chat(String antherId);
  Future<Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>?>> unSeen(String antherId);
  Future<Either<Failure,Stream<DocumentSnapshot<Map<String, dynamic>>>?>> lastMessage(String antherId);
  Future<Either<Failure,Stream<DocumentSnapshot<Map<String, dynamic>>>?>> listToPost(PostModel postModel);
  Future<Either<Failure, Future<void>>> sendMessage(ChatModel chatModel ,  String antherId);
  Future<Either<Failure, Future<void>>> cleanUnSeenMessages(String antherId);
  Future<Either<Failure,void>>  pay(OrderModel orderModel);
  Future<Either<Failure,List<OrderModel>>>  getAllPayOperations();
  Future<Either<Failure,List<OrderModel>>>  getAllOrders();
  Future<Either<Failure,List<OrderModel>>>  getTeacherOrders(DateTime date);
  Future<Either<Failure,List<String>>>  getListOfChatUsersUnFollow();
  Future<Either<Failure,void>>  logout();
  //---------- admin -------------------------
  Future<Either<Failure,List<ComplaintModel>?>>  getAllComplaints();
  Future<Either<Failure,void>>  addShop(ShopModel shopModel);
  Future<Either<Failure,List<ShopModel>?>>  getAllShops();
  Future<Either<Failure,void>>  deleteShop(ShopModel shopModel);
  Future<Either<Failure,List<UserModel>?>>  getAllTeacher();
  Future<Either<Failure,void>>addActionToTeacher(UserModel teacher);


}