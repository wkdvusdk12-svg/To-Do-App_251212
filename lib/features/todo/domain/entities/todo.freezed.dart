// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'todo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ToDo {

 String get id; String get title; String? get description; bool get isFavorite; bool get isDone; DateTime? get createdAt;
/// Create a copy of ToDo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ToDoCopyWith<ToDo> get copyWith => _$ToDoCopyWithImpl<ToDo>(this as ToDo, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ToDo&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isFavorite,isDone,createdAt);

@override
String toString() {
  return 'ToDo(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isDone: $isDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ToDoCopyWith<$Res>  {
  factory $ToDoCopyWith(ToDo value, $Res Function(ToDo) _then) = _$ToDoCopyWithImpl;
@useResult
$Res call({
 String id, String title, String? description, bool isFavorite, bool isDone, DateTime? createdAt
});




}
/// @nodoc
class _$ToDoCopyWithImpl<$Res>
    implements $ToDoCopyWith<$Res> {
  _$ToDoCopyWithImpl(this._self, this._then);

  final ToDo _self;
  final $Res Function(ToDo) _then;

/// Create a copy of ToDo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isFavorite = null,Object? isDone = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ToDo].
extension ToDoPatterns on ToDo {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ToDo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ToDo() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ToDo value)  $default,){
final _that = this;
switch (_that) {
case _ToDo():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ToDo value)?  $default,){
final _that = this;
switch (_that) {
case _ToDo() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  bool isFavorite,  bool isDone,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ToDo() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isFavorite,_that.isDone,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String? description,  bool isFavorite,  bool isDone,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ToDo():
return $default(_that.id,_that.title,_that.description,_that.isFavorite,_that.isDone,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String? description,  bool isFavorite,  bool isDone,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ToDo() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.isFavorite,_that.isDone,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc


class _ToDo implements ToDo {
   _ToDo({required this.id, required this.title, this.description, this.isFavorite = false, this.isDone = false, this.createdAt});
  

@override final  String id;
@override final  String title;
@override final  String? description;
@override@JsonKey() final  bool isFavorite;
@override@JsonKey() final  bool isDone;
@override final  DateTime? createdAt;

/// Create a copy of ToDo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ToDoCopyWith<_ToDo> get copyWith => __$ToDoCopyWithImpl<_ToDo>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ToDo&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.isFavorite, isFavorite) || other.isFavorite == isFavorite)&&(identical(other.isDone, isDone) || other.isDone == isDone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}


@override
int get hashCode => Object.hash(runtimeType,id,title,description,isFavorite,isDone,createdAt);

@override
String toString() {
  return 'ToDo(id: $id, title: $title, description: $description, isFavorite: $isFavorite, isDone: $isDone, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ToDoCopyWith<$Res> implements $ToDoCopyWith<$Res> {
  factory _$ToDoCopyWith(_ToDo value, $Res Function(_ToDo) _then) = __$ToDoCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String? description, bool isFavorite, bool isDone, DateTime? createdAt
});




}
/// @nodoc
class __$ToDoCopyWithImpl<$Res>
    implements _$ToDoCopyWith<$Res> {
  __$ToDoCopyWithImpl(this._self, this._then);

  final _ToDo _self;
  final $Res Function(_ToDo) _then;

/// Create a copy of ToDo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = freezed,Object? isFavorite = null,Object? isDone = null,Object? createdAt = freezed,}) {
  return _then(_ToDo(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,isFavorite: null == isFavorite ? _self.isFavorite : isFavorite // ignore: cast_nullable_to_non_nullable
as bool,isDone: null == isDone ? _self.isDone : isDone // ignore: cast_nullable_to_non_nullable
as bool,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
