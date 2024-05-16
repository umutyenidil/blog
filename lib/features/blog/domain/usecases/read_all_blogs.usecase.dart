import 'package:blog/core/error/failures.dart';
import 'package:blog/core/usecase/usecase.dart';
import 'package:blog/features/blog/domain/entities/blog.entity.dart';
import 'package:blog/features/blog/domain/repositories/blog.repository.dart';
import 'package:fpdart/fpdart.dart';

class ReadAllBlogsUseCase implements UseCase<List<BlogEntity>, NoParams> {
  final BlogRepository _blogRepository;

  ReadAllBlogsUseCase(
    BlogRepository blogRepository,
  ) : _blogRepository = blogRepository;

  @override
  Future<Either<Failure, List<BlogEntity>>> call(NoParams params) async {
    return await _blogRepository.readAll();
  }
}
