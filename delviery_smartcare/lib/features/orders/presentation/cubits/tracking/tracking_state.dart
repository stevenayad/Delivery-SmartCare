part of 'tracking_cubit_cubit.dart';
enum TrackingPhase {
  toStore,
  toUser,
  completed,
}
class TrackingState {
  final LatLng driverPosition;
  final LatLng store;
  final LatLng user;
  final TrackingPhase phase;
  final double remainingDistance;
  final bool isLoading;
  final String? errorMessage;

  TrackingState({
    required this.driverPosition,
    required this.store,
    required this.user,
    required this.phase,
    required this.remainingDistance,
    this.isLoading = false,
    this.errorMessage,
  });

  TrackingState copyWith({
    LatLng? driverPosition,
    LatLng? store,
    LatLng? user,
    TrackingPhase? phase,
    double? remainingDistance,
    bool? isLoading,
    String? errorMessage,
    bool clearError = false,
  }) {
    return TrackingState(
      driverPosition: driverPosition ?? this.driverPosition,
      store: store ?? this.store,
      user: user ?? this.user,
      phase: phase ?? this.phase,
      remainingDistance: remainingDistance ?? this.remainingDistance,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
    );
  }
}