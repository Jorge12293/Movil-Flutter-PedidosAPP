// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pedidos_appv3/providers/product_form_provider.dart';
import 'package:pedidos_appv3/services/services.dart';
import 'package:pedidos_appv3/ui/input_decorations.dart';
import 'package:pedidos_appv3/widgets/widgets.dart';
import 'package:provider/provider.dart';
//import 'package:image_picker/image_picker.dart';

class ViewNewProduct extends StatelessWidget {
  const ViewNewProduct({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    
    final productServices = Provider.of<ProductsService>(context);
    
    return ChangeNotifierProvider(
      create: (_)=>ProductFormProvider(productServices.selectedProduct),
      child: _ViewNewProductBody(productServices: productServices)
    );
  }
}

class _ViewNewProductBody extends StatelessWidget {
  const _ViewNewProductBody({
    Key? key,
    required this.productServices,
  }) : super(key: key);

  final ProductsService productServices;

  @override
  Widget build(BuildContext context) {

    final productForm = Provider.of<ProductFormProvider>(context);
    return Scaffold(
      body: SingleChildScrollView(
        // scrollController: ScrollViewKeyboardDismissBehavior.onDrag,
        child: Column(
          children: [
            Stack(
              children: [
                ProductImage(productServices.selectedProduct.imagen),
                Positioned(
                  top:60,
                  left:20,
                  child: IconButton(
                    onPressed: ()=>Navigator.of(context).pop(),
                    icon: const Icon(Icons.arrow_back_ios_outlined,size:40,color: Colors.white)
                  )
                ),
                Positioned(
                  top:60,
                  right:20,
                  child: IconButton(
                    onPressed: () async{
                      /*
                      final picker = new ImagePicker();
                      final PickedFile pickedFile = await picker.getImage(
                        source: ImageSource.camera,
                        //source: ImageSource.gallery // Galeria de Imagenes
                        imageQuality: 100
                      );
                      
                      if(pickedFile== null){
                        print("No selecciono nada");
                        return;
                      }

                      print('Tenemos Imagen ${pickedFile.path}');
                      productServices.updateSelectedProductImage(pickedFile.path);
                      */
                    },
                    icon: const Icon(Icons.camera_alt_outlined,size:40,color: Colors.white)
                  )
                )
              ],
            ),
            _ProductForm(),
            const SizedBox(height: 100)
          ],
        ),
      ),
     // floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        child: productServices.isSaving
              ? const CircularProgressIndicator( backgroundColor:Colors.white)
              :const Icon(Icons.save_outlined),
        onPressed: productServices.isSaving
        ? null
        : () async{

            if(!productForm.isValidForm())return;

              final String? imageUrl = await productServices.uploadImage();

              if(imageUrl != null) productForm.product.imagen=imageUrl;
              print(imageUrl);

              await productServices.saveOnCreateProduct(productForm.product);
        },
      ),
    );
  }
}

class _ProductForm extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    
    final productForm = Provider.of<ProductFormProvider>(context);
    final product = productForm.product;
    
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: _buildBoxDecoration(),
        child: Form(
          key: productForm.formKey,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Column(
            children: [
              const SizedBox(height: 10),
              TextFormField(
                initialValue: product.nombre,
                onChanged: (value)=>product.nombre=value,
                // ignore: missing_return
                validator: (value){ 
                  if(value==null || value.isEmpty) {
                    return 'El nombre es obligatorio';
                  } 
                },
                decoration: InputDecorations.authInputDecoration(
                  hintText: 'Nombre del Producto', 
                  labelText: 'Nombre'
                ),
              ),
              const SizedBox(height: 30),
              TextFormField(
                initialValue: '${product.precio}',
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^(\d+)?\.?\d{0,2}'))
                ],
                onChanged: (value){
                  if( double.tryParse(value) == null){
                    product.precio;
                  }else{
                    product.precio=double.parse(value);
                  }
                },
                // ignore: missing_return
                validator: (value){ 
                  if(value==null || value.isEmpty) {
                    return 'Ingrese un Valor';
                  } 
                },
                keyboardType: TextInputType.number,
                decoration: InputDecorations.authInputDecoration(
                  hintText: '\$150', 
                  labelText: 'Precio'
                ),
              ),
              const SizedBox(height: 30),
              SwitchListTile.adaptive(
                value: product.estado, 
                title: const Text('Disponible'),
                activeColor: Colors.blueAccent,
                onChanged: productForm.updateEstado
              ),
              const SizedBox(height: 30)
            ],
          ),
        ),
      ),
    );
  }

  BoxDecoration _buildBoxDecoration() => BoxDecoration(
    color: Colors.white,
    borderRadius: const BorderRadius.only(
      bottomRight:Radius.circular(25), 
      bottomLeft:Radius.circular(25)
    ),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.5),
        offset: const Offset(0,5),
        blurRadius: 5
      )
    ]
  );
}