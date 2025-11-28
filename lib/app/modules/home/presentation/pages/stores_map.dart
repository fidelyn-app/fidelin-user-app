import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';

class StoresMapPage extends StatefulWidget {
  const StoresMapPage({super.key});

  @override
  State<StoresMapPage> createState() => _StoresMapPageState();
}

class _StoresMapPageState extends State<StoresMapPage> {
  MapboxMap? mapboxMap;
  PointAnnotationManager? pointAnnotationManager;
  geo.Position? userPosition;
  PointAnnotation? userLocationAnnotation;
  PointAnnotation? randomTileAnnotation;
  double? randomTileLat;
  double? randomTileLon;
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    geo.LocationPermission permission = await geo.Geolocator.checkPermission();
    if (permission == geo.LocationPermission.denied) {
      permission = await geo.Geolocator.requestPermission();
      if (permission == geo.LocationPermission.denied) {
        return;
      }
    }

    if (permission == geo.LocationPermission.deniedForever) {
      return;
    }

    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      geo.Position position = await geo.Geolocator.getCurrentPosition(
        desiredAccuracy: geo.LocationAccuracy.high,
      );
      setState(() {
        userPosition = position;
      });
      if (mapboxMap != null) {
        await _setupMap();
      }
    } catch (e) {
      debugPrint('Erro ao obter localização: $e');
    }
  }

  Future<void> _setupMap() async {
    if (mapboxMap == null || userPosition == null) return;

    // Inicializa o PointAnnotationManager
    pointAnnotationManager =
        await mapboxMap!.annotations.createPointAnnotationManager();

    // Move a câmera para a localização do usuário
    await mapboxMap!.flyTo(
      CameraOptions(
        center: Point(
          coordinates: Position(
            userPosition!.longitude,
            userPosition!.latitude,
          ),
        ),
        zoom: 14.0,
      ),
      MapAnimationOptions(duration: 1000),
    );

    // Adiciona marcador da localização do usuário
    await _addUserLocationMarker();

    // Adiciona um marcador aleatório
    await _addRandomTileMarker();

    // Listener para cliques no mapa usando GestureDetector wrapper
  }

  Future<void> _addUserLocationMarker() async {
    if (pointAnnotationManager == null || userPosition == null) return;

    final annotation = PointAnnotationOptions(
      geometry: Point(
        coordinates: Position(userPosition!.longitude, userPosition!.latitude),
      ),
      image: await _createLocationIcon(const Color.fromARGB(255, 0, 122, 255)),
    );

    userLocationAnnotation = await pointAnnotationManager!.create(annotation);
  }

  Future<Uint8List> _createLocationIcon(Color color) async {
    const size = 48.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = color;

    // Desenha um círculo preenchido
    canvas.drawCircle(const Offset(size / 2, size / 2), size / 3, paint);

    // Desenha um círculo branco interno
    canvas.drawCircle(
      const Offset(size / 2, size / 2),
      size / 6,
      Paint()..color = Colors.white,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  Future<void> _addRandomTileMarker() async {
    if (pointAnnotationManager == null || userPosition == null) return;

    // Gera uma posição aleatória próxima ao usuário (raio de ~1km)
    final latOffset = (_random.nextDouble() - 0.5) * 0.02; // ~2km
    final lonOffset = (_random.nextDouble() - 0.5) * 0.02;

    randomTileLat = userPosition!.latitude + latOffset;
    randomTileLon = userPosition!.longitude + lonOffset;

    final annotation = PointAnnotationOptions(
      geometry: Point(coordinates: Position(randomTileLon!, randomTileLat!)),
      image: await _createTileIcon(Colors.red),
    );

    randomTileAnnotation = await pointAnnotationManager!.create(annotation);
  }

  Future<Uint8List> _createTileIcon(Color color) async {
    const size = 48.0;
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    final paint = Paint()..color = color;

    // Desenha um pin (alfinete)
    final path =
        Path()
          ..moveTo(size / 2, 0)
          ..lineTo(size * 0.2, size * 0.6)
          ..quadraticBezierTo(size / 2, size * 0.7, size * 0.8, size * 0.6)
          ..close();

    canvas.drawPath(path, paint);

    // Círculo branco no topo
    canvas.drawCircle(
      const Offset(size / 2, size * 0.3),
      size * 0.15,
      Paint()..color = Colors.white,
    );

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    return byteData!.buffer.asUint8List();
  }

  void _handleMapTap(ScreenCoordinate coordinate) async {
    if (mapboxMap == null) return;

    try {
      // Converte coordenada da tela para coordenada geográfica
      final coordinateGeo = await mapboxMap!.coordinateForPixel(coordinate);
      final coords = coordinateGeo.coordinates;
      // Position do Mapbox é uma lista [longitude, latitude], então acessamos por índices
      final clickLat = coords[1]?.toDouble() ?? 0.0; // latitude
      final clickLon = coords[0]?.toDouble() ?? 0.0; // longitude

      // Verifica se o clique foi próximo ao marcador aleatório
      if (randomTileAnnotation != null &&
          randomTileLat != null &&
          randomTileLon != null) {
        final distance = _calculateDistance(
          clickLat,
          clickLon,
          randomTileLat!,
          randomTileLon!,
        );

        // Se o clique foi dentro de ~50 metros do marcador, mostra o diálogo
        if (distance < 0.05) {
          _showTileInfoDialog();
          return;
        }
      }

      // Verifica se o clique foi próximo ao marcador do usuário
      if (userPosition != null && userLocationAnnotation != null) {
        final distance = _calculateDistance(
          clickLat,
          clickLon,
          userPosition!.latitude,
          userPosition!.longitude,
        );

        if (distance < 0.05) {
          _showUserLocationInfo();
        }
      }
    } catch (e) {
      debugPrint('Erro ao processar clique no mapa: $e');
    }
  }

  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    return geo.Geolocator.distanceBetween(lat1, lon1, lat2, lon2) /
        1000; // retorna em km
  }

  void _showTileInfoDialog() {
    if (randomTileLat == null || randomTileLon == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Informações do Ponto'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Este é um ponto de interesse aleatório.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Localização:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Lat: ${randomTileLat!.toStringAsFixed(6)}\n'
                'Lon: ${randomTileLon!.toStringAsFixed(6)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  void _showUserLocationInfo() {
    if (userPosition == null) return;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Sua Localização'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Esta é sua localização atual.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 12),
              Text(
                'Coordenadas:',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor,
                ),
              ),
              Text(
                'Lat: ${userPosition!.latitude.toStringAsFixed(6)}\n'
                'Lon: ${userPosition!.longitude.toStringAsFixed(6)}',
                style: const TextStyle(fontSize: 14),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Fechar'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mapa de Lojas')),
      body: GestureDetector(
        onTapDown: (details) async {
          if (mapboxMap != null) {
            final coordinate = ScreenCoordinate(
              x: details.globalPosition.dx,
              y: details.globalPosition.dy,
            );
            _handleMapTap(coordinate);
          }
        },
        child: MapWidget(
          onMapCreated: (mapController) async {
            mapboxMap = mapController;
            if (userPosition != null) {
              await _setupMap();
            }
          },
        ),
      ),
    );
  }
}
