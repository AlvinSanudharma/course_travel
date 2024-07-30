import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:course_travel/features/destination/domain/repositories/destination_repository.dart';
import 'package:dartz/dartz.dart';

class SearchDestinationUsecase {
  final DestinationRepository _destinationRepository;

  SearchDestinationUsecase(this._destinationRepository);

  Future<Either<Failure, List<DestinationEntity>>> call(String query) {
    return _destinationRepository.search(query);
  }
}
