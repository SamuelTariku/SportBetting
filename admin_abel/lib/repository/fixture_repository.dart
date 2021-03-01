import 'package:meta/meta.dart';
import '../models/fixture.dart';
import '../data_provider/fixture_data.dart';

class FixtureRepository {
  final FixtureDataProvider dataProvider;

  FixtureRepository({@required this.dataProvider})
      : assert(dataProvider != null);

  Future<Fixture> createFixture(Fixture fix) async {
    return await dataProvider.createFixture(fix);
  }

  Future<List<Fixture>> getFixture() async {
    return await dataProvider.getFixtures();
  }

  Future<void> updateFixture(Fixture fix) async {
    await dataProvider.updateFixture(fix);
  }

  Future<void> deleteFixture(String id) async {
    await dataProvider.deleteFixture(id);
  }
}
