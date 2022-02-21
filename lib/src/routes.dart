part of 'services.dart';

class MFRoutesService {
  /// Get router.
  Future<MFDirectionsResult> fetchDirections(
    MFLocationComponent origin,
    MFLocationComponent destination, {
    List<MFLocationComponent>? waypoints,
    MFTravelMode mode = MFTravelMode.car,
    MFRouteWeighting weighting = MFRouteWeighting.fastest,
    MFLanguageResult language = MFLanguageResult.vi,
    MFRouteRestriction? restriction,
  }) async {
    final Map<String, Object> data = <String, Object>{
      'origin': origin.toJson(),
      'destination': destination.toJson(),
      'mode': mode.index,
      'weighting': weighting.index,
      'language': language.index,
    };

    if (waypoints != null) {
      data['points'] = locationsToJson(waypoints);
    }
    if (restriction != null) {
      data['restriction'] = restriction.toJson();
    }

    final response = await _ServicesChannel.invokeService('route#route', data);
    validateResponse(response);

    return DirectionsResult.fromMap(response!['result'])!;
  }

  /// Estimated time of arrival.
  Future<List<MFRouteETAResult>> fetchRouteETA(
    List<MFLocationComponent> origins,
    MFLocationComponent destination, {
    MFTravelMode mode = MFTravelMode.car,
    MFRouteWeighting weighting = MFRouteWeighting.fastest,
    MFLanguageResult language = MFLanguageResult.vi,
    MFRouteRestriction? restriction,
  }) async {
    final Map<String, Object> data = <String, Object>{
      'origins': locationsToJson(origins),
      'destination': destination.toJson(),
      'mode': mode.index,
      'weighting': weighting.index,
      'language': language.index,
    };

    if (restriction != null) {
      data['restriction'] = restriction.toJson();
    }

    final response = await _ServicesChannel.invokeService('route#eta', data);
    validateResponse(response);

    return toListRouteETA(response!['result']);
  }

  /// The Distance Matrix API is a service that provides travel distance and time for a matrix of origins and destinations.
  Future<MFDistanceMatrixResult> fetchDistanceMatrix(
    List<MFLocationComponent> origins,
    List<MFLocationComponent> destinations, {
    MFTravelMode mode = MFTravelMode.car,
    MFRouteWeighting weighting = MFRouteWeighting.fastest,
    MFLanguageResult language = MFLanguageResult.vi,
    MFRouteRestriction? restriction,
  }) async {
    final Map<String, Object> data = <String, Object>{
      'origins': locationsToJson(origins),
      'destinations': locationsToJson(destinations),
      'mode': mode.index,
      'weighting': weighting.index,
      'language': language.index,
    };

    if (restriction != null) {
      data['restriction'] = restriction.toJson();
    }

    final response = await _ServicesChannel.invokeService('route#matrix', data);
    validateResponse(response);

    return DistanceMatrixResult.fromMap(response!['result'])!;
  }

  /// Graph route.
  Future<List<MFGraphRouteResult>> fetchGraphRoute(
    List<MFLocationComponent> locations, {
    MFTravelMode mode = MFTravelMode.car,
    MFRouteWeighting weighting = MFRouteWeighting.fastest,
    MFLanguageResult language = MFLanguageResult.vi,
    MFRouteRestriction? restriction,
  }) async {
    final Map<String, Object> data = <String, Object>{
      'points': locationsToJson(locations),
      'mode': mode.index,
      'weighting': weighting.index,
      'language': language.index,
    };

    if (restriction != null) {
      data['restriction'] = restriction.toJson();
    }

    final response = await _ServicesChannel.invokeService('route#graph', data);
    validateResponse(response);

    return toListGraphRoute(response!['result']);
  }
}
