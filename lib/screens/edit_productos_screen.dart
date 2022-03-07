import 'package:flutter/material.dart';
import 'package:pedidos_appv3/models/model_product.dart';
import 'package:pedidos_appv3/screens/loading_screen.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:pedidos_appv3/widgets/widgets.dart';
import 'package:provider/provider.dart';


class EditProductosScreen extends StatelessWidget {
  const EditProductosScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final productsServices = Provider.of<ProductsService>(context);

    if(productsServices.isLoading) return const LoadingScreen();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
      ),
      body: ListView.builder(
        itemCount: productsServices.products.length,
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              productsServices.selectedProduct=productsServices.products[index].copy();
              Navigator.pushNamed(context,'product');
            },
            child: ProductCard(
              product: productsServices.products[index],
            )
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: (){
          productsServices.selectedProduct = ModelProduct(
            estado: false,
            nombre:'',
            precio: 0
          );
          Navigator.pushNamed(context, 'product');
        },
      ),
   );
  }
}