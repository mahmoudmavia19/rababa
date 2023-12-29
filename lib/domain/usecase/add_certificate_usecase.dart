import 'package:dartz/dartz.dart';
import 'package:rababa/data/network/failure.dart';
import 'package:rababa/domain/repository/repository.dart';
import 'package:rababa/domain/usecase/base_usecase.dart';

class AddCertificateUseCase extends BaseUseCase<AddCertificateUseCaseInput,void>{
  Repository repository ;

  AddCertificateUseCase(this.repository);

  @override
  Future<Either<Failure, void>> execute(AddCertificateUseCaseInput input)async{
    return await repository.addCertificates(input.certificate! , input.certificateName!);
  }

}

class AddCertificateUseCaseInput {
   String? certificate;
   String? certificateName ;

  AddCertificateUseCaseInput(this.certificate, this.certificateName);
}