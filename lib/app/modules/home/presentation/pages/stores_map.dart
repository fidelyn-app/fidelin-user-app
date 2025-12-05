import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart' as geo;
import 'package:mapbox_maps_flutter/mapbox_maps_flutter.dart';
import 'package:fidelyn_user_app/app/modules/home/domain/entities/store_entity.dart';
import 'package:fidelyn_user_app/utils/entity_generator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:http/http.dart' as http;

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
  
  // Lista de stores e annotations
  final List<Store> stores = [];
  final List<PointAnnotation> storeAnnotations = [];
  
  // Controle do botão de pesquisa
  bool showSearchButton = false;
  double currentZoom = 14.0;
  Point? lastCameraCenter;
  Timer? _cameraCheckTimer;
  
  // Constantes
  static const int numberOfStores = 20;
  static const double minZoomForStores = 12.0; // Zoom mínimo para mostrar stores (zoom out muito alto = zoom baixo)
  
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    _requestLocationPermission();
  }

  @override
  void dispose() {
    _cameraCheckTimer?.cancel();
    super.dispose();
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

    // Carrega stores iniciais
    await _loadStoresForCurrentView();

    // Inicia verificação periódica da câmera
    _startCameraMonitoring();
  }

  void _startCameraMonitoring() {
    _cameraCheckTimer?.cancel();
    _cameraCheckTimer = Timer.periodic(const Duration(milliseconds: 500), (timer) async {
      if (mapboxMap == null) return;

      try {
        final cameraState = await mapboxMap!.getCameraState();
        final zoom = cameraState.zoom;
        final center = cameraState.center;

        final previousZoom = currentZoom;
        final previousCenter = lastCameraCenter;

        // Verifica se houve mudança significativa
        final zoomChanged = (zoom - previousZoom).abs() > 0.1;
        final centerChanged = previousCenter == null ||
            (center.coordinates[0]?.toDouble() ?? 0.0) != (previousCenter.coordinates[0]?.toDouble() ?? 0.0) ||
            (center.coordinates[1]?.toDouble() ?? 0.0) != (previousCenter.coordinates[1]?.toDouble() ?? 0.0);

        if (zoomChanged || centerChanged) {
          setState(() {
            currentZoom = zoom;
            lastCameraCenter = center;
            // Mostra o botão se o zoom for adequado e houve movimento
            showSearchButton = zoom >= minZoomForStores && centerChanged;
          });

          // Se o zoom estiver muito baixo, remove os stores
          if (zoom < minZoomForStores) {
            await _clearStores();
          }
        }
      } catch (e) {
        debugPrint('Erro ao verificar câmera: $e');
      }
    });
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
    const size = 64.0;
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

  Future<void> _loadStoresForCurrentView() async {
    if (pointAnnotationManager == null || userPosition == null) return;
    if (currentZoom < minZoomForStores) return;

    // Limpa stores anteriores
    await _clearStores();

    // Gera 20 stores com posições aleatórias
    for (int i = 0; i < numberOfStores; i++) {
      final store = EntityGenerator.generateStore();
      
      // Gera uma posição aleatória próxima ao usuário (raio de ~5km)
      final latOffset = (_random.nextDouble() - 0.5) * 0.05; // ~5km
      final lonOffset = (_random.nextDouble() - 0.5) * 0.05;

      final storeLat = userPosition!.latitude + latOffset;
      final storeLon = userPosition!.longitude + lonOffset;

      // Cria o pin com imagem da loja
      final imageUrl = store.avatarUrl ?? 
          'https://picsum.photos/seed/${store.id}/200';

        try {
          final annotation = PointAnnotationOptions(
            geometry: Point(coordinates: Position(storeLon, storeLat)),
            image: await _createStorePinIcon(imageUrl, store),
          );

          final createdAnnotation = await pointAnnotationManager!.create(annotation);
          
          // Armazena a store e a annotation
          stores.add(store);
          storeAnnotations.add(createdAnnotation);
        } catch (e) {
          debugPrint('Erro ao criar annotation para store ${store.id}: $e');
        }
    }
  }

  Future<void> _clearStores() async {
    if (pointAnnotationManager == null) return;
    
    // Remove todas as annotations
    for (final annotation in storeAnnotations) {
      try {
        await pointAnnotationManager!.delete(annotation);
      } catch (e) {
        debugPrint('Erro ao deletar annotation: $e');
      }
    }
    
    // Limpa as listas
    stores.clear();
    storeAnnotations.clear();
  }

  Future<void> _searchInCurrentArea() async {
    if (mapboxMap == null || lastCameraCenter == null) return;
    
    setState(() {
      showSearchButton = false;
    });

    // Atualiza a posição do usuário para o centro da câmera atual
    // (simulando que estamos pesquisando na área visível)
    final coords = lastCameraCenter!.coordinates;
    userPosition = geo.Position(
      latitude: coords[1]?.toDouble() ?? userPosition?.latitude ?? 0.0,
      longitude: coords[0]?.toDouble() ?? userPosition?.longitude ?? 0.0,
      timestamp: DateTime.now(),
      accuracy: 0.0,
      altitude: 0.0,
      altitudeAccuracy: 0.0,
      heading: 0.0,
      headingAccuracy: 0.0,
      speed: 0.0,
      speedAccuracy: 0.0,
    );

    // Carrega stores para a nova área
    await _loadStoresForCurrentView();
  }

  Future<Uint8List> _createStorePinIcon(String imageUrl, Store store) async {
    // Usa potência de 2 para compatibilidade com Mapbox (128 = 2^7)
    const size = 128.0;
    const circleRadius = size * 0.4; // Círculo maior, centralizado
    
    final recorder = ui.PictureRecorder();
    final canvas = Canvas(recorder);
    
    final centerX = size / 2;
    final centerY = size / 2;

    // Carrega e desenha a imagem dentro do círculo
    try {
      final response = await http.get(Uri.parse(imageUrl));
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final codec = await ui.instantiateImageCodec(bytes);
        final frame = await codec.getNextFrame();
        final storeImage = frame.image;

        // Cria um círculo para clipar a imagem
        final clipPath = Path()
          ..addOval(Rect.fromCircle(
            center: Offset(centerX, centerY),
            radius: circleRadius,
          ));

        canvas.save();
        canvas.clipPath(clipPath);

        // Desenha a imagem dentro do círculo
        final imageRect = Rect.fromCircle(
          center: Offset(centerX, centerY),
          radius: circleRadius,
        );
        
        canvas.drawImageRect(
          storeImage,
          Rect.fromLTWH(0, 0, storeImage.width.toDouble(), storeImage.height.toDouble()),
          imageRect,
          Paint(),
        );
        
        canvas.restore();

        // Borda branca ao redor da imagem
        canvas.drawCircle(
          Offset(centerX, centerY),
          circleRadius,
          Paint()
            ..color = Colors.white
            ..style = PaintingStyle.stroke
            ..strokeWidth = 4,
        );
      }
    } catch (e) {
      debugPrint('Erro ao carregar imagem da loja: $e');
      // Se falhar, desenha um círculo com inicial
      final initial = store.businessName.isNotEmpty
          ? store.businessName[0].toUpperCase()
          : '?';
      
      final textPainter = TextPainter(
        text: TextSpan(
          text: initial,
          style: TextStyle(
            color: Colors.white,
            fontSize: circleRadius * 0.6,
            fontWeight: FontWeight.bold,
          ),
        ),
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      
      canvas.drawCircle(
        Offset(centerX, centerY),
        circleRadius,
        Paint()..color = Colors.grey,
      );
      
      textPainter.paint(
        canvas,
        Offset(
          centerX - textPainter.width / 2,
          centerY - textPainter.height / 2,
        ),
      );
    }

    final picture = recorder.endRecording();
    final image = await picture.toImage(size.toInt(), size.toInt());
    final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
    
    if (byteData == null) {
      throw Exception('Falha ao converter imagem para bytes');
    }
    
    // Garante que o tamanho seja válido (potência de 2)
    final imageSize = size.toInt();
    if (imageSize <= 0 || (imageSize & (imageSize - 1)) != 0) {
      throw Exception('Tamanho da imagem deve ser uma potência de 2');
    }
    
    return byteData.buffer.asUint8List();
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

      // Verifica se o clique foi próximo a algum store
      for (int i = 0; i < storeAnnotations.length && i < stores.length; i++) {
        final annotation = storeAnnotations[i];
        final store = stores[i];
        
        try {
          // Obtém a posição da annotation
          final annotationGeometry = annotation.geometry;
          final annotationCoords = annotationGeometry.coordinates;
          final annotationLat = annotationCoords[1]?.toDouble() ?? 0.0;
          final annotationLon = annotationCoords[0]?.toDouble() ?? 0.0;
          
          final distance = _calculateDistance(
            clickLat,
            clickLon,
            annotationLat,
            annotationLon,
          );

          // Se o clique foi dentro de ~50 metros do marcador, mostra o diálogo
          if (distance < 0.05) {
            _showStoreInfoDialog(store);
            return;
          }
        } catch (e) {
          debugPrint('Erro ao verificar clique no store: $e');
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

  void _showStoreInfoDialog(Store store) {

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Container(
            constraints: const BoxConstraints(maxWidth: 350),
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Imagem da loja
                if (store.avatarUrl != null)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: CachedNetworkImage(
                      imageUrl: store.avatarUrl!,
                      width: double.infinity,
                      height: 150,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Center(
                          child: CircularProgressIndicator(),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        height: 150,
                        color: Colors.grey[200],
                        child: const Icon(Icons.store, size: 50),
                      ),
                    ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 150,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.store, size: 50, color: Colors.grey),
                  ),
                const SizedBox(height: 16),
                // Nome da loja
                Text(
                  store.businessName,
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).primaryColor,
                  ),
                ),
                if (store.legalName != null) ...[
                  const SizedBox(height: 4),
                  Text(
                    store.legalName!,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                // Informações de contato
                if (store.phone != null) ...[
                  _buildInfoRow(
                    Icons.phone,
                    store.phone!,
                    context,
                  ),
                  const SizedBox(height: 8),
                ],
                if (store.email.isNotEmpty) ...[
                  _buildInfoRow(
                    Icons.email,
                    store.email,
                    context,
                  ),
                  const SizedBox(height: 8),
                ],
                if (store.contacts.instagram != null) ...[
                  _buildInfoRow(
                    Icons.camera_alt,
                    store.contacts.instagram!,
                    context,
                  ),
                  const SizedBox(height: 8),
                ],
                if (store.contacts.site != null) ...[
                  _buildInfoRow(
                    Icons.language,
                    store.contacts.site!,
                    context,
                  ),
                ],
                const SizedBox(height: 16),
                // Botão de fechar
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Fechar'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String text, BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Theme.of(context).primaryColor),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
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
      body: Stack(
        children: [
          GestureDetector(
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
          // Botão "Pesquisar nesta área"
          if (showSearchButton)
            Positioned(
              top: 16,
              left: 16,
              right: 16,
              child: Material(
                elevation: 4,
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: ElevatedButton.icon(
                    onPressed: _searchInCurrentArea,
                    icon: const Icon(Icons.search),
                    label: const Text('Pesquisar nesta área'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
