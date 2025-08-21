import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:laza/Resources/NotificationMassage/ToastMassage.dart';
import 'package:provider/provider.dart';

import '../../Providers/bottom_buttom_provider.dart';
import '../../Resources/Navigators/navigators.dart';

final databaseRef = FirebaseFirestore.instance.collection('User');
final _auth = FirebaseAuth.instance;


addAddress(name,city,country,phone,address,context){
  final addressMap = {
    'name': name,
    'city': city,
    'country': country,
     'phoneNo': phone,
    'address': address
  };

  List addressDataList =[addressMap];
  databaseRef.doc(_auth.currentUser!.uid).update({
    'AddressDetail' : addressDataList ,
  }).then((_){

    Toastmassage.SuccessToast(context,'Address added');
    Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
    NavigatorPop(context);
  }).onError((error,stackTrace){
    Provider.of<BottomButtomProvider>(context, listen:  false).endloading();
    Toastmassage.ErrorToast(context,error);
  });

}