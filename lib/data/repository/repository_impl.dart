import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rababa/data/data_source/local_data_source.dart';
import 'package:rababa/data/model/card_model.dart';
import 'package:rababa/data/model/chat_model.dart';
import 'package:rababa/data/model/complaint_model.dart';
import 'package:rababa/data/model/order_model.dart';
import 'package:rababa/data/model/post_model.dart';
import 'package:rababa/data/model/shop_model.dart';
import 'package:rababa/data/model/suggestion_model.dart';
import 'package:rababa/data/model/user_model.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/data/network/requests.dart';
import 'package:rababa/domain/repository/repository.dart';
import '../data_source/remote_data_source.dart';
import '../model/rate_model.dart';
import '../network/error_handler.dart';
import '../network/network_info.dart';

class RepositoryImpl implements Repository {
  final RemoteDataSource _remoteDataSource;
  final LocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  RepositoryImpl(this._networkInfo , this._remoteDataSource , this._localDataSource);

  @override
  Future<Either<Failure, UserModel>> register(RegisterRequest registerRequest)async {


    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.register(registerRequest);

        if (response.uid != null ) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
               ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> login(LoginRequest loginRequest) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.login(loginRequest);

        if (response) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> getProfile() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getProfile();

        if (response.uid!=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> updateProfile(userModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.updateProfile(userModel);

        if (response.uid!=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, String>> uploadFileToFirebase(String collection , String name,File file) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.uploadFileToFirebase(collection,name,file);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, PostModel>> createPost(PostModel post)async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.createNewPost(post);

        if (response!.id !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>?>> getAllUserPosts(String uid)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllUserPosts(uid);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String newPassword)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
     var response =  await _remoteDataSource.resetPassword(newPassword);
       return Right(response);

      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> forgetPassword(String email)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        var response =  await _remoteDataSource.forgetPassword(email);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCreditCard(CardModel cardModel)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        var response =  await _remoteDataSource.addCreditCard(cardModel);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<CardModel>?>> getAllCards()async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllCards();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addSuggestion(SuggestionModel suggestionModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.addSuggestion(suggestionModel);
          return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deletePost(PostModel postModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.deletePost(postModel);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> sharePost(PostModel postModel) {
    // TODO: implement sharePost
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> updatePost(PostModel postModel)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.updatePost(postModel);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>?>> getAllUsers() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllUsers();

        response?.forEach((element) {
          print(element.name) ;
        });

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> postIsLiked(String postId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.postIsLiked(postId);
          return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addComment(PostModel post, CommentModel comment) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.addComment(post,comment);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addLovePost(PostModel post)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.addLovePost(post);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> removeLovePost(PostModel post) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.removeLovePost(post);
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<PostModel>?>> getAllLovePosts()async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllLovePosts();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> logout() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.logout();
          return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
 //------------------ admin --------------------------
  @override
  Future<Either<Failure, List<ComplaintModel>?>> getAllComplaints() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllComplaint();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addShop(ShopModel shopModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.addShop(shopModel);

          return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<ShopModel>?>> getAllShops() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllShops();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteShop(ShopModel shopModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.deleteShop(shopModel);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, bool?>> checkIsLogin() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _localDataSource.checkIsLogin();
        if(response!) {
          await getProfile();
        }
        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> followUser(String userId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.followUser(userId);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unfollowUser(String userId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.unFollowUser(userId);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>?>> getAllTeacher() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllTeacher();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addActionToTeacher(UserModel teacher) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.addActionToTeacher(teacher);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<Map<String,dynamic>>?>> getComments(PostModel post)async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getAllComments(post.id!);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> blockUser(String userId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.blockUser(userId);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> unblockUser(String userId)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.unblockUser(userId);

        return Right(response);
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<UserModel>>> getListOfUsers(List<String> users)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response =await _remoteDataSource.getListOfUsers(users);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure,Stream<QuerySnapshot<Map<String, dynamic>>>?>> chat(String antherId)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.chat(antherId);

        if (response !=null) {
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Future<void>>> sendMessage(ChatModel chatModel, String antherId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.sendMessage(chatModel,antherId);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> pay(OrderModel orderModel) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.pay(orderModel);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllOrders()async {

    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getAllOrders();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addCertificates(String certificate , String certificateName) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.addCertificates(certificate, certificateName);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getAllPayOperations() async{

    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getAllPayOperations();

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<OrderModel>>> getTeacherOrders(DateTime date) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getTeacherOrders(date);

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>?>> lastMessage(String antherId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.lastMessage(antherId);

        if (response !=null) {
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<QuerySnapshot<Map<String, dynamic>>>?>> unSeen(String antherId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.unSeen(antherId);

        if (response !=null) {
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Future<void>>> cleanUnSeenMessages(String antherId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.cleanUnSeen(antherId) ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>>> getProfileStream() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.getProfileStream() ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, void>> ratingTeacher(RateModel rate) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = _remoteDataSource.ratingTeacher(rate) ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<RateModel>>>? getRatingTeacher(String teacherId) async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getRatingTeacher(teacherId) ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, List<String>>> getListOfChatUsersUnFollow() async{
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.getListOfChatUsersUnFollow() ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

  @override
  Future<Either<Failure, Stream<DocumentSnapshot<Map<String, dynamic>>>?>> listToPost(PostModel postModel)async {
    if (await _networkInfo.isConnected) {
      // its connected to internet, its safe to call API
      try {
        final response = await _remoteDataSource.listenToPost(postModel) ;

        if (response !=null) {
          // success
          // return either right
          // return data
          return Right(response);
        } else {
          // failure --return business error
          // return either left
          return Left(Failure(ApiInternalStatus.FAILURE.toString(),
              ResponseMessage.DEFAULT));
        }
      } catch (error) {
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return internet connection error
      // return either left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }

}