import 'package:flutter/material.dart';
import 'package:mi_barrio_app/controller/server_connection.dart';


class FormPage extends StatelessWidget {
  const FormPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const appTitle = 'Registro Clientes';

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appTitle,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(appTitle),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        body: const MyCustomForm(),
      ),
    );
  }
}

// Create a Form widget.
class MyCustomForm extends StatefulWidget {
  const MyCustomForm({Key? key}) : super(key: key);

  @override
  MyCustomFormState createState() {
    return MyCustomFormState();
  }
}


class MyCustomFormState extends State<MyCustomForm> {
  // Create a global key that uniquely identifies the Form widget
  // and allows validation of the form.
  //
  // Note: This is a GlobalKey<FormState>,
  // not a GlobalKey<MyCustomFormState>.
  final _formKey = GlobalKey<FormState>();

  String _name = '', _user = '', _cellphone = '', _email = '', _password = '';

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escriba el nombre completo',
                  labelText: 'Nombre del Cliente *',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  icon: Icon(Icons.person),
                  fillColor: Colors.amberAccent,
                  focusColor: Colors.amberAccent,
                  alignLabelWithHint: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor escriba su nombre';
                  }else{
                    setState(() {
                      _name = value;
                    });
                    return null;
                  }

                },

              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escriba un usuario',
                  labelText: 'Usuario *',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  icon: Icon(Icons.account_circle),
                  fillColor: Colors.amberAccent,
                  focusColor: Colors.amberAccent,
                  alignLabelWithHint: true,
                ),
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un usuario';
                  }else {
                    setState(() {
                      _user = value;
                    });
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escriba un correo electrónico',
                  labelText: 'Email *',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  icon: Icon(Icons.email),
                  fillColor: Colors.amberAccent,
                  focusColor: Colors.amberAccent,
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.emailAddress,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor escriba su correo electrónico';
                  }else {
                    setState(() {
                      _email = value;
                    });
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escriba un número de celular',
                  labelText: 'Celular *',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  icon: Icon(Icons.stay_primary_portrait),
                  fillColor: Colors.amberAccent,
                  focusColor: Colors.amberAccent,
                  alignLabelWithHint: true,
                ),
                keyboardType: TextInputType.number,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese un número de celular';
                  }else {
                    setState(() {
                      _cellphone = value;
                    });
                    return null;
                  }
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Escriba una contraseña',
                  labelText: 'Contraseña *',
                  labelStyle: TextStyle(fontSize: 15, color: Colors.blueAccent),
                  icon: Icon(Icons.password),
                  fillColor: Colors.amberAccent,
                  focusColor: Colors.amberAccent,
                  alignLabelWithHint: true,
                ),
                obscureText: true,
                // The validator receives the text that the user has entered.
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese una contraseña';
                  }else {
                    setState(() {
                      _password = value;
                    });
                    return null;
                  }
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 11.0),
                child: ElevatedButton(
                  onPressed: () {
                    // Validate returns true if the form is valid, or false otherwise.
                    if (_formKey.currentState!.validate()) {
                      var srvcon = ServerConnection();
                      srvcon.insert('Customers', _name+';'+_user+';'+_email+';'+_cellphone+';'+_password).then((value) {
                        // If the form is valid, display a snackbar. In the real world,
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Cliente Registrado')),
                        );
                        _formKey.currentState!.reset();
                      });
                    }
                  },
                  child: const Text('Registrar'),
                ),
              ),
            ],
          ),
        ),
    );
  }
}


