import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class UploadFileToFirebaseUseCase extends BaseUseCase <UploadFileToFirebaseUseCaseInput , String?>{
  final Repository repository ;

  UploadFileToFirebaseUseCase(this.repository);

  @override
  Future<Either<Failure, String?>> execute(UploadFileToFirebaseUseCaseInput input) async{
  return await repository.uploadFileToFirebase(input.collection, input.name ,input.file) ;
  }
}

class UploadFileToFirebaseUseCaseInput {
 File file ;
 String collection ;
 String name ;
 UploadFileToFirebaseUseCaseInput(this.file, this.collection, this.name);
}