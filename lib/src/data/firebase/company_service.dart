import 'package:cloud_firestore/cloud_firestore.dart';

class CompanyService{

  final CollectionReference _collectionReference = FirebaseFirestore.instance
    .collection('companies');

  @override
  Future<List<dynamic>> listCompanies() async{
    print('List Companies');
    QuerySnapshot companies = await _collectionReference.get();
    List<dynamic> listCompanies = [];
    
    if(companies.docs.isNotEmpty){
      for (var doc in companies.docs) { 
        print(doc.data());
        //final tempCompany = Company.fromJson(doc.data()  as Map<String, dynamic>);
        //tempCompany.id =  doc.id;
        //listCompanies.add(tempCompany);
      }
    }
    return listCompanies;
  }
}