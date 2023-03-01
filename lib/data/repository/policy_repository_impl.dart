import 'package:bookand/domain/model/policy_model.dart';
import 'package:bookand/domain/repository/policy_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../datasource/policy/policy_remote_data_source.dart';
import '../datasource/policy/policy_remote_data_source_impl.dart';

part 'policy_repository_impl.g.dart';

@riverpod
PolicyRepository policyRepository(PolicyRepositoryRef ref) {
  final policyRemoteDataSource = ref.read(policyRemoteDataSourceProvider);

  return PolicyRepositoryImpl(policyRemoteDataSource);
}

class PolicyRepositoryImpl implements PolicyRepository {
  final PolicyRemoteDataSource policyRemoteDataSource;

  PolicyRepositoryImpl(this.policyRemoteDataSource);

  @override
  Future<PolicyModel> getPolicy(String policyName) async {
    final policyModel = await policyRemoteDataSource.getPolicy(policyName);

    return PolicyModel.convertUtf8(model: policyModel);
  }
}