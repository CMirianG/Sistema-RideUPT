// lib/providers/trip_provider.dart (ACTUALIZADO)
import 'package:flutter/material.dart';
import 'package:rideupt_app/api/api_service.dart';
import 'package:rideupt_app/models/trip.dart';
import 'package:rideupt_app/providers/auth_provider.dart';

class TripProvider with ChangeNotifier {
  final AuthProvider? _authProvider;
  final ApiService _apiService = ApiService();

  TripProvider(this._authProvider);

  List<Trip> _availableTrips = [];
  List<Trip> _myTrips = []; // Lista para "Mis Viajes"
  bool _isLoading = false;
  String _errorMessage = '';

  List<Trip> get availableTrips => _availableTrips;
  List<Trip> get myTrips => _myTrips;
  // Viajes activos: incluye viajes en proceso, activos (esperando) y completos (llenos)
  List<Trip> get activeMyTrips => _myTrips.where((trip) {
    final status = trip.status;
    // Incluir viajes en proceso
    if (status == 'en-proceso') return !trip.isCancelled;
    // Incluir viajes esperando (si no han expirado por tiempo)
    if (status == 'esperando') {
      if (trip.expiresAt != null) {
        return !trip.isCancelled && DateTime.now().isBefore(trip.expiresAt!);
      }
      return !trip.isCancelled;
    }
    // Incluir viajes completos (llenos)
    if (status == 'completo') return !trip.isCancelled;
    return false;
  }).toList();
  
  // Viajes completados: solo los que tienen estado 'completado' o 'completed'
  // NO verificar isExpired porque los completados pueden tener expiresAt pasado
  List<Trip> get completedMyTrips => _myTrips.where((trip) => 
    trip.isCompleted && !trip.isCancelled
  ).toList();
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  String? get _token => _authProvider?.token;

  Future<void> fetchAvailableTrips() async {
    if (_token == null || _isDisposed) return;
    _setLoading(true);
    _errorMessage = '';
    try {
      final response = await _apiService.get('trips', _token!);
      if (_isDisposed) return;
      
      if (response is List) {
        _availableTrips = response
            .map((data) => Trip.fromJson(data as Map<String, dynamic>))
            .toList();
        _errorMessage = '';
        notifyListeners();
      } else {
        _errorMessage = 'Error al obtener viajes: respuesta inválida';
        _availableTrips = [];
      }
    } catch (e) {
      if (!_isDisposed) {
        _errorMessage = _extractErrorMessage(e);
        _availableTrips = [];
      }
    } finally {
      if (!_isDisposed) {
        _setLoading(false);
        notifyListeners();
      }
    }
  }
  
  /// Extrae el mensaje de error de forma consistente
  String _extractErrorMessage(dynamic error) {
    final errorString = error.toString();
    if (errorString.contains('HttpException: ')) {
      return errorString.replaceAll('HttpException: ', '');
    }
    if (errorString.contains('SocketException: ')) {
      return 'Error de conexión. Verifica tu conexión a Internet.';
    }
    if (errorString.contains('TimeoutException')) {
      return 'Tiempo de espera agotado. Intenta de nuevo.';
    }
    if (errorString.contains('FormatException')) {
      return 'Error al procesar la respuesta del servidor.';
    }
    return errorString.replaceAll('Exception: ', '');
  }

  // --- ¡NUEVA FUNCIÓN! ---
  DateTime? _lastFetchMyTrips;
  static const Duration _fetchMyTripsThrottle = Duration(seconds: 5);
  
  Future<void> fetchMyTrips({bool force = false}) async {
    if (_token == null || _isDisposed) return;
    
    // Throttle: evitar llamadas muy frecuentes
    if (!force && _lastFetchMyTrips != null) {
      final timeSinceLastFetch = DateTime.now().difference(_lastFetchMyTrips!);
      if (timeSinceLastFetch < _fetchMyTripsThrottle) {
        return; // Saltar esta llamada si fue muy reciente
      }
    }
    
    _lastFetchMyTrips = DateTime.now();
    
    final isDriver = _authProvider?.user?.role == 'driver';
    final endpoint = isDriver ? 'trips/my-driver-trips' : 'trips/my-passenger-trips';
    
    try {
      final response = await _apiService.get(endpoint, _token!);
      
      // Verificar si fue disposed durante la llamada
      if (_isDisposed) return;
      
      // Verificar que la respuesta sea una lista
      if (response is! List) {
        // Log solo en modo debug
        // debugPrint('ERROR: Respuesta no es una lista, es: ${response.runtimeType}');
        if (!_isDisposed) {
          _myTrips = [];
          _errorMessage = 'Error al obtener viajes';
          notifyListeners();
        }
        return;
      }
      
      if (!_isDisposed) {
        final List<dynamic> tripData = response;
        _myTrips = tripData.map((data) => Trip.fromJson(data as Map<String, dynamic>)).toList();
        
        // Log solo en modo debug y solo el conteo
        // debugPrint('✅ fetchMyTrips: ${_myTrips.length} viajes');
        
        _errorMessage = '';
        notifyListeners();
      }
    } catch (e) {
      if (_isDisposed) return;
      
      _errorMessage = _extractErrorMessage(e);
      if (!_isDisposed) {
        _myTrips = [];
        notifyListeners();
      }
    }
  }

  // Verificar si hay viajes completados sin calificar (para pasajeros)
  Future<Trip?> getUnratedCompletedTrip() async {
    if (_authProvider?.user?.role != 'passenger') return null;
    
    final currentUserId = _authProvider?.user?.id;
    if (currentUserId == null) return null;
    
    // Buscar viajes completados donde el usuario es pasajero confirmado
    for (final trip in completedMyTrips) {
      final isPassenger = trip.passengers.any(
        (p) => p.user.id == currentUserId && p.status == 'confirmed'
      );
      
      if (isPassenger) {
        // Verificar si ya calificó al conductor
        // Esto se verificará en el frontend usando RatingService
        return trip;
      }
    }
    
    return null;
  }

  // --- ¡NUEVA FUNCIÓN! ---
  Future<bool> bookTrip(String tripId) async {
    if (_token == null || _isDisposed) return false;
    _setLoading(true);
    try {
      await _apiService.post('trips/$tripId/book', _token!, {});
      if (_isDisposed) return false;
      // Después de reservar, actualizamos la lista de "mis viajes"
      await fetchMyTrips(force: true);
      if (!_isDisposed) {
        _setLoading(false);
      }
      return !_isDisposed;
    } catch (e) {
      if (!_isDisposed) {
        _errorMessage = _extractErrorMessage(e);
        _setLoading(false);
        notifyListeners();
      }
      return false;
    }
  }

  // Obtener detalles de un viaje por ID (incluye pasajeros)
  Future<Trip?> fetchTripById(String tripId) async {
    if (_token == null) return null;
    try {
      final data = await _apiService.get('trips/$tripId', _token!);
      return Trip.fromJson(data as Map<String, dynamic>);
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      return null;
    }
  }

  // Conductor acepta/rechaza solicitud
  Future<bool> manageBooking({required String tripId, required String passengerId, required String status}) async {
    if (_token == null) return false;
    _setLoading(true);
    try {
      await _apiService.put('trips/$tripId/bookings/$passengerId', _token!, {'status': status});
      await fetchMyTrips(force: true);
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  Future<bool> createTrip(Map<String, dynamic> tripData) async {
    if (_token == null) return false;
    _setLoading(true);
    _errorMessage = '';
    
    try {
      final createdTripData = await _apiService.post('trips', _token!, tripData);
      final newTrip = Trip.fromJson(createdTripData);

      // Actualizar myTrips inmediatamente agregando el nuevo viaje
      _myTrips.insert(0, newTrip);
      notifyListeners();
      
      // Luego actualizar desde el servidor
      await fetchMyTrips(force: true);
      await fetchAvailableTrips();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // --- NUEVAS FUNCIONES PARA GESTIÓN DE VIAJES ---
  
  // Iniciar viaje (conductor)
  Future<bool> startTrip(String tripId) async {
    if (_token == null) return false;
    _setLoading(true);
    _errorMessage = '';
    
    try {
      await _apiService.put('trips/$tripId/start', _token!, {});
      
      // Actualizar lista de mis viajes
      await fetchMyTrips(force: true);
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Cancelar viaje (conductor)
  Future<bool> cancelTrip(String tripId, {String? cancellationReason}) async {
    if (_token == null) return false;
    _setLoading(true);
    _errorMessage = '';
    
    try {
      // El backend espera PUT, no DELETE
      final Map<String, dynamic> body = cancellationReason != null && cancellationReason.isNotEmpty
          ? {'cancellationReason': cancellationReason}
          : <String, dynamic>{};
      
      await _apiService.put('trips/$tripId/cancel', _token!, body);
      
      // Actualizar lista de mis viajes y viajes disponibles
      await fetchMyTrips(force: true);
      await fetchAvailableTrips();
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Salir del viaje (pasajero)
  Future<bool> leaveTrip(String tripId) async {
    if (_token == null) return false;
    _setLoading(true);
    _errorMessage = '';
    
    try {
      await _apiService.delete('trips/$tripId/leave', _token!);
      
      // Actualizar lista de mis viajes
      await fetchMyTrips(force: true);
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  // Finalizar viaje (conductor)
  Future<bool> completeTrip(String tripId) async {
    if (_token == null) return false;
    _setLoading(true);
    _errorMessage = '';
    
    try {
      await _apiService.put('trips/$tripId/complete', _token!, {});
      
      // Actualizar lista de mis viajes
      await fetchMyTrips(force: true);
      
      _setLoading(false);
      return true;
    } catch (e) {
      _errorMessage = _extractErrorMessage(e);
      _setLoading(false);
      notifyListeners();
      return false;
    }
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  /// Limpia todos los viajes del estado (útil cuando se cambia de rol)
  void clearTrips() {
    _availableTrips = [];
    _myTrips = [];
    _lastFetchMyTrips = null;
    _errorMessage = '';
    if (!_isDisposed) {
      notifyListeners();
    }
  }

  bool _isDisposed = false;

  @override
  void dispose() {
    _isDisposed = true;
    super.dispose();
  }
}