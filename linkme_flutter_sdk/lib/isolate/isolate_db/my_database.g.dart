// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class Test extends DataClass implements Insertable<Test> {
  final int? id;
  final String? keyname;
  final String? keyids;
  final String? circle;
  Test({this.id, this.keyname, this.keyids, this.circle});
  factory Test.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Test(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      keyname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}keyname']),
      keyids: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}keyids']),
      circle: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}circle']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    if (!nullToAbsent || keyname != null) {
      map['keyname'] = Variable<String?>(keyname);
    }
    if (!nullToAbsent || keyids != null) {
      map['keyids'] = Variable<String?>(keyids);
    }
    if (!nullToAbsent || circle != null) {
      map['circle'] = Variable<String?>(circle);
    }
    return map;
  }

  TestCompanion toCompanion(bool nullToAbsent) {
    return TestCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      keyname: keyname == null && nullToAbsent
          ? const Value.absent()
          : Value(keyname),
      keyids:
          keyids == null && nullToAbsent ? const Value.absent() : Value(keyids),
      circle:
          circle == null && nullToAbsent ? const Value.absent() : Value(circle),
    );
  }

  factory Test.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Test(
      id: serializer.fromJson<int?>(json['id']),
      keyname: serializer.fromJson<String?>(json['keyname']),
      keyids: serializer.fromJson<String?>(json['keyids']),
      circle: serializer.fromJson<String?>(json['circle']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'keyname': serializer.toJson<String?>(keyname),
      'keyids': serializer.toJson<String?>(keyids),
      'circle': serializer.toJson<String?>(circle),
    };
  }

  Test copyWith({int? id, String? keyname, String? keyids, String? circle}) =>
      Test(
        id: id ?? this.id,
        keyname: keyname ?? this.keyname,
        keyids: keyids ?? this.keyids,
        circle: circle ?? this.circle,
      );
  @override
  String toString() {
    return (StringBuffer('Test(')
          ..write('id: $id, ')
          ..write('keyname: $keyname, ')
          ..write('keyids: $keyids, ')
          ..write('circle: $circle')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(id.hashCode,
      $mrjc(keyname.hashCode, $mrjc(keyids.hashCode, circle.hashCode))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Test &&
          other.id == this.id &&
          other.keyname == this.keyname &&
          other.keyids == this.keyids &&
          other.circle == this.circle);
}

class TestCompanion extends UpdateCompanion<Test> {
  final Value<int?> id;
  final Value<String?> keyname;
  final Value<String?> keyids;
  final Value<String?> circle;
  const TestCompanion({
    this.id = const Value.absent(),
    this.keyname = const Value.absent(),
    this.keyids = const Value.absent(),
    this.circle = const Value.absent(),
  });
  TestCompanion.insert({
    this.id = const Value.absent(),
    this.keyname = const Value.absent(),
    this.keyids = const Value.absent(),
    this.circle = const Value.absent(),
  });
  static Insertable<Test> custom({
    Expression<int?>? id,
    Expression<String?>? keyname,
    Expression<String?>? keyids,
    Expression<String?>? circle,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (keyname != null) 'keyname': keyname,
      if (keyids != null) 'keyids': keyids,
      if (circle != null) 'circle': circle,
    });
  }

  TestCompanion copyWith(
      {Value<int?>? id,
      Value<String?>? keyname,
      Value<String?>? keyids,
      Value<String?>? circle}) {
    return TestCompanion(
      id: id ?? this.id,
      keyname: keyname ?? this.keyname,
      keyids: keyids ?? this.keyids,
      circle: circle ?? this.circle,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (keyname.present) {
      map['keyname'] = Variable<String?>(keyname.value);
    }
    if (keyids.present) {
      map['keyids'] = Variable<String?>(keyids.value);
    }
    if (circle.present) {
      map['circle'] = Variable<String?>(circle.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TestCompanion(')
          ..write('id: $id, ')
          ..write('keyname: $keyname, ')
          ..write('keyids: $keyids, ')
          ..write('circle: $circle')
          ..write(')'))
        .toString();
  }
}

class TestTable extends Table with TableInfo<TestTable, Test> {
  final GeneratedDatabase _db;
  final String? _alias;
  TestTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _keynameMeta = const VerificationMeta('keyname');
  late final GeneratedColumn<String?> keyname = GeneratedColumn<String?>(
      'keyname', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _keyidsMeta = const VerificationMeta('keyids');
  late final GeneratedColumn<String?> keyids = GeneratedColumn<String?>(
      'keyids', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _circleMeta = const VerificationMeta('circle');
  late final GeneratedColumn<String?> circle = GeneratedColumn<String?>(
      'circle', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, keyname, keyids, circle];
  @override
  String get aliasedName => _alias ?? 'test';
  @override
  String get actualTableName => 'test';
  @override
  VerificationContext validateIntegrity(Insertable<Test> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('keyname')) {
      context.handle(_keynameMeta,
          keyname.isAcceptableOrUnknown(data['keyname']!, _keynameMeta));
    }
    if (data.containsKey('keyids')) {
      context.handle(_keyidsMeta,
          keyids.isAcceptableOrUnknown(data['keyids']!, _keyidsMeta));
    }
    if (data.containsKey('circle')) {
      context.handle(_circleMeta,
          circle.isAcceptableOrUnknown(data['circle']!, _circleMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Test map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Test.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  TestTable createAlias(String alias) {
    return TestTable(_db, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Store extends DataClass implements Insertable<Store> {
  final String businessUsername;
  final int? storeType;
  final String? imageUrl;
  final String? introductory;
  final String? keys;
  final String? contactMobile;
  final String? wechat;
  final String? branchesname;
  final String? openingHours;
  final String? province;
  final String? city;
  final String? area;
  final String? street;
  final String? address;
  final String? legalPerson;
  final String? legalIdentityCard;
  final String? licenseUrl;
  final String? longitude;
  final String? latitude;
  final String? businessCode;
  final String? notaryServiceUsername;
  final int createdAt;
  final int? modifyAt;
  Store(
      {required this.businessUsername,
      this.storeType,
      this.imageUrl,
      this.introductory,
      this.keys,
      this.contactMobile,
      this.wechat,
      this.branchesname,
      this.openingHours,
      this.province,
      this.city,
      this.area,
      this.street,
      this.address,
      this.legalPerson,
      this.legalIdentityCard,
      this.licenseUrl,
      this.longitude,
      this.latitude,
      this.businessCode,
      this.notaryServiceUsername,
      required this.createdAt,
      this.modifyAt});
  factory Store.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Store(
      businessUsername: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}businessUsername'])!,
      storeType: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}storeType']),
      imageUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}imageUrl']),
      introductory: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}introductory']),
      keys: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}keys']),
      contactMobile: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}contactMobile']),
      wechat: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}wechat']),
      branchesname: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}branchesname']),
      openingHours: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}openingHours']),
      province: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}province']),
      city: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}city']),
      area: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}area']),
      street: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}street']),
      address: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}address']),
      legalPerson: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}legalPerson']),
      legalIdentityCard: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}legalIdentityCard']),
      licenseUrl: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}licenseUrl']),
      longitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}longitude']),
      latitude: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}latitude']),
      businessCode: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}businessCode']),
      notaryServiceUsername: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}notaryServiceUsername']),
      createdAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdAt'])!,
      modifyAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}modifyAt']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['businessUsername'] = Variable<String>(businessUsername);
    if (!nullToAbsent || storeType != null) {
      map['storeType'] = Variable<int?>(storeType);
    }
    if (!nullToAbsent || imageUrl != null) {
      map['imageUrl'] = Variable<String?>(imageUrl);
    }
    if (!nullToAbsent || introductory != null) {
      map['introductory'] = Variable<String?>(introductory);
    }
    if (!nullToAbsent || keys != null) {
      map['keys'] = Variable<String?>(keys);
    }
    if (!nullToAbsent || contactMobile != null) {
      map['contactMobile'] = Variable<String?>(contactMobile);
    }
    if (!nullToAbsent || wechat != null) {
      map['wechat'] = Variable<String?>(wechat);
    }
    if (!nullToAbsent || branchesname != null) {
      map['branchesname'] = Variable<String?>(branchesname);
    }
    if (!nullToAbsent || openingHours != null) {
      map['openingHours'] = Variable<String?>(openingHours);
    }
    if (!nullToAbsent || province != null) {
      map['province'] = Variable<String?>(province);
    }
    if (!nullToAbsent || city != null) {
      map['city'] = Variable<String?>(city);
    }
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String?>(area);
    }
    if (!nullToAbsent || street != null) {
      map['street'] = Variable<String?>(street);
    }
    if (!nullToAbsent || address != null) {
      map['address'] = Variable<String?>(address);
    }
    if (!nullToAbsent || legalPerson != null) {
      map['legalPerson'] = Variable<String?>(legalPerson);
    }
    if (!nullToAbsent || legalIdentityCard != null) {
      map['legalIdentityCard'] = Variable<String?>(legalIdentityCard);
    }
    if (!nullToAbsent || licenseUrl != null) {
      map['licenseUrl'] = Variable<String?>(licenseUrl);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<String?>(longitude);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<String?>(latitude);
    }
    if (!nullToAbsent || businessCode != null) {
      map['businessCode'] = Variable<String?>(businessCode);
    }
    if (!nullToAbsent || notaryServiceUsername != null) {
      map['notaryServiceUsername'] = Variable<String?>(notaryServiceUsername);
    }
    map['createdAt'] = Variable<int>(createdAt);
    if (!nullToAbsent || modifyAt != null) {
      map['modifyAt'] = Variable<int?>(modifyAt);
    }
    return map;
  }

  StoresCompanion toCompanion(bool nullToAbsent) {
    return StoresCompanion(
      businessUsername: Value(businessUsername),
      storeType: storeType == null && nullToAbsent
          ? const Value.absent()
          : Value(storeType),
      imageUrl: imageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(imageUrl),
      introductory: introductory == null && nullToAbsent
          ? const Value.absent()
          : Value(introductory),
      keys: keys == null && nullToAbsent ? const Value.absent() : Value(keys),
      contactMobile: contactMobile == null && nullToAbsent
          ? const Value.absent()
          : Value(contactMobile),
      wechat:
          wechat == null && nullToAbsent ? const Value.absent() : Value(wechat),
      branchesname: branchesname == null && nullToAbsent
          ? const Value.absent()
          : Value(branchesname),
      openingHours: openingHours == null && nullToAbsent
          ? const Value.absent()
          : Value(openingHours),
      province: province == null && nullToAbsent
          ? const Value.absent()
          : Value(province),
      city: city == null && nullToAbsent ? const Value.absent() : Value(city),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      street:
          street == null && nullToAbsent ? const Value.absent() : Value(street),
      address: address == null && nullToAbsent
          ? const Value.absent()
          : Value(address),
      legalPerson: legalPerson == null && nullToAbsent
          ? const Value.absent()
          : Value(legalPerson),
      legalIdentityCard: legalIdentityCard == null && nullToAbsent
          ? const Value.absent()
          : Value(legalIdentityCard),
      licenseUrl: licenseUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(licenseUrl),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      businessCode: businessCode == null && nullToAbsent
          ? const Value.absent()
          : Value(businessCode),
      notaryServiceUsername: notaryServiceUsername == null && nullToAbsent
          ? const Value.absent()
          : Value(notaryServiceUsername),
      createdAt: Value(createdAt),
      modifyAt: modifyAt == null && nullToAbsent
          ? const Value.absent()
          : Value(modifyAt),
    );
  }

  factory Store.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Store(
      businessUsername: serializer.fromJson<String>(json['businessUsername']),
      storeType: serializer.fromJson<int?>(json['storeType']),
      imageUrl: serializer.fromJson<String?>(json['imageUrl']),
      introductory: serializer.fromJson<String?>(json['introductory']),
      keys: serializer.fromJson<String?>(json['keys']),
      contactMobile: serializer.fromJson<String?>(json['contactMobile']),
      wechat: serializer.fromJson<String?>(json['wechat']),
      branchesname: serializer.fromJson<String?>(json['branchesname']),
      openingHours: serializer.fromJson<String?>(json['openingHours']),
      province: serializer.fromJson<String?>(json['province']),
      city: serializer.fromJson<String?>(json['city']),
      area: serializer.fromJson<String?>(json['area']),
      street: serializer.fromJson<String?>(json['street']),
      address: serializer.fromJson<String?>(json['address']),
      legalPerson: serializer.fromJson<String?>(json['legalPerson']),
      legalIdentityCard:
          serializer.fromJson<String?>(json['legalIdentityCard']),
      licenseUrl: serializer.fromJson<String?>(json['licenseUrl']),
      longitude: serializer.fromJson<String?>(json['longitude']),
      latitude: serializer.fromJson<String?>(json['latitude']),
      businessCode: serializer.fromJson<String?>(json['businessCode']),
      notaryServiceUsername:
          serializer.fromJson<String?>(json['notaryServiceUsername']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      modifyAt: serializer.fromJson<int?>(json['modifyAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'businessUsername': serializer.toJson<String>(businessUsername),
      'storeType': serializer.toJson<int?>(storeType),
      'imageUrl': serializer.toJson<String?>(imageUrl),
      'introductory': serializer.toJson<String?>(introductory),
      'keys': serializer.toJson<String?>(keys),
      'contactMobile': serializer.toJson<String?>(contactMobile),
      'wechat': serializer.toJson<String?>(wechat),
      'branchesname': serializer.toJson<String?>(branchesname),
      'openingHours': serializer.toJson<String?>(openingHours),
      'province': serializer.toJson<String?>(province),
      'city': serializer.toJson<String?>(city),
      'area': serializer.toJson<String?>(area),
      'street': serializer.toJson<String?>(street),
      'address': serializer.toJson<String?>(address),
      'legalPerson': serializer.toJson<String?>(legalPerson),
      'legalIdentityCard': serializer.toJson<String?>(legalIdentityCard),
      'licenseUrl': serializer.toJson<String?>(licenseUrl),
      'longitude': serializer.toJson<String?>(longitude),
      'latitude': serializer.toJson<String?>(latitude),
      'businessCode': serializer.toJson<String?>(businessCode),
      'notaryServiceUsername':
          serializer.toJson<String?>(notaryServiceUsername),
      'createdAt': serializer.toJson<int>(createdAt),
      'modifyAt': serializer.toJson<int?>(modifyAt),
    };
  }

  Store copyWith(
          {String? businessUsername,
          int? storeType,
          String? imageUrl,
          String? introductory,
          String? keys,
          String? contactMobile,
          String? wechat,
          String? branchesname,
          String? openingHours,
          String? province,
          String? city,
          String? area,
          String? street,
          String? address,
          String? legalPerson,
          String? legalIdentityCard,
          String? licenseUrl,
          String? longitude,
          String? latitude,
          String? businessCode,
          String? notaryServiceUsername,
          int? createdAt,
          int? modifyAt}) =>
      Store(
        businessUsername: businessUsername ?? this.businessUsername,
        storeType: storeType ?? this.storeType,
        imageUrl: imageUrl ?? this.imageUrl,
        introductory: introductory ?? this.introductory,
        keys: keys ?? this.keys,
        contactMobile: contactMobile ?? this.contactMobile,
        wechat: wechat ?? this.wechat,
        branchesname: branchesname ?? this.branchesname,
        openingHours: openingHours ?? this.openingHours,
        province: province ?? this.province,
        city: city ?? this.city,
        area: area ?? this.area,
        street: street ?? this.street,
        address: address ?? this.address,
        legalPerson: legalPerson ?? this.legalPerson,
        legalIdentityCard: legalIdentityCard ?? this.legalIdentityCard,
        licenseUrl: licenseUrl ?? this.licenseUrl,
        longitude: longitude ?? this.longitude,
        latitude: latitude ?? this.latitude,
        businessCode: businessCode ?? this.businessCode,
        notaryServiceUsername:
            notaryServiceUsername ?? this.notaryServiceUsername,
        createdAt: createdAt ?? this.createdAt,
        modifyAt: modifyAt ?? this.modifyAt,
      );
  @override
  String toString() {
    return (StringBuffer('Store(')
          ..write('businessUsername: $businessUsername, ')
          ..write('storeType: $storeType, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('introductory: $introductory, ')
          ..write('keys: $keys, ')
          ..write('contactMobile: $contactMobile, ')
          ..write('wechat: $wechat, ')
          ..write('branchesname: $branchesname, ')
          ..write('openingHours: $openingHours, ')
          ..write('province: $province, ')
          ..write('city: $city, ')
          ..write('area: $area, ')
          ..write('street: $street, ')
          ..write('address: $address, ')
          ..write('legalPerson: $legalPerson, ')
          ..write('legalIdentityCard: $legalIdentityCard, ')
          ..write('licenseUrl: $licenseUrl, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('businessCode: $businessCode, ')
          ..write('notaryServiceUsername: $notaryServiceUsername, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifyAt: $modifyAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      businessUsername.hashCode,
      $mrjc(
          storeType.hashCode,
          $mrjc(
              imageUrl.hashCode,
              $mrjc(
                  introductory.hashCode,
                  $mrjc(
                      keys.hashCode,
                      $mrjc(
                          contactMobile.hashCode,
                          $mrjc(
                              wechat.hashCode,
                              $mrjc(
                                  branchesname.hashCode,
                                  $mrjc(
                                      openingHours.hashCode,
                                      $mrjc(
                                          province.hashCode,
                                          $mrjc(
                                              city.hashCode,
                                              $mrjc(
                                                  area.hashCode,
                                                  $mrjc(
                                                      street.hashCode,
                                                      $mrjc(
                                                          address.hashCode,
                                                          $mrjc(
                                                              legalPerson
                                                                  .hashCode,
                                                              $mrjc(
                                                                  legalIdentityCard
                                                                      .hashCode,
                                                                  $mrjc(
                                                                      licenseUrl
                                                                          .hashCode,
                                                                      $mrjc(
                                                                          longitude
                                                                              .hashCode,
                                                                          $mrjc(
                                                                              latitude.hashCode,
                                                                              $mrjc(businessCode.hashCode, $mrjc(notaryServiceUsername.hashCode, $mrjc(createdAt.hashCode, modifyAt.hashCode)))))))))))))))))))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Store &&
          other.businessUsername == this.businessUsername &&
          other.storeType == this.storeType &&
          other.imageUrl == this.imageUrl &&
          other.introductory == this.introductory &&
          other.keys == this.keys &&
          other.contactMobile == this.contactMobile &&
          other.wechat == this.wechat &&
          other.branchesname == this.branchesname &&
          other.openingHours == this.openingHours &&
          other.province == this.province &&
          other.city == this.city &&
          other.area == this.area &&
          other.street == this.street &&
          other.address == this.address &&
          other.legalPerson == this.legalPerson &&
          other.legalIdentityCard == this.legalIdentityCard &&
          other.licenseUrl == this.licenseUrl &&
          other.longitude == this.longitude &&
          other.latitude == this.latitude &&
          other.businessCode == this.businessCode &&
          other.notaryServiceUsername == this.notaryServiceUsername &&
          other.createdAt == this.createdAt &&
          other.modifyAt == this.modifyAt);
}

class StoresCompanion extends UpdateCompanion<Store> {
  final Value<String> businessUsername;
  final Value<int?> storeType;
  final Value<String?> imageUrl;
  final Value<String?> introductory;
  final Value<String?> keys;
  final Value<String?> contactMobile;
  final Value<String?> wechat;
  final Value<String?> branchesname;
  final Value<String?> openingHours;
  final Value<String?> province;
  final Value<String?> city;
  final Value<String?> area;
  final Value<String?> street;
  final Value<String?> address;
  final Value<String?> legalPerson;
  final Value<String?> legalIdentityCard;
  final Value<String?> licenseUrl;
  final Value<String?> longitude;
  final Value<String?> latitude;
  final Value<String?> businessCode;
  final Value<String?> notaryServiceUsername;
  final Value<int> createdAt;
  final Value<int?> modifyAt;
  const StoresCompanion({
    this.businessUsername = const Value.absent(),
    this.storeType = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.introductory = const Value.absent(),
    this.keys = const Value.absent(),
    this.contactMobile = const Value.absent(),
    this.wechat = const Value.absent(),
    this.branchesname = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.province = const Value.absent(),
    this.city = const Value.absent(),
    this.area = const Value.absent(),
    this.street = const Value.absent(),
    this.address = const Value.absent(),
    this.legalPerson = const Value.absent(),
    this.legalIdentityCard = const Value.absent(),
    this.licenseUrl = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.businessCode = const Value.absent(),
    this.notaryServiceUsername = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.modifyAt = const Value.absent(),
  });
  StoresCompanion.insert({
    required String businessUsername,
    this.storeType = const Value.absent(),
    this.imageUrl = const Value.absent(),
    this.introductory = const Value.absent(),
    this.keys = const Value.absent(),
    this.contactMobile = const Value.absent(),
    this.wechat = const Value.absent(),
    this.branchesname = const Value.absent(),
    this.openingHours = const Value.absent(),
    this.province = const Value.absent(),
    this.city = const Value.absent(),
    this.area = const Value.absent(),
    this.street = const Value.absent(),
    this.address = const Value.absent(),
    this.legalPerson = const Value.absent(),
    this.legalIdentityCard = const Value.absent(),
    this.licenseUrl = const Value.absent(),
    this.longitude = const Value.absent(),
    this.latitude = const Value.absent(),
    this.businessCode = const Value.absent(),
    this.notaryServiceUsername = const Value.absent(),
    required int createdAt,
    this.modifyAt = const Value.absent(),
  })  : businessUsername = Value(businessUsername),
        createdAt = Value(createdAt);
  static Insertable<Store> custom({
    Expression<String>? businessUsername,
    Expression<int?>? storeType,
    Expression<String?>? imageUrl,
    Expression<String?>? introductory,
    Expression<String?>? keys,
    Expression<String?>? contactMobile,
    Expression<String?>? wechat,
    Expression<String?>? branchesname,
    Expression<String?>? openingHours,
    Expression<String?>? province,
    Expression<String?>? city,
    Expression<String?>? area,
    Expression<String?>? street,
    Expression<String?>? address,
    Expression<String?>? legalPerson,
    Expression<String?>? legalIdentityCard,
    Expression<String?>? licenseUrl,
    Expression<String?>? longitude,
    Expression<String?>? latitude,
    Expression<String?>? businessCode,
    Expression<String?>? notaryServiceUsername,
    Expression<int>? createdAt,
    Expression<int?>? modifyAt,
  }) {
    return RawValuesInsertable({
      if (businessUsername != null) 'businessUsername': businessUsername,
      if (storeType != null) 'storeType': storeType,
      if (imageUrl != null) 'imageUrl': imageUrl,
      if (introductory != null) 'introductory': introductory,
      if (keys != null) 'keys': keys,
      if (contactMobile != null) 'contactMobile': contactMobile,
      if (wechat != null) 'wechat': wechat,
      if (branchesname != null) 'branchesname': branchesname,
      if (openingHours != null) 'openingHours': openingHours,
      if (province != null) 'province': province,
      if (city != null) 'city': city,
      if (area != null) 'area': area,
      if (street != null) 'street': street,
      if (address != null) 'address': address,
      if (legalPerson != null) 'legalPerson': legalPerson,
      if (legalIdentityCard != null) 'legalIdentityCard': legalIdentityCard,
      if (licenseUrl != null) 'licenseUrl': licenseUrl,
      if (longitude != null) 'longitude': longitude,
      if (latitude != null) 'latitude': latitude,
      if (businessCode != null) 'businessCode': businessCode,
      if (notaryServiceUsername != null)
        'notaryServiceUsername': notaryServiceUsername,
      if (createdAt != null) 'createdAt': createdAt,
      if (modifyAt != null) 'modifyAt': modifyAt,
    });
  }

  StoresCompanion copyWith(
      {Value<String>? businessUsername,
      Value<int?>? storeType,
      Value<String?>? imageUrl,
      Value<String?>? introductory,
      Value<String?>? keys,
      Value<String?>? contactMobile,
      Value<String?>? wechat,
      Value<String?>? branchesname,
      Value<String?>? openingHours,
      Value<String?>? province,
      Value<String?>? city,
      Value<String?>? area,
      Value<String?>? street,
      Value<String?>? address,
      Value<String?>? legalPerson,
      Value<String?>? legalIdentityCard,
      Value<String?>? licenseUrl,
      Value<String?>? longitude,
      Value<String?>? latitude,
      Value<String?>? businessCode,
      Value<String?>? notaryServiceUsername,
      Value<int>? createdAt,
      Value<int?>? modifyAt}) {
    return StoresCompanion(
      businessUsername: businessUsername ?? this.businessUsername,
      storeType: storeType ?? this.storeType,
      imageUrl: imageUrl ?? this.imageUrl,
      introductory: introductory ?? this.introductory,
      keys: keys ?? this.keys,
      contactMobile: contactMobile ?? this.contactMobile,
      wechat: wechat ?? this.wechat,
      branchesname: branchesname ?? this.branchesname,
      openingHours: openingHours ?? this.openingHours,
      province: province ?? this.province,
      city: city ?? this.city,
      area: area ?? this.area,
      street: street ?? this.street,
      address: address ?? this.address,
      legalPerson: legalPerson ?? this.legalPerson,
      legalIdentityCard: legalIdentityCard ?? this.legalIdentityCard,
      licenseUrl: licenseUrl ?? this.licenseUrl,
      longitude: longitude ?? this.longitude,
      latitude: latitude ?? this.latitude,
      businessCode: businessCode ?? this.businessCode,
      notaryServiceUsername:
          notaryServiceUsername ?? this.notaryServiceUsername,
      createdAt: createdAt ?? this.createdAt,
      modifyAt: modifyAt ?? this.modifyAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (businessUsername.present) {
      map['businessUsername'] = Variable<String>(businessUsername.value);
    }
    if (storeType.present) {
      map['storeType'] = Variable<int?>(storeType.value);
    }
    if (imageUrl.present) {
      map['imageUrl'] = Variable<String?>(imageUrl.value);
    }
    if (introductory.present) {
      map['introductory'] = Variable<String?>(introductory.value);
    }
    if (keys.present) {
      map['keys'] = Variable<String?>(keys.value);
    }
    if (contactMobile.present) {
      map['contactMobile'] = Variable<String?>(contactMobile.value);
    }
    if (wechat.present) {
      map['wechat'] = Variable<String?>(wechat.value);
    }
    if (branchesname.present) {
      map['branchesname'] = Variable<String?>(branchesname.value);
    }
    if (openingHours.present) {
      map['openingHours'] = Variable<String?>(openingHours.value);
    }
    if (province.present) {
      map['province'] = Variable<String?>(province.value);
    }
    if (city.present) {
      map['city'] = Variable<String?>(city.value);
    }
    if (area.present) {
      map['area'] = Variable<String?>(area.value);
    }
    if (street.present) {
      map['street'] = Variable<String?>(street.value);
    }
    if (address.present) {
      map['address'] = Variable<String?>(address.value);
    }
    if (legalPerson.present) {
      map['legalPerson'] = Variable<String?>(legalPerson.value);
    }
    if (legalIdentityCard.present) {
      map['legalIdentityCard'] = Variable<String?>(legalIdentityCard.value);
    }
    if (licenseUrl.present) {
      map['licenseUrl'] = Variable<String?>(licenseUrl.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<String?>(longitude.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<String?>(latitude.value);
    }
    if (businessCode.present) {
      map['businessCode'] = Variable<String?>(businessCode.value);
    }
    if (notaryServiceUsername.present) {
      map['notaryServiceUsername'] =
          Variable<String?>(notaryServiceUsername.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<int>(createdAt.value);
    }
    if (modifyAt.present) {
      map['modifyAt'] = Variable<int?>(modifyAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StoresCompanion(')
          ..write('businessUsername: $businessUsername, ')
          ..write('storeType: $storeType, ')
          ..write('imageUrl: $imageUrl, ')
          ..write('introductory: $introductory, ')
          ..write('keys: $keys, ')
          ..write('contactMobile: $contactMobile, ')
          ..write('wechat: $wechat, ')
          ..write('branchesname: $branchesname, ')
          ..write('openingHours: $openingHours, ')
          ..write('province: $province, ')
          ..write('city: $city, ')
          ..write('area: $area, ')
          ..write('street: $street, ')
          ..write('address: $address, ')
          ..write('legalPerson: $legalPerson, ')
          ..write('legalIdentityCard: $legalIdentityCard, ')
          ..write('licenseUrl: $licenseUrl, ')
          ..write('longitude: $longitude, ')
          ..write('latitude: $latitude, ')
          ..write('businessCode: $businessCode, ')
          ..write('notaryServiceUsername: $notaryServiceUsername, ')
          ..write('createdAt: $createdAt, ')
          ..write('modifyAt: $modifyAt')
          ..write(')'))
        .toString();
  }
}

class Stores extends Table with TableInfo<Stores, Store> {
  final GeneratedDatabase _db;
  final String? _alias;
  Stores(this._db, [this._alias]);
  final VerificationMeta _businessUsernameMeta =
      const VerificationMeta('businessUsername');
  late final GeneratedColumn<String?> businessUsername =
      GeneratedColumn<String?>('businessUsername', aliasedName, false,
          typeName: 'TEXT',
          requiredDuringInsert: true,
          $customConstraints: 'not null primary key');
  final VerificationMeta _storeTypeMeta = const VerificationMeta('storeType');
  late final GeneratedColumn<int?> storeType = GeneratedColumn<int?>(
      'storeType', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _imageUrlMeta = const VerificationMeta('imageUrl');
  late final GeneratedColumn<String?> imageUrl = GeneratedColumn<String?>(
      'imageUrl', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _introductoryMeta =
      const VerificationMeta('introductory');
  late final GeneratedColumn<String?> introductory = GeneratedColumn<String?>(
      'introductory', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _keysMeta = const VerificationMeta('keys');
  late final GeneratedColumn<String?> keys = GeneratedColumn<String?>(
      'keys', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _contactMobileMeta =
      const VerificationMeta('contactMobile');
  late final GeneratedColumn<String?> contactMobile = GeneratedColumn<String?>(
      'contactMobile', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _wechatMeta = const VerificationMeta('wechat');
  late final GeneratedColumn<String?> wechat = GeneratedColumn<String?>(
      'wechat', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _branchesnameMeta =
      const VerificationMeta('branchesname');
  late final GeneratedColumn<String?> branchesname = GeneratedColumn<String?>(
      'branchesname', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _openingHoursMeta =
      const VerificationMeta('openingHours');
  late final GeneratedColumn<String?> openingHours = GeneratedColumn<String?>(
      'openingHours', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _provinceMeta = const VerificationMeta('province');
  late final GeneratedColumn<String?> province = GeneratedColumn<String?>(
      'province', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _cityMeta = const VerificationMeta('city');
  late final GeneratedColumn<String?> city = GeneratedColumn<String?>(
      'city', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _areaMeta = const VerificationMeta('area');
  late final GeneratedColumn<String?> area = GeneratedColumn<String?>(
      'area', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _streetMeta = const VerificationMeta('street');
  late final GeneratedColumn<String?> street = GeneratedColumn<String?>(
      'street', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _addressMeta = const VerificationMeta('address');
  late final GeneratedColumn<String?> address = GeneratedColumn<String?>(
      'address', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _legalPersonMeta =
      const VerificationMeta('legalPerson');
  late final GeneratedColumn<String?> legalPerson = GeneratedColumn<String?>(
      'legalPerson', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _legalIdentityCardMeta =
      const VerificationMeta('legalIdentityCard');
  late final GeneratedColumn<String?> legalIdentityCard =
      GeneratedColumn<String?>('legalIdentityCard', aliasedName, true,
          typeName: 'TEXT',
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _licenseUrlMeta = const VerificationMeta('licenseUrl');
  late final GeneratedColumn<String?> licenseUrl = GeneratedColumn<String?>(
      'licenseUrl', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _longitudeMeta = const VerificationMeta('longitude');
  late final GeneratedColumn<String?> longitude = GeneratedColumn<String?>(
      'longitude', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _latitudeMeta = const VerificationMeta('latitude');
  late final GeneratedColumn<String?> latitude = GeneratedColumn<String?>(
      'latitude', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _businessCodeMeta =
      const VerificationMeta('businessCode');
  late final GeneratedColumn<String?> businessCode = GeneratedColumn<String?>(
      'businessCode', aliasedName, true,
      typeName: 'TEXT', requiredDuringInsert: false, $customConstraints: '');
  final VerificationMeta _notaryServiceUsernameMeta =
      const VerificationMeta('notaryServiceUsername');
  late final GeneratedColumn<String?> notaryServiceUsername =
      GeneratedColumn<String?>('notaryServiceUsername', aliasedName, true,
          typeName: 'TEXT',
          requiredDuringInsert: false,
          $customConstraints: '');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<int?> createdAt = GeneratedColumn<int?>(
      'createdAt', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  final VerificationMeta _modifyAtMeta = const VerificationMeta('modifyAt');
  late final GeneratedColumn<int?> modifyAt = GeneratedColumn<int?>(
      'modifyAt', aliasedName, true,
      typeName: 'INTEGER', requiredDuringInsert: false, $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [
        businessUsername,
        storeType,
        imageUrl,
        introductory,
        keys,
        contactMobile,
        wechat,
        branchesname,
        openingHours,
        province,
        city,
        area,
        street,
        address,
        legalPerson,
        legalIdentityCard,
        licenseUrl,
        longitude,
        latitude,
        businessCode,
        notaryServiceUsername,
        createdAt,
        modifyAt
      ];
  @override
  String get aliasedName => _alias ?? 'stores';
  @override
  String get actualTableName => 'stores';
  @override
  VerificationContext validateIntegrity(Insertable<Store> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('businessUsername')) {
      context.handle(
          _businessUsernameMeta,
          businessUsername.isAcceptableOrUnknown(
              data['businessUsername']!, _businessUsernameMeta));
    } else if (isInserting) {
      context.missing(_businessUsernameMeta);
    }
    if (data.containsKey('storeType')) {
      context.handle(_storeTypeMeta,
          storeType.isAcceptableOrUnknown(data['storeType']!, _storeTypeMeta));
    }
    if (data.containsKey('imageUrl')) {
      context.handle(_imageUrlMeta,
          imageUrl.isAcceptableOrUnknown(data['imageUrl']!, _imageUrlMeta));
    }
    if (data.containsKey('introductory')) {
      context.handle(
          _introductoryMeta,
          introductory.isAcceptableOrUnknown(
              data['introductory']!, _introductoryMeta));
    }
    if (data.containsKey('keys')) {
      context.handle(
          _keysMeta, keys.isAcceptableOrUnknown(data['keys']!, _keysMeta));
    }
    if (data.containsKey('contactMobile')) {
      context.handle(
          _contactMobileMeta,
          contactMobile.isAcceptableOrUnknown(
              data['contactMobile']!, _contactMobileMeta));
    }
    if (data.containsKey('wechat')) {
      context.handle(_wechatMeta,
          wechat.isAcceptableOrUnknown(data['wechat']!, _wechatMeta));
    }
    if (data.containsKey('branchesname')) {
      context.handle(
          _branchesnameMeta,
          branchesname.isAcceptableOrUnknown(
              data['branchesname']!, _branchesnameMeta));
    }
    if (data.containsKey('openingHours')) {
      context.handle(
          _openingHoursMeta,
          openingHours.isAcceptableOrUnknown(
              data['openingHours']!, _openingHoursMeta));
    }
    if (data.containsKey('province')) {
      context.handle(_provinceMeta,
          province.isAcceptableOrUnknown(data['province']!, _provinceMeta));
    }
    if (data.containsKey('city')) {
      context.handle(
          _cityMeta, city.isAcceptableOrUnknown(data['city']!, _cityMeta));
    }
    if (data.containsKey('area')) {
      context.handle(
          _areaMeta, area.isAcceptableOrUnknown(data['area']!, _areaMeta));
    }
    if (data.containsKey('street')) {
      context.handle(_streetMeta,
          street.isAcceptableOrUnknown(data['street']!, _streetMeta));
    }
    if (data.containsKey('address')) {
      context.handle(_addressMeta,
          address.isAcceptableOrUnknown(data['address']!, _addressMeta));
    }
    if (data.containsKey('legalPerson')) {
      context.handle(
          _legalPersonMeta,
          legalPerson.isAcceptableOrUnknown(
              data['legalPerson']!, _legalPersonMeta));
    }
    if (data.containsKey('legalIdentityCard')) {
      context.handle(
          _legalIdentityCardMeta,
          legalIdentityCard.isAcceptableOrUnknown(
              data['legalIdentityCard']!, _legalIdentityCardMeta));
    }
    if (data.containsKey('licenseUrl')) {
      context.handle(
          _licenseUrlMeta,
          licenseUrl.isAcceptableOrUnknown(
              data['licenseUrl']!, _licenseUrlMeta));
    }
    if (data.containsKey('longitude')) {
      context.handle(_longitudeMeta,
          longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta));
    }
    if (data.containsKey('latitude')) {
      context.handle(_latitudeMeta,
          latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta));
    }
    if (data.containsKey('businessCode')) {
      context.handle(
          _businessCodeMeta,
          businessCode.isAcceptableOrUnknown(
              data['businessCode']!, _businessCodeMeta));
    }
    if (data.containsKey('notaryServiceUsername')) {
      context.handle(
          _notaryServiceUsernameMeta,
          notaryServiceUsername.isAcceptableOrUnknown(
              data['notaryServiceUsername']!, _notaryServiceUsernameMeta));
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('modifyAt')) {
      context.handle(_modifyAtMeta,
          modifyAt.isAcceptableOrUnknown(data['modifyAt']!, _modifyAtMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {businessUsername};
  @override
  Store map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Store.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  Stores createAlias(String alias) {
    return Stores(_db, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class Lottery extends DataClass implements Insertable<Lottery> {
  final int? id;
  final int productId;
  final int type;
  final String content;
  final int createdAt;
  final int act;
  Lottery(
      {this.id,
      required this.productId,
      required this.type,
      required this.content,
      required this.createdAt,
      required this.act});
  factory Lottery.fromData(Map<String, dynamic> data, GeneratedDatabase db,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Lottery(
      id: const IntType().mapFromDatabaseResponse(data['${effectivePrefix}id']),
      productId: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}productId'])!,
      type: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}type'])!,
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content'])!,
      createdAt: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}createdAt'])!,
      act: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}act'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || id != null) {
      map['id'] = Variable<int?>(id);
    }
    map['productId'] = Variable<int>(productId);
    map['type'] = Variable<int>(type);
    map['content'] = Variable<String>(content);
    map['createdAt'] = Variable<int>(createdAt);
    map['act'] = Variable<int>(act);
    return map;
  }

  LotteryCompanion toCompanion(bool nullToAbsent) {
    return LotteryCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      productId: Value(productId),
      type: Value(type),
      content: Value(content),
      createdAt: Value(createdAt),
      act: Value(act),
    );
  }

  factory Lottery.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return Lottery(
      id: serializer.fromJson<int?>(json['id']),
      productId: serializer.fromJson<int>(json['productId']),
      type: serializer.fromJson<int>(json['type']),
      content: serializer.fromJson<String>(json['content']),
      createdAt: serializer.fromJson<int>(json['createdAt']),
      act: serializer.fromJson<int>(json['act']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= moorRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int?>(id),
      'productId': serializer.toJson<int>(productId),
      'type': serializer.toJson<int>(type),
      'content': serializer.toJson<String>(content),
      'createdAt': serializer.toJson<int>(createdAt),
      'act': serializer.toJson<int>(act),
    };
  }

  Lottery copyWith(
          {int? id,
          int? productId,
          int? type,
          String? content,
          int? createdAt,
          int? act}) =>
      Lottery(
        id: id ?? this.id,
        productId: productId ?? this.productId,
        type: type ?? this.type,
        content: content ?? this.content,
        createdAt: createdAt ?? this.createdAt,
        act: act ?? this.act,
      );
  @override
  String toString() {
    return (StringBuffer('Lottery(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('act: $act')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode,
      $mrjc(
          productId.hashCode,
          $mrjc(
              type.hashCode,
              $mrjc(content.hashCode,
                  $mrjc(createdAt.hashCode, act.hashCode))))));
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Lottery &&
          other.id == this.id &&
          other.productId == this.productId &&
          other.type == this.type &&
          other.content == this.content &&
          other.createdAt == this.createdAt &&
          other.act == this.act);
}

class LotteryCompanion extends UpdateCompanion<Lottery> {
  final Value<int?> id;
  final Value<int> productId;
  final Value<int> type;
  final Value<String> content;
  final Value<int> createdAt;
  final Value<int> act;
  const LotteryCompanion({
    this.id = const Value.absent(),
    this.productId = const Value.absent(),
    this.type = const Value.absent(),
    this.content = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.act = const Value.absent(),
  });
  LotteryCompanion.insert({
    this.id = const Value.absent(),
    required int productId,
    required int type,
    required String content,
    required int createdAt,
    required int act,
  })  : productId = Value(productId),
        type = Value(type),
        content = Value(content),
        createdAt = Value(createdAt),
        act = Value(act);
  static Insertable<Lottery> custom({
    Expression<int?>? id,
    Expression<int>? productId,
    Expression<int>? type,
    Expression<String>? content,
    Expression<int>? createdAt,
    Expression<int>? act,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (productId != null) 'productId': productId,
      if (type != null) 'type': type,
      if (content != null) 'content': content,
      if (createdAt != null) 'createdAt': createdAt,
      if (act != null) 'act': act,
    });
  }

  LotteryCompanion copyWith(
      {Value<int?>? id,
      Value<int>? productId,
      Value<int>? type,
      Value<String>? content,
      Value<int>? createdAt,
      Value<int>? act}) {
    return LotteryCompanion(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      type: type ?? this.type,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      act: act ?? this.act,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int?>(id.value);
    }
    if (productId.present) {
      map['productId'] = Variable<int>(productId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(type.value);
    }
    if (content.present) {
      map['content'] = Variable<String>(content.value);
    }
    if (createdAt.present) {
      map['createdAt'] = Variable<int>(createdAt.value);
    }
    if (act.present) {
      map['act'] = Variable<int>(act.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LotteryCompanion(')
          ..write('id: $id, ')
          ..write('productId: $productId, ')
          ..write('type: $type, ')
          ..write('content: $content, ')
          ..write('createdAt: $createdAt, ')
          ..write('act: $act')
          ..write(')'))
        .toString();
  }
}

class LotteryTable extends Table with TableInfo<LotteryTable, Lottery> {
  final GeneratedDatabase _db;
  final String? _alias;
  LotteryTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, true,
      typeName: 'INTEGER',
      requiredDuringInsert: false,
      $customConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _productIdMeta = const VerificationMeta('productId');
  late final GeneratedColumn<int?> productId = GeneratedColumn<int?>(
      'productId', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  final VerificationMeta _typeMeta = const VerificationMeta('type');
  late final GeneratedColumn<int?> type = GeneratedColumn<int?>(
      'type', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, false,
      typeName: 'TEXT',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  final VerificationMeta _createdAtMeta = const VerificationMeta('createdAt');
  late final GeneratedColumn<int?> createdAt = GeneratedColumn<int?>(
      'createdAt', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  final VerificationMeta _actMeta = const VerificationMeta('act');
  late final GeneratedColumn<int?> act = GeneratedColumn<int?>(
      'act', aliasedName, false,
      typeName: 'INTEGER',
      requiredDuringInsert: true,
      $customConstraints: 'not null');
  @override
  List<GeneratedColumn> get $columns =>
      [id, productId, type, content, createdAt, act];
  @override
  String get aliasedName => _alias ?? 'lottery';
  @override
  String get actualTableName => 'lottery';
  @override
  VerificationContext validateIntegrity(Insertable<Lottery> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('productId')) {
      context.handle(_productIdMeta,
          productId.isAcceptableOrUnknown(data['productId']!, _productIdMeta));
    } else if (isInserting) {
      context.missing(_productIdMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    } else if (isInserting) {
      context.missing(_contentMeta);
    }
    if (data.containsKey('createdAt')) {
      context.handle(_createdAtMeta,
          createdAt.isAcceptableOrUnknown(data['createdAt']!, _createdAtMeta));
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('act')) {
      context.handle(
          _actMeta, act.isAcceptableOrUnknown(data['act']!, _actMeta));
    } else if (isInserting) {
      context.missing(_actMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Lottery map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Lottery.fromData(data, _db,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  LotteryTable createAlias(String alias) {
    return LotteryTable(_db, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$MyDatabase extends GeneratedDatabase {
  _$MyDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  _$MyDatabase.connect(DatabaseConnection c) : super.connect(c);
  late final TestTable test = TestTable(this);
  late final Stores stores = Stores(this);
  late final LotteryTable lottery = LotteryTable(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [test, stores, lottery];
}
