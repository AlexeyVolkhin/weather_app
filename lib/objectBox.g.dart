
import 'dart:typed_data';
import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart';
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';
import 'db/city.dart';
export 'package:objectbox/objectbox.dart';

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 318883982518674037),
      name: 'CityEntity',
      lastPropertyId: const IdUid(16, 6019053447483962919),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 179663221696235288),
            name: 'id',
            type: 6,
            flags: 129),
        ModelProperty(
            id: const IdUid(2, 5416781204498138619),
            name: 'name',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8321317441675615059),
            name: 'state',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 1316182952356664509),
            name: 'country',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1505587545443170069),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3018622985994835665),
            name: 'lon',
            type: 8,
            flags: 0),
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),

];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(4, 6229057951852675813),
      lastIndexId: const IdUid(0, 0),
      lastRelationId: const IdUid(0, 0),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [6001187027007566646],
      retiredIndexUids: const [],
      retiredPropertyUids: const [
        1516147636710660767,
        3582852047068830588,
        2877085064915294179
      ],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    CityEntity: EntityDefinition<CityEntity>(
        model: _entities[0],
        toOneRelations: (CityEntity object) => [],
        toManyRelations: (CityEntity object) => {},
        getId: (CityEntity object) => object.id,
        setId: (CityEntity object, int id) {
          object.id = id;
        },
        objectToFB: (CityEntity object, fb.Builder fbb) {
          final nameOffset = fbb.writeString(object.name);
          final stateOffset = fbb.writeString(object.state);
          final countryOffset = fbb.writeString(object.country);
          fbb.startTable(7);
          fbb.addInt64(0, object.id);
          fbb.addOffset(1, nameOffset);
          fbb.addOffset(2, stateOffset);
          fbb.addOffset(3, countryOffset);
          fbb.addFloat64(4, object.lat);
          fbb.addFloat64(5, object.lon);
          fbb.finish(fbb.endTable());
          return object.id;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = CityEntity()
            ..id = const fb.Int64Reader().vTableGet(buffer, rootOffset, 4, 0)
            ..name = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 6, '')
            ..state = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 8, '')
            ..country = const fb.StringReader(asciiOptimization: true)
                .vTableGet(buffer, rootOffset, 10, '')
            ..lat =
                const fb.Float64Reader().vTableGet(buffer, rootOffset, 12, 0)
            ..lon =
                const fb.Float64Reader().vTableGet(buffer, rootOffset, 14, 0);

          return object;
        }),

  };

  return ModelDefinition(model, bindings);
}

/// [CityEntity] entity fields to define ObjectBox queries.
class CityEntity_ {
  /// see [MapEntity.id]
  static final id = QueryIntegerProperty<CityEntity>(_entities[0].properties[0]);

  /// see [MapEntity.name]
  static final name =
      QueryStringProperty<CityEntity>(_entities[0].properties[1]);

  /// see [MapEntity.state]
  static final state =
      QueryIntegerProperty<CityEntity>(_entities[0].properties[2]);

  /// see [MapEntity.country]
  static final country =
      QueryStringProperty<CityEntity>(_entities[0].properties[3]);

  /// see [MapEntity.lat]
  static final lat =
      QueryBooleanProperty<CityEntity>(_entities[0].properties[4]);

  /// see [MapEntity.lon]
  static final lon =
      QueryBooleanProperty<CityEntity>(_entities[0].properties[5]);
}
