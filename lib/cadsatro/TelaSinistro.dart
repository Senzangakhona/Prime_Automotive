import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'UploadImagem.dart';
import 'dart:io';
import 'package:camera_camera/camera_camera.dart';

void main() => runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        home: TelaSinistro(),
      ),
    );

class TelaSinistro extends StatefulWidget {
  const TelaSinistro({Key? key}) : super(key: key);

  @override
  _TelaSinistroState createState() => _TelaSinistroState();
}

final TextEditingController _controllerCPFdoProprietario =
    TextEditingController();
final TextEditingController _controllerDocumentodoCarro =
    TextEditingController();
final TextEditingController _controllerBoletimdeOcorrencia =
    TextEditingController();

class _TelaSinistroState extends State<TelaSinistro> {
  ImagePicker imagePicker = ImagePicker();
  File? imagemSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Rede Prime Automotive"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 220, 115, 50),
        actions: <Widget>[
          // ignore: deprecated_member_use
          FlatButton(
            child: Text(
              "Cadastro de Sinistro",
              style: const TextStyle(fontSize: 10.0),
            ),
            textColor: Colors.white,
            onPressed: () {},
          ),
        ],
      ),
      body: Form(
        child: Stack(
          textDirection: TextDirection.ltr,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromARGB(255, 220, 115, 50),
                    Color.fromARGB(255, 60, 50, 180),
                  ],
                ),
              ),
            ),
            Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    controller: _controllerCPFdoProprietario,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'CPF do Proprietário',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    controller: _controllerDocumentodoCarro,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'N° do Documento do Carro',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextField(
                    controller: _controllerBoletimdeOcorrencia,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'N° do Boletim de Ocorrencia'),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text("Envie uma foto do Sinistro"),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    imagemSelecionada == null
                        ? Container()
                        : Padding(
                            padding: const EdgeInsets.all(16),
                            child: Image.file(imagemSelecionada!),
                          ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          onPressed: () {
                            pegarImagemGaleria();
                          },
                          color: Colors.white,
                          textColor: Colors.black,
                          child: Icon(
                            Icons.add_photo_alternate_outlined,
                            size: 35.0,
                          ),
                          padding: EdgeInsets.all(16.0),
                          shape: CircleBorder(),
                        ),
                        MaterialButton(
                          onPressed: () {
                            pegarImagemCamera();
                          },
                          color: Colors.white,
                          textColor: Colors.black,
                          child: Icon(
                            Icons.photo_camera_outlined,
                            size: 35.0,
                          ),
                          padding: EdgeInsets.all(16.0),
                          shape: CircleBorder(),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: RaisedButton(
                    child: Text('Cadastrar'),
                    onPressed: () {
                      final int? CPFdoProprietario =
                          int.tryParse(_controllerCPFdoProprietario.text);
                      final int? DocumentoDoCarro =
                          int.tryParse(_controllerDocumentodoCarro.text);
                      final int? BoletimDeOcorrencia =
                          int.tryParse(_controllerBoletimdeOcorrencia.text);

                      final CadastroSinistro cadastroSinistroNovo =
                          CadastroSinistro(
                        CPFdoProprietario!,
                        DocumentoDoCarro!,
                        BoletimDeOcorrencia!,
                      );
                      print(cadastroSinistroNovo);
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future pegarImagemGaleria() async {
    final PickedFile? imagemTemporaria = await imagePicker.getImage(
      source: ImageSource.gallery,
      maxWidth: 240,
      maxHeight: 240,
    );
    if (imagemTemporaria != null) {
      setState(
        () {
          imagemSelecionada = File(imagemTemporaria.path);
        },
      );
    }
  }

  pegarImagemCamera() async {
    final PickedFile? imagemTemperaria = await imagePicker.getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );
    if (imagemTemperaria != null) {
      setState(
        () {
          imagemSelecionada = File(imagemTemperaria.path);
        },
      );
    }
  }
}

class CadastroSinistro {
  late final int CPFdoProprietario;
  late final int DocumentoDoCarro;
  late final int BoletimDeOcorrencia;

  CadastroSinistro(
      this.CPFdoProprietario, this.DocumentoDoCarro, this.BoletimDeOcorrencia);

  @override
  String toString() {
    return 'Cadastro de Sinistro { CPF do Proprietario: $CPFdoProprietario, documento do carro: $DocumentoDoCarro, boletim de ocorrencia: $BoletimDeOcorrencia}';
  }
}
