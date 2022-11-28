// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// ignore_for_file: comment_references
// ignore_for_file: cascade_invocations
// ignore_for_file: require_trailing_commas

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/material.dart' as _i5;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:lifegoals/authentication/bloc/authentication_bloc.dart' as _i3;
import 'package:lifegoals/counter/view/counter_page.dart' as _i4;
import 'package:lifegoals/data/authentication/firebase_authentication_repository.dart'
    as _i6;

/// ignore_for_file: unnecessary_lambdas
/// ignore_for_file: lines_longer_than_80_chars
extension GetItInjectableX on _i1.GetIt {
  /// initializes the registration of main-scope dependencies inside of [GetIt]
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.AuthenticationBloc>(() => _i3.AuthenticationBloc());
    gh.factory<_i4.CounterView>(() => _i4.CounterView(key: gh<_i5.Key>()));
    gh.factory<_i6.FirebaseAuthenticationRepository>(
        () => _i6.FirebaseAuthenticationRepository());
    gh.factory<_i3.LogIn>(() => _i3.LogIn());
    gh.factory<_i3.LogOut>(() => _i3.LogOut());
    return this;
  }
}