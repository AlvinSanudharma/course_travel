// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:io';

import 'package:course_travel/core/error/exceptions.dart';
import 'package:dartz/dartz.dart';

import 'package:course_travel/core/error/failures.dart';
import 'package:course_travel/core/platform/network_info.dart';
import 'package:course_travel/features/destination/data/datasource/destination_local_datasource.dart';
import 'package:course_travel/features/destination/data/datasource/destination_remote_datasource.dart';
import 'package:course_travel/features/destination/domain/entities/destination_entity.dart';
import 'package:course_travel/features/destination/domain/repositories/destination_repository.dart';

class DestinationRepositoryImpl implements DestinationRepository {
  final NetworkInfo networkInfo;
  final DestinationLocalDataSource localDataSource;
  final DestinationRemoteDatasource remoteDatasource;

  DestinationRepositoryImpl({
    required this.networkInfo,
    required this.localDataSource,
    required this.remoteDatasource,
  });

  @override
  Future<Either<Failure, List<DestinationEntity>>> all() async {
    bool online = await networkInfo.isConnected();

    if (online) {
      try {
        final result = await remoteDatasource.all();

        await localDataSource.cachedAll(result);

        return Right(result.map((e) => e.toEntity).toList());
      } on TimeoutException {
        return const Left(TimeoutFailure('Request Timeout'));
      } on NotFoundException {
        return const Left(NotFoundFailure('Not Found'));
      } on ServerException {
        return const Left(ServerFailure('Server Error'));
      }
    } else {
      try {
        final result = await localDataSource.getAll();

        return Right(result.map((e) => e.toEntity).toList());
      } on CachedException {
        return const Left(CachedFailure('Data is not Present'));
      }
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> search(String query) async {
    try {
      final result = await remoteDatasource.search(query);

      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(TimeoutFailure('Request Timeout'));
    } on NotFoundException {
      return const Left(NotFoundFailure('Not Found'));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the network'));
    }
  }

  @override
  Future<Either<Failure, List<DestinationEntity>>> top() async {
    try {
      final result = await remoteDatasource.top();

      return Right(result.map((e) => e.toEntity).toList());
    } on TimeoutException {
      return const Left(TimeoutFailure('Request Timeout'));
    } on NotFoundException {
      return const Left(NotFoundFailure('Not Found'));
    } on ServerException {
      return const Left(ServerFailure('Server Error'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed connect to the network'));
    }
  }
}
