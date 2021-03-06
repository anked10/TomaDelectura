import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseProvider {
  static Database _database;
  static final DatabaseProvider db = DatabaseProvider._();

  DatabaseProvider._();

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await initDB();

    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();

    final path = join(documentsDirectory.path, 'sedaayacucho.db');

    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute('CREATE TABLE Inspector ('
          'id_inspector VARCHAR  PRIMARY KEY,'
          'id_sede VARCHAR,'
          'inspector_dni VARCHAR,'
          'inspector_nombre VARCHAR,'
          'inspector_fecha_registro VARCHAR,'
          'inspector_usuario VARCHAR,'
          //'inspector_clave VARCHAR,'
          'inspector_asignado_reclamo VARCHAR,'
          'inspector_asignado_lectura VARCHAR,'
          'inspector_asignado_corte VARCHAR,'
          'inspector_asignado_catastro VARCHAR,'
          'inspector_asignado_inspecciones VARCHAR,'
          'inspector_asignado_consulta VARCHAR,'
          'inspector_supervisor VARCHAR,'
          'inspector_codigo_empresa VARCHAR,'
          'inspector_codigo_sede_1 VARCHAR,'
          'inspector_estado_registro VARCHAR'
          ')');

      await db.execute('CREATE TABLE Empresa ('
          'id_empresa VARCHAR  PRIMARY KEY,'
          'empresa_nombre VARCHAR,'
          'empresa_ruc VARCHAR,'
          'empresa_direccion VARCHAR'
          ')');

    
//http://gis.sedaayacucho.pe/api_appSysco/index.php/sedeoperacional
      await db.execute('CREATE TABLE Sedes ('
          'idSede VARCHAR  PRIMARY KEY,'
          'idEmpresa VARCHAR,'
          'nombreSede VARCHAR'
          ')');

//http://gis.sedaayacucho.pe/api_appSysco/index.php/ciclos
      await db.execute('CREATE TABLE Ciclo ('
          'id_ciclo VARCHAR  PRIMARY KEY,'
          'id_empresa VARCHAR,'
          'ciclo_descripcion VARCHAR,'
          'anio VARCHAR,'
          'mes VARCHAR'
          ')');

      await db.execute('CREATE TABLE Lectura ('
          'idLectura  VARCHAR  PRIMARY KEY,'
          'idEmpresa VARCHAR,'
          'idSede VARCHAR,'
          'idSucursal VARCHAR,'
          'idSector VARCHAR,'
          'idCliente VARCHAR,'
          'idInspectormovil VARCHAR,'
          'propietario VARCHAR,'
          'estadoservicio VARCHAR,'
          'catetar VARCHAR,'
          'direccion VARCHAR,'
          'codrutalectura VARCHAR,'
          'nroordenrutalect VARCHAR,'
          'codrutadistribucion VARCHAR,'
          'nroordenrutadist VARCHAR,'
          'codmza VARCHAR,'
          'nrolote VARCHAR,'
          'nrosublote VARCHAR,'
          'catastro VARCHAR,'
          'nromedidor VARCHAR,'
          'estadolectura VARCHAR,'
          'lecturaanterior VARCHAR,'
          'fechalecturaultima VARCHAR,'
          'lecturaultima VARCHAR,'
          'lecturapromedio VARCHAR,'
          'consumo VARCHAR,'
          'tipopromedio VARCHAR,'
          'fechahoraregistro VARCHAR,' 
          'nrodias VARCHAR,'
          'ordenenvio VARCHAR,'
          'valorconsumoexc VARCHAR,'
          'codurbaso VARCHAR,'
          'web VARCHAR,'
          'fechamovil VARCHAR,'
          'obslectura VARCHAR,'
          'idciclo VARCHAR,'
          'altoconsumo VARCHAR,'
          'situacionmed VARCHAR,'
          'variasunidadesuso VARCHAR,'
          'unid_tarifa VARCHAR,'
          'mostrarlectant VARCHAR,'
          //'siinco VARCHAR,'
          'registrado VARCHAR,'
          'latitud VARCHAR,'
          'longitud VARCHAR,'
          'img_base64 VARCHAR,'
          'tiposervicio VARCHAR,'
          'estadomed VARCHAR,'
          'anio VARCHAR,'
          'mes VARCHAR,'
          'padroncritica VARCHAR,'
          //'codinspectormovil VARCHAR,'
          'c_permitemodif VARCHAR,'
          'nombre_sector VARCHAR,'
          'vivhabitada VARCHAR,'
          'estado_lectura_interna VARCHAR,'
          'estado_enviado VARCHAR,'
          'fecha_lectura VARCHAR'
          ')');

//http://gis.sedaayacucho.pe/api_appSysco/index.php/tipoestmedidor
      await db.execute('CREATE TABLE EstadoMedidor ('
          'estadoMedidor VARCHAR  PRIMARY KEY,'
          'descripcion VARCHAR,'
          'impedimento VARCHAR,'
          'promedioAuto VARCHAR,'
          'permiteLectura VARCHAR,'
          'estadoRegistroMov VARCHAR'
          ')');

 //http://gis.sedaayacucho.pe/api_appSysco/index.php/cliente/20173657
      await db.execute('CREATE TABLE Cliente ('
          'id_cliente VARCHAR  PRIMARY KEY,'
          'tipo_usuario VARCHAR,'
          'nombre_cliente VARCHAR,'
          'nromedidor VARCHAR,'
          'id_sucursal VARCHAR,'
          'id_estado_servicio VARCHAR,'
          'tipo_servicio VARCHAR,'
          'nombre_sucursal VARCHAR,'
          'id_sector VARCHAR,'
          'id_manzana VARCHAR,'
          'nro_lote VARCHAR,'
          'nro_sublote VARCHAR,'
          'descripcion_urba VARCHAR,'
          'descripcion_corta VARCHAR,'
          'descripcion_calle VARCHAR,'
          'nro_calle VARCHAR,'
          'cod_ruta_distribucion VARCHAR,'
          'nro_orden_ruta_distribucion VARCHAR,'
          'catetarifa VARCHAR,'
          'unidades_uso VARCHAR,'
          'actividad VARCHAR,'
          'tipo_promedio VARCHAR,'
          'lectura_anterior VARCHAR,'
          'lectura_ultima VARCHAR,'
          'consumo VARCHAR,'
          'situacion_medidor VARCHAR,'
          'consumo_facturacion VARCHAR,'
          'importe_mes_deuda VARCHAR,'
          'importe_deuda VARCHAR,'
          'importe_deuda_refinanci VARCHAR,'
          'fecha_corte VARCHAR'
          ')');
    });
  }
}
