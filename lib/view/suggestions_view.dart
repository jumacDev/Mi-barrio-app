import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/server_connection.dart';


class SuggestionsForm extends StatefulWidget{
  const SuggestionsForm({Key? key}) : super(key: key);

  @override
  SuggestionsFormState createState() {
    return SuggestionsFormState();
  }

}

class SuggestionsFormState extends State<SuggestionsForm>{
  final _text = TextEditingController();
  final _text1 = TextEditingController();
  String _name = '';
  String _message = '';
  bool _validate = false;
  bool _validate1 = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sugerencias'),
      ),
      body: _listFields(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Enviar'),
        icon: const Icon(Icons.send),
        onPressed: (){
          setState(() {
            _text.text.isEmpty? _validate = true: _validate = false;
            _text1.text.isEmpty? _validate1 = true: _validate = false;
            if(_text.text.isNotEmpty && _text1.text.isNotEmpty){
              var srvcon = ServerConnection();
              srvcon.insert('Suggestion', _name+';'+_message).then((value) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Gracias por tus consejos!')),
                );
              });
            }
            _text.clear();
            _text1.clear();
          });
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  Widget _listFields(){
    return ListView(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20.0),
        children: <Widget>[
          _createInput(),
          const Divider(),
          _createMessageInput(),
        ]
    );
  }

 Widget _createInput() {
    return TextField(
      controller: _text,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20.0)
        ),
        hintText: 'Nombre',
        labelText: 'Nombre *',
        helperText: 'Nombre Completo',
        suffixIcon: const Icon(Icons.edit),
        icon: const Icon(Icons.account_circle),
        errorText: _validate? 'Campos vacíos': null,
      ),
      onChanged: (value){
        _name = value;
      },
    );
  }

  Widget _createMessageInput() {
    return TextField(
      controller: _text1,
      maxLines: 5,
      decoration: InputDecoration(
        hintText: 'Escribe tu sugerencia',
        labelText: 'Mensaje*',
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        icon: const Icon(Icons.article),
        errorText: _validate1? 'Campos vacíos': null,
      ),
      onChanged: (value){
        _message = value;
      },
    );
  }



}

