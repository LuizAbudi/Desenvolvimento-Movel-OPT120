import 'package:flutter/material.dart';
import 'package:opt120/screens/users/user_http_requests.dart';

class UserTable extends StatefulWidget {
  final List<Map<String, dynamic>> users;

  UserTable({required this.users});

  @override
  _UserTableState createState() => _UserTableState();
}

class _UserTableState extends State<UserTable> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        ElevatedButton(
          onPressed: () {
            _criarUsuario();
          },
          child: Text('Criar Usuário'),
        ),
        SizedBox(height: 10), // Espaçamento entre o botão e a tabela
        SizedBox(
          width: double.infinity,
          child: DataTable(
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Nome',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'E-mail',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Ações',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
            rows: widget.users.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> user = entry.value;
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user['name'], textAlign: TextAlign.center),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(user['email'], textAlign: TextAlign.center),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editarUsuario(index, user);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletarUsuario(index);
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  void _criarUsuario() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nome = '';
        String email = '';
        String senha = '';
        return AlertDialog(
          title: Text('Criar Usuário'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nome = value;
                },
                decoration: InputDecoration(labelText: 'Nome'),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              TextField(
                onChanged: (value) {
                  senha = value;
                },
                decoration: InputDecoration(labelText: 'Senha'),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                criarUsuario(nome, email, senha);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _editarUsuario(int index, Map<String, dynamic> user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String nome = user['name'];
        String email = user['email'];
        String senha = user['password'];
        return AlertDialog(
          title: Text('Editar Usuário'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  nome = value;
                },
                decoration:
                    InputDecoration(labelText: 'Nome', hintText: user['name']),
              ),
              TextField(
                onChanged: (value) {
                  email = value;
                },
                decoration: InputDecoration(
                    labelText: 'E-mail', hintText: user['email']),
              ),
              TextField(
                onChanged: (value) {
                  senha = value;
                },
                decoration: InputDecoration(
                    labelText: 'Senha', hintText: user['password']),
                obscureText: true,
                enableSuggestions: false,
                autocorrect: false,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                editarUsuario(index, nome, email, senha);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deletarUsuario(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Usuário'),
          content: Text('Deseja realmente deletar este usuário?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deletarUsuario(index);
                Navigator.of(context).pop();
              },
              child: Text('Sim'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancelar'),
            ),
          ],
        );
      },
    );
  }

  void criarUsuario(String nome, String email, String senha) {
    setState(() {
      widget.users.add({
        'name': nome,
        'email': email,
        'password': senha,
      });
    });
    UserService.createUser(nome, email, senha);
  }

  void editarUsuario(int index, String nome, String email, String senha) {
    setState(() {
      widget.users[index]['name'] = nome;
      widget.users[index]['email'] = email;
      widget.users[index]['password'] = senha;
    });
    UserService.updateUser(widget.users[index]['id'], nome, email, senha);
  }

  void deletarUsuario(int index) {
    setState(() {
      widget.users.removeAt(index);
    });
  }
}
