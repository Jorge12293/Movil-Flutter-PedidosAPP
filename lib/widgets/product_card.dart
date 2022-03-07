import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/models.dart';

class ProductCard extends StatelessWidget {

  final ModelProduct product;

  const ProductCard({
    Key? key,
    required this.product
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        margin: const EdgeInsets.only(top:20,bottom: 20),
        width: double.infinity,
        height: 200,
        decoration: _cardBorders(),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            _BackgroundImage(product.imagen),
            _ProductDetaills(product.nombre),
            Positioned(top:0,right:0,child: _PriceTag(product.precio)),
            if(product.estado)
               Positioned(top:0,left:0,child: _NotAvailable())
          ],
        ),
      ),
    );
  }

  BoxDecoration _cardBorders() => BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow:const [
      BoxShadow(
        color: Colors.black12,
        offset: Offset(0,7),
        blurRadius: 10
      )
    ]  
  );
}

class _NotAvailable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Text('Disponible',style: TextStyle(color: Colors.black87,fontSize: 20))
        ),
      ),
      width: 100,
      height: 45,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.yellow[800],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        )
      ),
    );
  }
}


class _PriceTag extends StatelessWidget {

  final double precio;

  const _PriceTag(this.precio);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: FittedBox(
        fit: BoxFit.contain,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Text('\$$precio',style: const TextStyle(color: Colors.white,fontSize: 20))
        ),
      ),
      width: 100,
      height: 45,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: Color.fromRGBO(81, 147, 209,1),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(25),
          bottomLeft: Radius.circular(25),
        )
      ),
    );
  }
}

class _ProductDetaills extends StatelessWidget {

  final String name;

  const _ProductDetaills( this.name);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        width: double.infinity,
        height: 45,
        decoration: _buildBoxDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: const TextStyle(fontSize: 20,color: Colors.white,fontWeight: FontWeight.bold),
              maxLines: 1,
              overflow: TextOverflow.ellipsis
            )
          ],
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => const BoxDecoration(
    color: Color.fromRGBO(81, 147, 209,1),
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(25),
      topRight: Radius.circular(25),
    )

  );
}

class _BackgroundImage extends StatelessWidget {

  final String url;

  const _BackgroundImage(this.url);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(25),
      // ignore: sized_box_for_whitespace
      child: Container(
        width: double.infinity,
        height: 200,
        // ignore: unnecessary_null_comparison
        child: url == null
          ?const Image(image: AssetImage('assets/no-image.png'),fit:BoxFit.cover)
          :FadeInImage(
            placeholder: const AssetImage('assets/jar-loading.gif'),
            //image: NetworkImage('https://via.placeholder.com/400x300/f6f6f6'),
            image: NetworkImage(url),
            fit:BoxFit.cover
           ),

      ),
    );
  }
}