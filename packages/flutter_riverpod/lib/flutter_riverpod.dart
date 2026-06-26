import 'package:flutter/widgets.dart';

typedef Create<T> = T Function(Ref ref);
typedef NotifierCreate<N extends Notifier<T>, T> = N Function();

abstract class Ref {
  T watch<T>(ProviderListenable<T> provider);
  T read<T>(ProviderListenable<T> provider);
}

class WidgetRef implements Ref {
  WidgetRef._(this._context);

  final BuildContext _context;

  _ProviderContainer get _container =>
      ProviderScope._containerOf(_context, listen: true);

  _ProviderContainer get _readContainer =>
      ProviderScope._containerOf(_context, listen: false);

  @override
  T watch<T>(ProviderListenable<T> provider) => provider._read(_container);

  @override
  T read<T>(ProviderListenable<T> provider) => provider._read(_readContainer);
}

abstract class ProviderListenable<T> {
  const ProviderListenable();

  T _read(_ProviderContainer container);
}

class Provider<T> extends ProviderListenable<T> {
  const Provider(this._create);

  final Create<T> _create;

  @override
  T _read(_ProviderContainer container) => container.readProvider(this);
}

class FutureProvider<T> extends ProviderListenable<AsyncValue<T>> {
  const FutureProvider(this._create);

  final Future<T> Function(Ref ref) _create;

  @override
  AsyncValue<T> _read(_ProviderContainer container) =>
      container.readFutureProvider(this);
}

class NotifierProvider<N extends Notifier<T>, T>
    extends ProviderListenable<T> {
  NotifierProvider(this._create) {
    notifier = _NotifierListenable<N, T>(this);
  }

  final NotifierCreate<N, T> _create;
  late final ProviderListenable<N> notifier;

  @override
  T _read(_ProviderContainer container) =>
      container.readNotifier(this)._state as T;
}

abstract class Notifier<T> {
  late Ref ref;
  _ProviderContainer? _container;
  Object? _state;

  T build();

  T get state => _state as T;

  set state(T value) {
    _state = value;
    _container?._notifyProviderListeners();
  }
}

class AsyncValue<T> {
  const AsyncValue._({
    this.value,
    this.error,
    this.stackTrace,
    required this.isLoading,
  });

  const AsyncValue.data(T value)
      : this._(value: value, isLoading: false);

  const AsyncValue.loading() : this._(isLoading: true);

  const AsyncValue.error(Object error, StackTrace stackTrace)
      : this._(error: error, stackTrace: stackTrace, isLoading: false);

  final T? value;
  final Object? error;
  final StackTrace? stackTrace;
  final bool isLoading;

  R when<R>({
    required R Function(T value) data,
    required R Function() loading,
    required R Function(Object error, StackTrace stackTrace) error,
  }) {
    if (isLoading) {
      return loading();
    }

    final currentError = this.error;
    if (currentError != null) {
      return error(currentError, stackTrace ?? StackTrace.empty);
    }

    return data(value as T);
  }
}

class ProviderScope extends StatefulWidget {
  const ProviderScope({super.key, required this.child});

  final Widget child;

  static _ProviderContainer _containerOf(
    BuildContext context, {
    required bool listen,
  }) {
    final scope = listen
        ? context.dependOnInheritedWidgetOfExactType<_ProviderScope>()
        : context.getInheritedWidgetOfExactType<_ProviderScope>();

    assert(scope != null, 'ProviderScope was not found in the widget tree.');
    return scope!.container;
  }

  @override
  State<ProviderScope> createState() => _ProviderScopeState();
}

class _ProviderScopeState extends State<ProviderScope> {
  final _ProviderContainer _container = _ProviderContainer();

  @override
  void dispose() {
    _container.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _ProviderScope(
      container: _container,
      child: widget.child,
    );
  }
}

class _ProviderScope extends InheritedNotifier<_ProviderContainer> {
  const _ProviderScope({
    required this.container,
    required super.child,
  }) : super(notifier: container);

  final _ProviderContainer container;
}

abstract class ConsumerWidget extends ConsumerStatefulWidget {
  const ConsumerWidget({super.key});

  Widget build(BuildContext context, WidgetRef ref);

  @override
  State<ConsumerWidget> createState() => _ConsumerWidgetState();
}

class _ConsumerWidgetState extends ConsumerState<ConsumerWidget> {
  @override
  Widget build(BuildContext context) => widget.build(context, ref);
}

abstract class ConsumerStatefulWidget extends StatefulWidget {
  const ConsumerStatefulWidget({super.key});
}

abstract class ConsumerState<T extends ConsumerStatefulWidget>
    extends State<T> {
  late WidgetRef ref;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    ref = WidgetRef._(context);
  }
}

class _NotifierListenable<N extends Notifier<T>, T>
    extends ProviderListenable<N> {
  const _NotifierListenable(this._provider);

  final NotifierProvider<N, T> _provider;

  @override
  N _read(_ProviderContainer container) => container.readNotifier(_provider);
}

class _ProviderContainer extends ChangeNotifier implements Ref {
  final Map<Object, Object?> _values = {};
  final Map<Object, Notifier<Object?>> _notifiers = {};

  @override
  T watch<T>(ProviderListenable<T> provider) => provider._read(this);

  @override
  T read<T>(ProviderListenable<T> provider) => provider._read(this);

  T readProvider<T>(Provider<T> provider) {
    if (!_values.containsKey(provider)) {
      _values[provider] = provider._create(this);
    }

    return _values[provider] as T;
  }

  AsyncValue<T> readFutureProvider<T>(FutureProvider<T> provider) {
    if (!_values.containsKey(provider)) {
      _values[provider] = AsyncValue<T>.loading();
      provider._create(this).then(
        (value) {
          _values[provider] = AsyncValue<T>.data(value);
          _notifyProviderListeners();
        },
        onError: (Object error, StackTrace stackTrace) {
          _values[provider] = AsyncValue<T>.error(error, stackTrace);
          _notifyProviderListeners();
        },
      );
    }

    return _values[provider] as AsyncValue<T>;
  }

  N readNotifier<N extends Notifier<T>, T>(
    NotifierProvider<N, T> provider,
  ) {
    final existing = _notifiers[provider];
    if (existing != null) {
      return existing as N;
    }

    final notifier = provider._create()
      ..ref = this
      .._container = this;
    notifier._state = notifier.build();
    _notifiers[provider] = notifier as Notifier<Object?>;

    return notifier;
  }

  void _notifyProviderListeners() {
    notifyListeners();
  }
}
