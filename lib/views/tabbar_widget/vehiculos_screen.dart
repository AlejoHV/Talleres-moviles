import 'package:flutter/material.dart';

class VehiculosScreen extends StatelessWidget {
  const VehiculosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3, // Número de tabs
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Vehículos'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.motorcycle), text: 'Motos'),
              Tab(icon: Icon(Icons.directions_car), text: 'Carros'),
              Tab(icon: Icon(Icons.directions_bus), text: 'Buses'),
            ],
            labelColor: Colors.white,
          ),
        ),
        body: const TabBarView(
          children: [
            // Motos
            VehiculoGrid(
              items: [
                VehiculoItem(
                  nombre: 'BMW S1000RR',
                  imageUrl:
                      'https://fotos.perfil.com//2025/07/16/900/0/bmw-lanza-en-argentina-la-nueva-s-1000-rr-2025-2062628.jpg',
                ),
                VehiculoItem(
                  nombre: 'Ducati Panigale V4',
                  imageUrl:
                      'https://cdn.bikedekho.com/processedimages/ducati/2025-panigale-v4/source/2025-panigale-v467c92a5209abb.jpg',
                ),
                VehiculoItem(
                  nombre: 'Yamaha MT-09',
                  imageUrl:
                      'https://http2.mlstatic.com/D_NQ_NP_965351-MCO90643076696_082025-O.webp',
                ),
                VehiculoItem(
                  nombre: 'Husqvarna 701',
                  imageUrl:
                      'https://www.motofichas.com/images/cache/10-husqvarna-701-supermoto-2023-estudio-01-398-a-mobile.jpg',
                ),
                VehiculoItem(
                  nombre: 'BMW R1300GS',
                  imageUrl:
                      'https://content.media.mcdn.es/api/v1/mnet-media/images/c3/c349c7d3-1794-4a4a-9326-f5696a90745e?rule=mobileArticleBodyImage',
                ),
                VehiculoItem(
                  nombre: 'Ktm 890 Adventure R',
                  imageUrl:
                      'https://www.secomoto.com/media/catalog/product/cache/16f0f75153821019f877160fc5b64d9a/m/o/moto-ktm-890-adventure-r-2025-8.jpg',
                ),
              ],
            ),
            // Carros
            VehiculoGrid(
              items: [
                VehiculoItem(
                  nombre: 'BMW X6M',
                  imageUrl:
                      'https://images.ctfassets.net/hbvlqhiip2ie/7dqMqkShzZNDXJApICuEJO/2d801876a50e36881dee872334095e1c/P90495557_highRes_the-new-bmw-x6-m-com_11zon.jpg?fit=fill&fm=webp&w=2880&h=1800',
                ),
                VehiculoItem(
                  nombre: 'Cadillac Escalade ',
                  imageUrl:
                      'https://media-cdn.tripadvisor.com/media/attractions-splice-spp-674x446/07/c3/f8/d3.jpg',
                ),
                VehiculoItem(
                  nombre: 'Porche 911 GT3 RS',
                  imageUrl:
                      'https://media.carvia.com/Porsche%20GT3%20RS%20mieten-1920x1535.webp',
                ),
                VehiculoItem(
                  nombre: 'Ford F-150 Raptor',
                  imageUrl:
                      'https://www.elcarrocolombiano.com/wp-content/uploads/2018/05/20180527-FORD-F-150-RAPTOR-2019-01.jpg',
                ),
                VehiculoItem(
                  nombre: 'BMW M5',
                  imageUrl:
                      'https://hips.hearstapps.com/hmg-prod/images/bmw-m5-speed-yellow-015-67e52f11256bc.jpg?crop=0.822xw:0.694xh;0.100xw,0.293xh&resize=640:*',
                ),
                VehiculoItem(
                  nombre: 'Mustang Shelby GT500',
                  imageUrl:
                      'https://hips.hearstapps.com/hmg-prod/images/2022-ford-mustang-shelby-gt500-02-1636734552.jpg?crop=1.00xw:0.891xh;0,0.0759xh&resize=1200:*',
                ),
              ],
            ),
            // Buses
            VehiculoGrid(
              items: [
                VehiculoItem(
                  nombre: 'Mercedes-Benz Bus',
                  imageUrl:
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSj_oLCeSFUMKXKK8LKvUacQpnREcWDrly9FQ&s',
                ),
                VehiculoItem(
                  nombre: 'Volvo Bus',
                  imageUrl:
                      'https://www.volvobuses.com/content/dam/volvo-buses/markets/global/classic/news/2019/1860x1050-volvo-9700-15m-variant.jpg',
                ),
                VehiculoItem(
                  nombre: 'Scania Bus',
                  imageUrl:
                      'https://www.scania.com/content/dam/www/market/master/products/buses-and-coaches/travel-transport/scania-touring/scania-touring-24207-052_16-9.jpg.transform/Rend_1200X630/image.jpg',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class VehiculoGrid extends StatelessWidget {
  final List<VehiculoItem> items;
  const VehiculoGrid({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.builder(
        itemCount: items.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemBuilder: (context, index) {
          final item = items[index];
          return Card(
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(16),
                    ),
                    child: Image.network(
                      item.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 120,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 60),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    item.nombre,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class VehiculoItem {
  final String nombre;
  final String imageUrl;
  const VehiculoItem({required this.nombre, required this.imageUrl});
}
