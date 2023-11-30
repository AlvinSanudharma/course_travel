import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:course_travel/features/destination/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllDestinationUsecase {
  final DestinationRepository _destinationRepository;

  GetAllDestinationUsecase(this._destinationRepository);

  Future<Either<Failure, List<DestinationEntity>>> call() {
    return _destinationRepository.all();
  }
}
