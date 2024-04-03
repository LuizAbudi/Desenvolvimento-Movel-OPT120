import 'package:flutter/material.dart';

class UserTable extends StatelessWidget {
  final List<Map<String, dynamic>> users;

  UserTable({required this.users});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
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
            rows: users.map((user) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(Text(user['name'])),
                  DataCell(Text(user['email'])),
                  DataCell(
                    Row(
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {
                            print('Editar');
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            print('Deletar');
                          },
                        ),
                      ],
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
}
