// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'freezed_data_classes.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$RegisterObject {
  String get userName => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RegisterObjectCopyWith<RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RegisterObjectCopyWith<$Res> {
  factory $RegisterObjectCopyWith(
          RegisterObject value, $Res Function(RegisterObject) then) =
      _$RegisterObjectCopyWithImpl<$Res, RegisterObject>;
  @useResult
  $Res call({String userName, String email, String password});
}

/// @nodoc
class _$RegisterObjectCopyWithImpl<$Res, $Val extends RegisterObject>
    implements $RegisterObjectCopyWith<$Res> {
  _$RegisterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      userName: null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RegisterObjectCopyWith<$Res>
    implements $RegisterObjectCopyWith<$Res> {
  factory _$$_RegisterObjectCopyWith(
          _$_RegisterObject value, $Res Function(_$_RegisterObject) then) =
      __$$_RegisterObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String userName, String email, String password});
}

/// @nodoc
class __$$_RegisterObjectCopyWithImpl<$Res>
    extends _$RegisterObjectCopyWithImpl<$Res, _$_RegisterObject>
    implements _$$_RegisterObjectCopyWith<$Res> {
  __$$_RegisterObjectCopyWithImpl(
      _$_RegisterObject _value, $Res Function(_$_RegisterObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userName = null,
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_RegisterObject(
      null == userName
          ? _value.userName
          : userName // ignore: cast_nullable_to_non_nullable
              as String,
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_RegisterObject implements _RegisterObject {
  _$_RegisterObject(this.userName, this.email, this.password);

  @override
  final String userName;
  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'RegisterObject(userName: $userName, email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RegisterObject &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, userName, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      __$$_RegisterObjectCopyWithImpl<_$_RegisterObject>(this, _$identity);
}

abstract class _RegisterObject implements RegisterObject {
  factory _RegisterObject(
          final String userName, final String email, final String password) =
      _$_RegisterObject;

  @override
  String get userName;
  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_RegisterObjectCopyWith<_$_RegisterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$LoginObject {
  String get email => throw _privateConstructorUsedError;
  String get password => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $LoginObjectCopyWith<LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LoginObjectCopyWith<$Res> {
  factory $LoginObjectCopyWith(
          LoginObject value, $Res Function(LoginObject) then) =
      _$LoginObjectCopyWithImpl<$Res, LoginObject>;
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class _$LoginObjectCopyWithImpl<$Res, $Val extends LoginObject>
    implements $LoginObjectCopyWith<$Res> {
  _$LoginObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_value.copyWith(
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      password: null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LoginObjectCopyWith<$Res>
    implements $LoginObjectCopyWith<$Res> {
  factory _$$_LoginObjectCopyWith(
          _$_LoginObject value, $Res Function(_$_LoginObject) then) =
      __$$_LoginObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String email, String password});
}

/// @nodoc
class __$$_LoginObjectCopyWithImpl<$Res>
    extends _$LoginObjectCopyWithImpl<$Res, _$_LoginObject>
    implements _$$_LoginObjectCopyWith<$Res> {
  __$$_LoginObjectCopyWithImpl(
      _$_LoginObject _value, $Res Function(_$_LoginObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? email = null,
    Object? password = null,
  }) {
    return _then(_$_LoginObject(
      null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      null == password
          ? _value.password
          : password // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$_LoginObject implements _LoginObject {
  _$_LoginObject(this.email, this.password);

  @override
  final String email;
  @override
  final String password;

  @override
  String toString() {
    return 'LoginObject(email: $email, password: $password)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LoginObject &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.password, password) ||
                other.password == password));
  }

  @override
  int get hashCode => Object.hash(runtimeType, email, password);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      __$$_LoginObjectCopyWithImpl<_$_LoginObject>(this, _$identity);
}

abstract class _LoginObject implements LoginObject {
  factory _LoginObject(final String email, final String password) =
      _$_LoginObject;

  @override
  String get email;
  @override
  String get password;
  @override
  @JsonKey(ignore: true)
  _$$_LoginObjectCopyWith<_$_LoginObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$UserObject {
  String? get name => throw _privateConstructorUsedError;
  String? get username => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get bio => throw _privateConstructorUsedError;
  String? get imgUrl => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get userType => throw _privateConstructorUsedError;
  String? get musicInstrument => throw _privateConstructorUsedError;
  List<String>? get likes => throw _privateConstructorUsedError;
  List<String>? get followers => throw _privateConstructorUsedError;
  List<String>? get following => throw _privateConstructorUsedError;
  String? get country => throw _privateConstructorUsedError;
  String? get certificate => throw _privateConstructorUsedError;
  List<String>? get certificates => throw _privateConstructorUsedError;
  bool? get isAccepted => throw _privateConstructorUsedError;
  bool? get isBlocked => throw _privateConstructorUsedError;
  List<String>? get blockers => throw _privateConstructorUsedError;
  String? get price => throw _privateConstructorUsedError;
  double? get rate => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $UserObjectCopyWith<UserObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserObjectCopyWith<$Res> {
  factory $UserObjectCopyWith(
          UserObject value, $Res Function(UserObject) then) =
      _$UserObjectCopyWithImpl<$Res, UserObject>;
  @useResult
  $Res call(
      {String? name,
      String? username,
      String? email,
      String? bio,
      String? imgUrl,
      String? uid,
      String? userType,
      String? musicInstrument,
      List<String>? likes,
      List<String>? followers,
      List<String>? following,
      String? country,
      String? certificate,
      List<String>? certificates,
      bool? isAccepted,
      bool? isBlocked,
      List<String>? blockers,
      String? price,
      double? rate});
}

/// @nodoc
class _$UserObjectCopyWithImpl<$Res, $Val extends UserObject>
    implements $UserObjectCopyWith<$Res> {
  _$UserObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? bio = freezed,
    Object? imgUrl = freezed,
    Object? uid = freezed,
    Object? userType = freezed,
    Object? musicInstrument = freezed,
    Object? likes = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? country = freezed,
    Object? certificate = freezed,
    Object? certificates = freezed,
    Object? isAccepted = freezed,
    Object? isBlocked = freezed,
    Object? blockers = freezed,
    Object? price = freezed,
    Object? rate = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      bio: freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      imgUrl: freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      musicInstrument: freezed == musicInstrument
          ? _value.musicInstrument
          : musicInstrument // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: freezed == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      followers: freezed == followers
          ? _value.followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      following: freezed == following
          ? _value.following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      country: freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      certificate: freezed == certificate
          ? _value.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as String?,
      certificates: freezed == certificates
          ? _value.certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      isAccepted: freezed == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool?,
      isBlocked: freezed == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      blockers: freezed == blockers
          ? _value.blockers
          : blockers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserObjectCopyWith<$Res>
    implements $UserObjectCopyWith<$Res> {
  factory _$$_UserObjectCopyWith(
          _$_UserObject value, $Res Function(_$_UserObject) then) =
      __$$_UserObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      String? username,
      String? email,
      String? bio,
      String? imgUrl,
      String? uid,
      String? userType,
      String? musicInstrument,
      List<String>? likes,
      List<String>? followers,
      List<String>? following,
      String? country,
      String? certificate,
      List<String>? certificates,
      bool? isAccepted,
      bool? isBlocked,
      List<String>? blockers,
      String? price,
      double? rate});
}

/// @nodoc
class __$$_UserObjectCopyWithImpl<$Res>
    extends _$UserObjectCopyWithImpl<$Res, _$_UserObject>
    implements _$$_UserObjectCopyWith<$Res> {
  __$$_UserObjectCopyWithImpl(
      _$_UserObject _value, $Res Function(_$_UserObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? username = freezed,
    Object? email = freezed,
    Object? bio = freezed,
    Object? imgUrl = freezed,
    Object? uid = freezed,
    Object? userType = freezed,
    Object? musicInstrument = freezed,
    Object? likes = freezed,
    Object? followers = freezed,
    Object? following = freezed,
    Object? country = freezed,
    Object? certificate = freezed,
    Object? certificates = freezed,
    Object? isAccepted = freezed,
    Object? isBlocked = freezed,
    Object? blockers = freezed,
    Object? price = freezed,
    Object? rate = freezed,
  }) {
    return _then(_$_UserObject(
      freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == bio
          ? _value.bio
          : bio // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == imgUrl
          ? _value.imgUrl
          : imgUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == musicInstrument
          ? _value.musicInstrument
          : musicInstrument // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == followers
          ? _value._followers
          : followers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == following
          ? _value._following
          : following // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == certificate
          ? _value.certificate
          : certificate // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == certificates
          ? _value._certificates
          : certificates // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == isAccepted
          ? _value.isAccepted
          : isAccepted // ignore: cast_nullable_to_non_nullable
              as bool?,
      freezed == isBlocked
          ? _value.isBlocked
          : isBlocked // ignore: cast_nullable_to_non_nullable
              as bool?,
      freezed == blockers
          ? _value._blockers
          : blockers // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_UserObject implements _UserObject {
  _$_UserObject(
      this.name,
      this.username,
      this.email,
      this.bio,
      this.imgUrl,
      this.uid,
      this.userType,
      this.musicInstrument,
      final List<String>? likes,
      final List<String>? followers,
      final List<String>? following,
      this.country,
      this.certificate,
      final List<String>? certificates,
      this.isAccepted,
      this.isBlocked,
      final List<String>? blockers,
      this.price,
      this.rate)
      : _likes = likes,
        _followers = followers,
        _following = following,
        _certificates = certificates,
        _blockers = blockers;

  @override
  final String? name;
  @override
  final String? username;
  @override
  final String? email;
  @override
  final String? bio;
  @override
  final String? imgUrl;
  @override
  final String? uid;
  @override
  final String? userType;
  @override
  final String? musicInstrument;
  final List<String>? _likes;
  @override
  List<String>? get likes {
    final value = _likes;
    if (value == null) return null;
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _followers;
  @override
  List<String>? get followers {
    final value = _followers;
    if (value == null) return null;
    if (_followers is EqualUnmodifiableListView) return _followers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _following;
  @override
  List<String>? get following {
    final value = _following;
    if (value == null) return null;
    if (_following is EqualUnmodifiableListView) return _following;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? country;
  @override
  final String? certificate;
  final List<String>? _certificates;
  @override
  List<String>? get certificates {
    final value = _certificates;
    if (value == null) return null;
    if (_certificates is EqualUnmodifiableListView) return _certificates;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? isAccepted;
  @override
  final bool? isBlocked;
  final List<String>? _blockers;
  @override
  List<String>? get blockers {
    final value = _blockers;
    if (value == null) return null;
    if (_blockers is EqualUnmodifiableListView) return _blockers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? price;
  @override
  final double? rate;

  @override
  String toString() {
    return 'UserObject(name: $name, username: $username, email: $email, bio: $bio, imgUrl: $imgUrl, uid: $uid, userType: $userType, musicInstrument: $musicInstrument, likes: $likes, followers: $followers, following: $following, country: $country, certificate: $certificate, certificates: $certificates, isAccepted: $isAccepted, isBlocked: $isBlocked, blockers: $blockers, price: $price, rate: $rate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserObject &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.bio, bio) || other.bio == bio) &&
            (identical(other.imgUrl, imgUrl) || other.imgUrl == imgUrl) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.musicInstrument, musicInstrument) ||
                other.musicInstrument == musicInstrument) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            const DeepCollectionEquality()
                .equals(other._followers, _followers) &&
            const DeepCollectionEquality()
                .equals(other._following, _following) &&
            (identical(other.country, country) || other.country == country) &&
            (identical(other.certificate, certificate) ||
                other.certificate == certificate) &&
            const DeepCollectionEquality()
                .equals(other._certificates, _certificates) &&
            (identical(other.isAccepted, isAccepted) ||
                other.isAccepted == isAccepted) &&
            (identical(other.isBlocked, isBlocked) ||
                other.isBlocked == isBlocked) &&
            const DeepCollectionEquality().equals(other._blockers, _blockers) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.rate, rate) || other.rate == rate));
  }

  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        username,
        email,
        bio,
        imgUrl,
        uid,
        userType,
        musicInstrument,
        const DeepCollectionEquality().hash(_likes),
        const DeepCollectionEquality().hash(_followers),
        const DeepCollectionEquality().hash(_following),
        country,
        certificate,
        const DeepCollectionEquality().hash(_certificates),
        isAccepted,
        isBlocked,
        const DeepCollectionEquality().hash(_blockers),
        price,
        rate
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserObjectCopyWith<_$_UserObject> get copyWith =>
      __$$_UserObjectCopyWithImpl<_$_UserObject>(this, _$identity);
}

abstract class _UserObject implements UserObject {
  factory _UserObject(
      final String? name,
      final String? username,
      final String? email,
      final String? bio,
      final String? imgUrl,
      final String? uid,
      final String? userType,
      final String? musicInstrument,
      final List<String>? likes,
      final List<String>? followers,
      final List<String>? following,
      final String? country,
      final String? certificate,
      final List<String>? certificates,
      final bool? isAccepted,
      final bool? isBlocked,
      final List<String>? blockers,
      final String? price,
      final double? rate) = _$_UserObject;

  @override
  String? get name;
  @override
  String? get username;
  @override
  String? get email;
  @override
  String? get bio;
  @override
  String? get imgUrl;
  @override
  String? get uid;
  @override
  String? get userType;
  @override
  String? get musicInstrument;
  @override
  List<String>? get likes;
  @override
  List<String>? get followers;
  @override
  List<String>? get following;
  @override
  String? get country;
  @override
  String? get certificate;
  @override
  List<String>? get certificates;
  @override
  bool? get isAccepted;
  @override
  bool? get isBlocked;
  @override
  List<String>? get blockers;
  @override
  String? get price;
  @override
  double? get rate;
  @override
  @JsonKey(ignore: true)
  _$$_UserObjectCopyWith<_$_UserObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$PostObject {
  String? get id => throw _privateConstructorUsedError;
  String? get author => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get postImg => throw _privateConstructorUsedError;
  String? get postVideo => throw _privateConstructorUsedError;
  List<String> get likes => throw _privateConstructorUsedError;
  bool? get isLiked => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;
  List<String> get comments => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $PostObjectCopyWith<PostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PostObjectCopyWith<$Res> {
  factory $PostObjectCopyWith(
          PostObject value, $Res Function(PostObject) then) =
      _$PostObjectCopyWithImpl<$Res, PostObject>;
  @useResult
  $Res call(
      {String? id,
      String? author,
      String? title,
      String? postImg,
      String? postVideo,
      List<String> likes,
      bool? isLiked,
      DateTime date,
      List<String> comments});
}

/// @nodoc
class _$PostObjectCopyWithImpl<$Res, $Val extends PostObject>
    implements $PostObjectCopyWith<$Res> {
  _$PostObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = freezed,
    Object? title = freezed,
    Object? postImg = freezed,
    Object? postVideo = freezed,
    Object? likes = null,
    Object? isLiked = freezed,
    Object? date = null,
    Object? comments = null,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      author: freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      postImg: freezed == postImg
          ? _value.postImg
          : postImg // ignore: cast_nullable_to_non_nullable
              as String?,
      postVideo: freezed == postVideo
          ? _value.postVideo
          : postVideo // ignore: cast_nullable_to_non_nullable
              as String?,
      likes: null == likes
          ? _value.likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      isLiked: freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      comments: null == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PostObjectCopyWith<$Res>
    implements $PostObjectCopyWith<$Res> {
  factory _$$_PostObjectCopyWith(
          _$_PostObject value, $Res Function(_$_PostObject) then) =
      __$$_PostObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? author,
      String? title,
      String? postImg,
      String? postVideo,
      List<String> likes,
      bool? isLiked,
      DateTime date,
      List<String> comments});
}

/// @nodoc
class __$$_PostObjectCopyWithImpl<$Res>
    extends _$PostObjectCopyWithImpl<$Res, _$_PostObject>
    implements _$$_PostObjectCopyWith<$Res> {
  __$$_PostObjectCopyWithImpl(
      _$_PostObject _value, $Res Function(_$_PostObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? author = freezed,
    Object? title = freezed,
    Object? postImg = freezed,
    Object? postVideo = freezed,
    Object? likes = null,
    Object? isLiked = freezed,
    Object? date = null,
    Object? comments = null,
  }) {
    return _then(_$_PostObject(
      freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == author
          ? _value.author
          : author // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == postImg
          ? _value.postImg
          : postImg // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == postVideo
          ? _value.postVideo
          : postVideo // ignore: cast_nullable_to_non_nullable
              as String?,
      null == likes
          ? _value._likes
          : likes // ignore: cast_nullable_to_non_nullable
              as List<String>,
      freezed == isLiked
          ? _value.isLiked
          : isLiked // ignore: cast_nullable_to_non_nullable
              as bool?,
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
      null == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc

class _$_PostObject implements _PostObject {
  _$_PostObject(
      this.id,
      this.author,
      this.title,
      this.postImg,
      this.postVideo,
      final List<String> likes,
      this.isLiked,
      this.date,
      final List<String> comments)
      : _likes = likes,
        _comments = comments;

  @override
  final String? id;
  @override
  final String? author;
  @override
  final String? title;
  @override
  final String? postImg;
  @override
  final String? postVideo;
  final List<String> _likes;
  @override
  List<String> get likes {
    if (_likes is EqualUnmodifiableListView) return _likes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_likes);
  }

  @override
  final bool? isLiked;
  @override
  final DateTime date;
  final List<String> _comments;
  @override
  List<String> get comments {
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_comments);
  }

  @override
  String toString() {
    return 'PostObject(id: $id, author: $author, title: $title, postImg: $postImg, postVideo: $postVideo, likes: $likes, isLiked: $isLiked, date: $date, comments: $comments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PostObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.author, author) || other.author == author) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.postImg, postImg) || other.postImg == postImg) &&
            (identical(other.postVideo, postVideo) ||
                other.postVideo == postVideo) &&
            const DeepCollectionEquality().equals(other._likes, _likes) &&
            (identical(other.isLiked, isLiked) || other.isLiked == isLiked) &&
            (identical(other.date, date) || other.date == date) &&
            const DeepCollectionEquality().equals(other._comments, _comments));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      author,
      title,
      postImg,
      postVideo,
      const DeepCollectionEquality().hash(_likes),
      isLiked,
      date,
      const DeepCollectionEquality().hash(_comments));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PostObjectCopyWith<_$_PostObject> get copyWith =>
      __$$_PostObjectCopyWithImpl<_$_PostObject>(this, _$identity);
}

abstract class _PostObject implements PostObject {
  factory _PostObject(
      final String? id,
      final String? author,
      final String? title,
      final String? postImg,
      final String? postVideo,
      final List<String> likes,
      final bool? isLiked,
      final DateTime date,
      final List<String> comments) = _$_PostObject;

  @override
  String? get id;
  @override
  String? get author;
  @override
  String? get title;
  @override
  String? get postImg;
  @override
  String? get postVideo;
  @override
  List<String> get likes;
  @override
  bool? get isLiked;
  @override
  DateTime get date;
  @override
  List<String> get comments;
  @override
  @JsonKey(ignore: true)
  _$$_PostObjectCopyWith<_$_PostObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CardObject {
  String? get cardNumber => throw _privateConstructorUsedError;
  String? get cardName => throw _privateConstructorUsedError;
  String? get cardExMonth => throw _privateConstructorUsedError;
  String? get cardExYear => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CardObjectCopyWith<CardObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CardObjectCopyWith<$Res> {
  factory $CardObjectCopyWith(
          CardObject value, $Res Function(CardObject) then) =
      _$CardObjectCopyWithImpl<$Res, CardObject>;
  @useResult
  $Res call(
      {String? cardNumber,
      String? cardName,
      String? cardExMonth,
      String? cardExYear});
}

/// @nodoc
class _$CardObjectCopyWithImpl<$Res, $Val extends CardObject>
    implements $CardObjectCopyWith<$Res> {
  _$CardObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? cardName = freezed,
    Object? cardExMonth = freezed,
    Object? cardExYear = freezed,
  }) {
    return _then(_value.copyWith(
      cardNumber: freezed == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      cardName: freezed == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String?,
      cardExMonth: freezed == cardExMonth
          ? _value.cardExMonth
          : cardExMonth // ignore: cast_nullable_to_non_nullable
              as String?,
      cardExYear: freezed == cardExYear
          ? _value.cardExYear
          : cardExYear // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CardObjectCopyWith<$Res>
    implements $CardObjectCopyWith<$Res> {
  factory _$$_CardObjectCopyWith(
          _$_CardObject value, $Res Function(_$_CardObject) then) =
      __$$_CardObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? cardNumber,
      String? cardName,
      String? cardExMonth,
      String? cardExYear});
}

/// @nodoc
class __$$_CardObjectCopyWithImpl<$Res>
    extends _$CardObjectCopyWithImpl<$Res, _$_CardObject>
    implements _$$_CardObjectCopyWith<$Res> {
  __$$_CardObjectCopyWithImpl(
      _$_CardObject _value, $Res Function(_$_CardObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? cardNumber = freezed,
    Object? cardName = freezed,
    Object? cardExMonth = freezed,
    Object? cardExYear = freezed,
  }) {
    return _then(_$_CardObject(
      freezed == cardNumber
          ? _value.cardNumber
          : cardNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == cardName
          ? _value.cardName
          : cardName // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == cardExMonth
          ? _value.cardExMonth
          : cardExMonth // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == cardExYear
          ? _value.cardExYear
          : cardExYear // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_CardObject implements _CardObject {
  _$_CardObject(
      this.cardNumber, this.cardName, this.cardExMonth, this.cardExYear);

  @override
  final String? cardNumber;
  @override
  final String? cardName;
  @override
  final String? cardExMonth;
  @override
  final String? cardExYear;

  @override
  String toString() {
    return 'CardObject(cardNumber: $cardNumber, cardName: $cardName, cardExMonth: $cardExMonth, cardExYear: $cardExYear)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CardObject &&
            (identical(other.cardNumber, cardNumber) ||
                other.cardNumber == cardNumber) &&
            (identical(other.cardName, cardName) ||
                other.cardName == cardName) &&
            (identical(other.cardExMonth, cardExMonth) ||
                other.cardExMonth == cardExMonth) &&
            (identical(other.cardExYear, cardExYear) ||
                other.cardExYear == cardExYear));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, cardNumber, cardName, cardExMonth, cardExYear);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CardObjectCopyWith<_$_CardObject> get copyWith =>
      __$$_CardObjectCopyWithImpl<_$_CardObject>(this, _$identity);
}

abstract class _CardObject implements CardObject {
  factory _CardObject(final String? cardNumber, final String? cardName,
      final String? cardExMonth, final String? cardExYear) = _$_CardObject;

  @override
  String? get cardNumber;
  @override
  String? get cardName;
  @override
  String? get cardExMonth;
  @override
  String? get cardExYear;
  @override
  @JsonKey(ignore: true)
  _$$_CardObjectCopyWith<_$_CardObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$SuggestionObject {
  String? get id => throw _privateConstructorUsedError;
  String? get uid => throw _privateConstructorUsedError;
  String? get suggestion => throw _privateConstructorUsedError;
  DateTime? get dateTime => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SuggestionObjectCopyWith<SuggestionObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SuggestionObjectCopyWith<$Res> {
  factory $SuggestionObjectCopyWith(
          SuggestionObject value, $Res Function(SuggestionObject) then) =
      _$SuggestionObjectCopyWithImpl<$Res, SuggestionObject>;
  @useResult
  $Res call({String? id, String? uid, String? suggestion, DateTime? dateTime});
}

/// @nodoc
class _$SuggestionObjectCopyWithImpl<$Res, $Val extends SuggestionObject>
    implements $SuggestionObjectCopyWith<$Res> {
  _$SuggestionObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? suggestion = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      uid: freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      suggestion: freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
      dateTime: freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SuggestionObjectCopyWith<$Res>
    implements $SuggestionObjectCopyWith<$Res> {
  factory _$$_SuggestionObjectCopyWith(
          _$_SuggestionObject value, $Res Function(_$_SuggestionObject) then) =
      __$$_SuggestionObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? uid, String? suggestion, DateTime? dateTime});
}

/// @nodoc
class __$$_SuggestionObjectCopyWithImpl<$Res>
    extends _$SuggestionObjectCopyWithImpl<$Res, _$_SuggestionObject>
    implements _$$_SuggestionObjectCopyWith<$Res> {
  __$$_SuggestionObjectCopyWithImpl(
      _$_SuggestionObject _value, $Res Function(_$_SuggestionObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? uid = freezed,
    Object? suggestion = freezed,
    Object? dateTime = freezed,
  }) {
    return _then(_$_SuggestionObject(
      freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == uid
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == suggestion
          ? _value.suggestion
          : suggestion // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == dateTime
          ? _value.dateTime
          : dateTime // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc

class _$_SuggestionObject implements _SuggestionObject {
  _$_SuggestionObject(this.id, this.uid, this.suggestion, this.dateTime);

  @override
  final String? id;
  @override
  final String? uid;
  @override
  final String? suggestion;
  @override
  final DateTime? dateTime;

  @override
  String toString() {
    return 'SuggestionObject(id: $id, uid: $uid, suggestion: $suggestion, dateTime: $dateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SuggestionObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.uid, uid) || other.uid == uid) &&
            (identical(other.suggestion, suggestion) ||
                other.suggestion == suggestion) &&
            (identical(other.dateTime, dateTime) ||
                other.dateTime == dateTime));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, uid, suggestion, dateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SuggestionObjectCopyWith<_$_SuggestionObject> get copyWith =>
      __$$_SuggestionObjectCopyWithImpl<_$_SuggestionObject>(this, _$identity);
}

abstract class _SuggestionObject implements SuggestionObject {
  factory _SuggestionObject(final String? id, final String? uid,
      final String? suggestion, final DateTime? dateTime) = _$_SuggestionObject;

  @override
  String? get id;
  @override
  String? get uid;
  @override
  String? get suggestion;
  @override
  DateTime? get dateTime;
  @override
  @JsonKey(ignore: true)
  _$$_SuggestionObjectCopyWith<_$_SuggestionObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$CommentObject {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;
  String get comment => throw _privateConstructorUsedError;
  DateTime get date => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CommentObjectCopyWith<CommentObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentObjectCopyWith<$Res> {
  factory $CommentObjectCopyWith(
          CommentObject value, $Res Function(CommentObject) then) =
      _$CommentObjectCopyWithImpl<$Res, CommentObject>;
  @useResult
  $Res call({String id, String userId, String comment, DateTime date});
}

/// @nodoc
class _$CommentObjectCopyWithImpl<$Res, $Val extends CommentObject>
    implements $CommentObjectCopyWith<$Res> {
  _$CommentObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? comment = null,
    Object? date = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      comment: null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      date: null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CommentObjectCopyWith<$Res>
    implements $CommentObjectCopyWith<$Res> {
  factory _$$_CommentObjectCopyWith(
          _$_CommentObject value, $Res Function(_$_CommentObject) then) =
      __$$_CommentObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String userId, String comment, DateTime date});
}

/// @nodoc
class __$$_CommentObjectCopyWithImpl<$Res>
    extends _$CommentObjectCopyWithImpl<$Res, _$_CommentObject>
    implements _$$_CommentObjectCopyWith<$Res> {
  __$$_CommentObjectCopyWithImpl(
      _$_CommentObject _value, $Res Function(_$_CommentObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? comment = null,
    Object? date = null,
  }) {
    return _then(_$_CommentObject(
      null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
      null == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String,
      null == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime,
    ));
  }
}

/// @nodoc

class _$_CommentObject implements _CommentObject {
  _$_CommentObject(this.id, this.userId, this.comment, this.date);

  @override
  final String id;
  @override
  final String userId;
  @override
  final String comment;
  @override
  final DateTime date;

  @override
  String toString() {
    return 'CommentObject(id: $id, userId: $userId, comment: $comment, date: $date)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CommentObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.comment, comment) || other.comment == comment) &&
            (identical(other.date, date) || other.date == date));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, userId, comment, date);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CommentObjectCopyWith<_$_CommentObject> get copyWith =>
      __$$_CommentObjectCopyWithImpl<_$_CommentObject>(this, _$identity);
}

abstract class _CommentObject implements CommentObject {
  factory _CommentObject(final String id, final String userId,
      final String comment, final DateTime date) = _$_CommentObject;

  @override
  String get id;
  @override
  String get userId;
  @override
  String get comment;
  @override
  DateTime get date;
  @override
  @JsonKey(ignore: true)
  _$$_CommentObjectCopyWith<_$_CommentObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$ShopsObject {
  String? get id => throw _privateConstructorUsedError;
  GeoPoint? get geoPoint => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ShopsObjectCopyWith<ShopsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShopsObjectCopyWith<$Res> {
  factory $ShopsObjectCopyWith(
          ShopsObject value, $Res Function(ShopsObject) then) =
      _$ShopsObjectCopyWithImpl<$Res, ShopsObject>;
  @useResult
  $Res call({String? id, GeoPoint? geoPoint});
}

/// @nodoc
class _$ShopsObjectCopyWithImpl<$Res, $Val extends ShopsObject>
    implements $ShopsObjectCopyWith<$Res> {
  _$ShopsObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? geoPoint = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      geoPoint: freezed == geoPoint
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShopsObjectCopyWith<$Res>
    implements $ShopsObjectCopyWith<$Res> {
  factory _$$_ShopsObjectCopyWith(
          _$_ShopsObject value, $Res Function(_$_ShopsObject) then) =
      __$$_ShopsObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, GeoPoint? geoPoint});
}

/// @nodoc
class __$$_ShopsObjectCopyWithImpl<$Res>
    extends _$ShopsObjectCopyWithImpl<$Res, _$_ShopsObject>
    implements _$$_ShopsObjectCopyWith<$Res> {
  __$$_ShopsObjectCopyWithImpl(
      _$_ShopsObject _value, $Res Function(_$_ShopsObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? geoPoint = freezed,
  }) {
    return _then(_$_ShopsObject(
      freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == geoPoint
          ? _value.geoPoint
          : geoPoint // ignore: cast_nullable_to_non_nullable
              as GeoPoint?,
    ));
  }
}

/// @nodoc

class _$_ShopsObject implements _ShopsObject {
  _$_ShopsObject(this.id, this.geoPoint);

  @override
  final String? id;
  @override
  final GeoPoint? geoPoint;

  @override
  String toString() {
    return 'ShopsObject(id: $id, geoPoint: $geoPoint)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShopsObject &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.geoPoint, geoPoint) ||
                other.geoPoint == geoPoint));
  }

  @override
  int get hashCode => Object.hash(runtimeType, id, geoPoint);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShopsObjectCopyWith<_$_ShopsObject> get copyWith =>
      __$$_ShopsObjectCopyWithImpl<_$_ShopsObject>(this, _$identity);
}

abstract class _ShopsObject implements ShopsObject {
  factory _ShopsObject(final String? id, final GeoPoint? geoPoint) =
      _$_ShopsObject;

  @override
  String? get id;
  @override
  GeoPoint? get geoPoint;
  @override
  @JsonKey(ignore: true)
  _$$_ShopsObjectCopyWith<_$_ShopsObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$OrderObject {
  String? get orderNumber => throw _privateConstructorUsedError;
  String? get teacherName => throw _privateConstructorUsedError;
  String? get teacherId => throw _privateConstructorUsedError;
  String? get studentName => throw _privateConstructorUsedError;
  String? get studentId => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get total => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get machine => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $OrderObjectCopyWith<OrderObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderObjectCopyWith<$Res> {
  factory $OrderObjectCopyWith(
          OrderObject value, $Res Function(OrderObject) then) =
      _$OrderObjectCopyWithImpl<$Res, OrderObject>;
  @useResult
  $Res call(
      {String? orderNumber,
      String? teacherName,
      String? teacherId,
      String? studentName,
      String? studentId,
      DateTime? date,
      String? total,
      String? status,
      String? machine});
}

/// @nodoc
class _$OrderObjectCopyWithImpl<$Res, $Val extends OrderObject>
    implements $OrderObjectCopyWith<$Res> {
  _$OrderObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = freezed,
    Object? teacherName = freezed,
    Object? teacherId = freezed,
    Object? studentName = freezed,
    Object? studentId = freezed,
    Object? date = freezed,
    Object? total = freezed,
    Object? status = freezed,
    Object? machine = freezed,
  }) {
    return _then(_value.copyWith(
      orderNumber: freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherName: freezed == teacherName
          ? _value.teacherName
          : teacherName // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      studentName: freezed == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String?,
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      total: freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      machine: freezed == machine
          ? _value.machine
          : machine // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderObjectCopyWith<$Res>
    implements $OrderObjectCopyWith<$Res> {
  factory _$$_OrderObjectCopyWith(
          _$_OrderObject value, $Res Function(_$_OrderObject) then) =
      __$$_OrderObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? orderNumber,
      String? teacherName,
      String? teacherId,
      String? studentName,
      String? studentId,
      DateTime? date,
      String? total,
      String? status,
      String? machine});
}

/// @nodoc
class __$$_OrderObjectCopyWithImpl<$Res>
    extends _$OrderObjectCopyWithImpl<$Res, _$_OrderObject>
    implements _$$_OrderObjectCopyWith<$Res> {
  __$$_OrderObjectCopyWithImpl(
      _$_OrderObject _value, $Res Function(_$_OrderObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? orderNumber = freezed,
    Object? teacherName = freezed,
    Object? teacherId = freezed,
    Object? studentName = freezed,
    Object? studentId = freezed,
    Object? date = freezed,
    Object? total = freezed,
    Object? status = freezed,
    Object? machine = freezed,
  }) {
    return _then(_$_OrderObject(
      freezed == orderNumber
          ? _value.orderNumber
          : orderNumber // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == teacherName
          ? _value.teacherName
          : teacherName // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == studentName
          ? _value.studentName
          : studentName // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == total
          ? _value.total
          : total // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == machine
          ? _value.machine
          : machine // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_OrderObject implements _OrderObject {
  _$_OrderObject(
      this.orderNumber,
      this.teacherName,
      this.teacherId,
      this.studentName,
      this.studentId,
      this.date,
      this.total,
      this.status,
      this.machine);

  @override
  final String? orderNumber;
  @override
  final String? teacherName;
  @override
  final String? teacherId;
  @override
  final String? studentName;
  @override
  final String? studentId;
  @override
  final DateTime? date;
  @override
  final String? total;
  @override
  final String? status;
  @override
  final String? machine;

  @override
  String toString() {
    return 'OrderObject(orderNumber: $orderNumber, teacherName: $teacherName, teacherId: $teacherId, studentName: $studentName, studentId: $studentId, date: $date, total: $total, status: $status, machine: $machine)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderObject &&
            (identical(other.orderNumber, orderNumber) ||
                other.orderNumber == orderNumber) &&
            (identical(other.teacherName, teacherName) ||
                other.teacherName == teacherName) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.studentName, studentName) ||
                other.studentName == studentName) &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.total, total) || other.total == total) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.machine, machine) || other.machine == machine));
  }

  @override
  int get hashCode => Object.hash(runtimeType, orderNumber, teacherName,
      teacherId, studentName, studentId, date, total, status, machine);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderObjectCopyWith<_$_OrderObject> get copyWith =>
      __$$_OrderObjectCopyWithImpl<_$_OrderObject>(this, _$identity);
}

abstract class _OrderObject implements OrderObject {
  factory _OrderObject(
      final String? orderNumber,
      final String? teacherName,
      final String? teacherId,
      final String? studentName,
      final String? studentId,
      final DateTime? date,
      final String? total,
      final String? status,
      final String? machine) = _$_OrderObject;

  @override
  String? get orderNumber;
  @override
  String? get teacherName;
  @override
  String? get teacherId;
  @override
  String? get studentName;
  @override
  String? get studentId;
  @override
  DateTime? get date;
  @override
  String? get total;
  @override
  String? get status;
  @override
  String? get machine;
  @override
  @JsonKey(ignore: true)
  _$$_OrderObjectCopyWith<_$_OrderObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$RaterObject {
  String? get studentId => throw _privateConstructorUsedError;
  String? get teacherId => throw _privateConstructorUsedError;
  double? get rate => throw _privateConstructorUsedError;
  DateTime? get date => throw _privateConstructorUsedError;
  String? get comment => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $RaterObjectCopyWith<RaterObject> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RaterObjectCopyWith<$Res> {
  factory $RaterObjectCopyWith(
          RaterObject value, $Res Function(RaterObject) then) =
      _$RaterObjectCopyWithImpl<$Res, RaterObject>;
  @useResult
  $Res call(
      {String? studentId,
      String? teacherId,
      double? rate,
      DateTime? date,
      String? comment});
}

/// @nodoc
class _$RaterObjectCopyWithImpl<$Res, $Val extends RaterObject>
    implements $RaterObjectCopyWith<$Res> {
  _$RaterObjectCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? teacherId = freezed,
    Object? rate = freezed,
    Object? date = freezed,
    Object? comment = freezed,
  }) {
    return _then(_value.copyWith(
      studentId: freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      teacherId: freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      date: freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      comment: freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_RaterObjectCopyWith<$Res>
    implements $RaterObjectCopyWith<$Res> {
  factory _$$_RaterObjectCopyWith(
          _$_RaterObject value, $Res Function(_$_RaterObject) then) =
      __$$_RaterObjectCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? studentId,
      String? teacherId,
      double? rate,
      DateTime? date,
      String? comment});
}

/// @nodoc
class __$$_RaterObjectCopyWithImpl<$Res>
    extends _$RaterObjectCopyWithImpl<$Res, _$_RaterObject>
    implements _$$_RaterObjectCopyWith<$Res> {
  __$$_RaterObjectCopyWithImpl(
      _$_RaterObject _value, $Res Function(_$_RaterObject) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? studentId = freezed,
    Object? teacherId = freezed,
    Object? rate = freezed,
    Object? date = freezed,
    Object? comment = freezed,
  }) {
    return _then(_$_RaterObject(
      freezed == studentId
          ? _value.studentId
          : studentId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == teacherId
          ? _value.teacherId
          : teacherId // ignore: cast_nullable_to_non_nullable
              as String?,
      freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      freezed == date
          ? _value.date
          : date // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      freezed == comment
          ? _value.comment
          : comment // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_RaterObject implements _RaterObject {
  _$_RaterObject(
      this.studentId, this.teacherId, this.rate, this.date, this.comment);

  @override
  final String? studentId;
  @override
  final String? teacherId;
  @override
  final double? rate;
  @override
  final DateTime? date;
  @override
  final String? comment;

  @override
  String toString() {
    return 'RaterObject(studentId: $studentId, teacherId: $teacherId, rate: $rate, date: $date, comment: $comment)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RaterObject &&
            (identical(other.studentId, studentId) ||
                other.studentId == studentId) &&
            (identical(other.teacherId, teacherId) ||
                other.teacherId == teacherId) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.date, date) || other.date == date) &&
            (identical(other.comment, comment) || other.comment == comment));
  }

  @override
  int get hashCode =>
      Object.hash(runtimeType, studentId, teacherId, rate, date, comment);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RaterObjectCopyWith<_$_RaterObject> get copyWith =>
      __$$_RaterObjectCopyWithImpl<_$_RaterObject>(this, _$identity);
}

abstract class _RaterObject implements RaterObject {
  factory _RaterObject(
      final String? studentId,
      final String? teacherId,
      final double? rate,
      final DateTime? date,
      final String? comment) = _$_RaterObject;

  @override
  String? get studentId;
  @override
  String? get teacherId;
  @override
  double? get rate;
  @override
  DateTime? get date;
  @override
  String? get comment;
  @override
  @JsonKey(ignore: true)
  _$$_RaterObjectCopyWith<_$_RaterObject> get copyWith =>
      throw _privateConstructorUsedError;
}
