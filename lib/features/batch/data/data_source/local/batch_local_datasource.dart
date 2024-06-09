import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_management_starter/core/failure/failure.dart';
import 'package:student_management_starter/core/networking/local/hive_service.dart';
import 'package:student_management_starter/features/batch/data/model/batch_hive_model.dart';
import 'package:student_management_starter/features/batch/domain/entity/batch_entity.dart';

final batchLocalDataSourceProvider = Provider((ref)=> 
BatchLocalDataSource(
  hiveService: ref.read(hiveServiceProvider), 
  batchHiveModel: ref.read(batchHiveModelProvider)) );

class BatchLocalDataSource{
  final HiveService hiveService;
  final BatchHiveModel batchHiveModel;

  BatchLocalDataSource({
    required this.hiveService,
    required this.batchHiveModel
  });

  //Add batch
  Future<Either<Failure, bool>> addBatch(BatchEntity batch) async{
    try{

      //Convert entity to hive object
      final hiveBatch =batchHiveModel.fromEntity(batch);
      await hiveService.addBatch(hiveBatch);
      return const Right(true);
    }catch(e){
      return Left(Failure(error: e.toString()));
      
    }
  }

  //Get all batches
  Future<Either<Failure,List<BatchEntity>>> getAllBatches() async{
    try{
      // get all batches fron hive
      final hiveBatches= await hiveService.getAllBatches();
      
      //Convert hive list to entity list
      // As the database returns BatchHiveModel
      final batches= batchHiveModel.toEntityList(hiveBatches);
      return Right(batches);
          }catch(e){
            return Left(Failure(error: e.toString()));
          }
  }
}