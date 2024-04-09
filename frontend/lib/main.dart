import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:frontend/models/model.colonias.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<dynamic> delitos = [];
  String selectedAlcaldia = 'TODAS';
  String selectedCategoria = 'TODAS';
  String selectedColonia = 'TODAS';
  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response =
        await http.get(Uri.parse('http://192.168.50.199:3000/api/delitos'));
    if (response.statusCode == 200) {
      setState(() {
        delitos = json.decode(response.body)['delitos'];
      });
    } else {
      throw Exception('Failed to load data');
    }
  }

  List<String> getAlcaldias() {
    return [
      'TODAS',
      '0',
      'ALVARO OBREGON',
      'AZCAPOTZALCO',
      'BENITO JUAREZ',
      'CDMX (indeterminada)',
      'COYOACAN',
      'CUAJIMALPA DE MORELOS',
      'CUAUHTEMOC',
      'FUERA DE CDMX',
      'GUSTAVO A. MADERO',
      'IZTACALCO',
      'IZTAPALAPA',
      'LA MAGDALENA CONTRERAS',
      'MIGUEL HIDALGO',
      'MILPA ALTA',
      'TLAHUAC',
      'TLALPAN',
      'VENUSTIANO CARRANZA',
      'XOCHIMILCO',
    ];
  }

  List<String> getCategorias() {
    return [
      'TODAS',
      'DELITO DE BAJO IMPACTO',
      'FEMINICIDIO',
      'HECHO NO DELICTIVO',
      'HOMICIDIO DOLOSO',
      'LESIONES DOLOSAS POR DISPARO DE ARMA DE FUEGO',
      'PLAGIO O SECUESTRO',
      'ROBO A CASA HABITACIÓN CON VIOLENCIA',
      'ROBO A CUENTAHABIENTE SALIENDO DEL CAJERO CON VIOLENCIA',
      'ROBO A NEGOCIO CON VIOLENCIA',
      'ROBO A PASAJERO A BORDO DE MICROBUS CON Y SIN VIOLENCIA',
      'ROBO A PASAJERO A BORDO DE TAXI CON VIOLENCIA',
      'ROBO A PASAJERO A BORDO DEL METRO CON Y SIN VIOLENCIA',
      'ROBO A REPARTIDOR CON Y SIN VIOLENCIA',
      'ROBO A TRANSEUNTE EN VÍA PÚBLICA CON Y SIN VIOLENCIA',
      'ROBO A TRANSPORTISTA CON Y SIN VIOLENCIA',
      'ROBO DE VEHÍCULO CON Y SIN VIOLENCIA',
      'SECUESTRO',
      'VIOLACIÓN',
    ];
  }

  List<dynamic> getFilteredDelitos() {
    if (selectedAlcaldia == 'TODAS' && selectedColonia == 'TODAS') {
      // Alcaldia = todas y colonia = todas
      if (selectedCategoria != 'TODAS') {
        return delitos
            .where((delito) => delito['categoria_delito'] == selectedCategoria)
            .toList();
      } else {
        return delitos;
      }
    } else if (selectedColonia == 'TODAS' && selectedCategoria == 'TODAS') {
      // Colonia = todas y categoria = todas
      if (selectedAlcaldia != 'TODAS') {
        return delitos
            .where((delito) => delito['alcaldia_hecho'] == selectedAlcaldia)
            .toList();
      } else {
        return delitos;
      }
    } else if (selectedAlcaldia == 'TODAS') {
      return delitos
          .where((delito) =>
              delito['categoria_delito'] == selectedCategoria &&
              delito['colonia_hecho'] == selectedColonia)
          .toList();
    } else if (selectedCategoria == 'TODAS') {
      return delitos
          .where((delito) =>
              delito['alcaldia_hecho'] == selectedAlcaldia &&
              delito['colonia_hecho'] == selectedColonia)
          .toList();
    } else if (selectedColonia == 'TODAS') {
      return delitos
          .where((delito) =>
              delito['alcaldia_hecho'] == selectedAlcaldia &&
              delito['categoria_delito'] == selectedCategoria)
          .toList();
    } else {
      return delitos
          .where((delito) =>
              delito['alcaldia_hecho'] == selectedAlcaldia &&
              delito['categoria_delito'] == selectedCategoria &&
              delito['colonia_hecho'] == selectedColonia)
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TIPOS DE DELITOS EN CDMX'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('ALCALDÍA: '),
                  DropdownButton<String>(
                    value: selectedAlcaldia,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedAlcaldia = newValue!;
                        selectedColonia = 'TODAS';
                      });
                    },
                    items: getAlcaldias()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == '0' ? 'SIN REGISTRAR' : value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('COLONIA: '),
                  DropdownButton<String>(
                    value: selectedColonia,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedColonia = newValue!;
                      });
                    },
                    items: getColonias(selectedAlcaldia)
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == '0' ? 'SIN REGISTRAR' : value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const Text('CATEGORÍA: '),
                  DropdownButton<String>(
                    value: selectedCategoria,
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedCategoria = newValue!;
                      });
                    },
                    items: getCategorias()
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'CANTIDAD TOTAL DE DELITOS: ${getFilteredDelitos().length}',
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: getFilteredDelitos().length,
                itemBuilder: (context, index) {
                  final delito = getFilteredDelitos()[index];
                  return ListTile(
                    title: Text(delito['delito']),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'CATEGORÍA: ${delito['categoria_delito'] == '0' ? 'SIN REGISTRAR' : delito['categoria_delito']}'),
                        Text(
                            'ALCALDÍA: ${delito['alcaldia_hecho'] == '0' ? 'SIN REGISTRAR' : delito['alcaldia_hecho']}'),
                        Text(
                            'COLONIA: ${delito['colonia_hecho'] == '0' ? 'SIN REGISTRAR' : delito['colonia_hecho']}'),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
