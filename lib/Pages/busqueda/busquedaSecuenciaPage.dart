import 'package:flutter/material.dart';
import 'package:toma_de_lectura/Bloc/ProviderBloc.dart';
import 'package:toma_de_lectura/Models/lecturaModel.dart';
import 'package:toma_de_lectura/Pages/detalle_lectura.dart';
import 'package:toma_de_lectura/utils/responsive.dart';

class BusquedaXSecuenciaPage extends StatefulWidget {
  BusquedaXSecuenciaPage({@required this.idCliente,@required this.lecturas,@required this.indexLectura});

  final String idCliente;
  final List<LecturaModel> lecturas;
  final int indexLectura;

  @override
  _BusquedaXSecuenciaPageState createState() => _BusquedaXSecuenciaPageState();
}

class _BusquedaXSecuenciaPageState extends State<BusquedaXSecuenciaPage> {
  @override
  Widget build(BuildContext context) {
    final responsive = Responsive.of(context);
    final lecturaBloc = ProviderBloc.lectura(context);
    lecturaBloc.busquedaPorSecuencia(widget.idCliente);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
        title: Text("Código del Cliente", style: TextStyle(color: Colors.black)),
      ),
      body: SafeArea(
              child: Container(
          child: StreamBuilder(
            stream: lecturaBloc.busquedaXIdClienteStream,
            builder: (BuildContext context,
                AsyncSnapshot<List<LecturaModel>> snapshot) {
              List<LecturaModel> resultBusqeda = snapshot.data;
              if (snapshot.hasData) {
                if (snapshot.data.length > 0) {
                  return ListView.builder(
                    itemCount: resultBusqeda.length,
                    itemBuilder: (BuildContext context, int index) {
                      print(resultBusqeda.length);
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                              transitionDuration:
                                  const Duration(milliseconds: 700),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) {
                                return DetalleLectura(
                                  lecturas: widget.lecturas,
                                  numeroSecuencia: '',
                                  indexLectura: widget.indexLectura,
                                  nMedidor: '',
                                  codCliente: resultBusqeda[index].idCliente,
                                );
                              },
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                return FadeTransition(
                                  opacity: animation,
                                  child: child,
                                );
                              },
                            ),
                          );
                        },
                        title: Text(resultBusqeda[index].idCliente),
                        subtitle: Text(resultBusqeda[index].propietario),
                      );
                    },
                  );
                } else {
                  return Text("No hay resultados para la búsqueda", style: TextStyle(fontSize: 18, color: Colors.grey[700]));
                }
              } else {
                return CircularProgressIndicator();
              }
            },
          ),
        ),
      ),
    );
  }
}
