import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ActivitiesTable extends StatefulWidget {
  final List<Map<String, dynamic>> activities;

  ActivitiesTable({required this.activities});

  @override
  _ActivitiesTableState createState() => _ActivitiesTableState();
}

class _ActivitiesTableState extends State<ActivitiesTable> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        ElevatedButton(
          onPressed: () {
            _criarAtividade();
          },
          child: Text('Criar Atividade'),
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
                    'Título',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Descrição',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Data',
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
            rows: widget.activities.asMap().entries.map((entry) {
              int index = entry.key;
              Map<String, dynamic> activity = entry.value;
              return DataRow(
                cells: <DataCell>[
                  DataCell(Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(activity['title'], textAlign: TextAlign.center),
                      ],
                    ),
                  )),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(activity['description'],
                              textAlign: TextAlign.center),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('dd/MM/yyyy')
                                .format(activity['due_date']),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editarAtividade(index, activity);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletarAtividade(index);
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

  void _criarAtividade() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String title = '';
        String description = '';
        DateTime? dueDate;
        return AlertDialog(
          title: Text('Criar Atividade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  title = value;
                },
                decoration: InputDecoration(labelText: 'Título'),
              ),
              TextField(
                onChanged: (value) {
                  description = value;
                },
                decoration: InputDecoration(labelText: 'Descrição'),
              ),
              TextField(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null) {
                    setState(() {
                      dueDate = picked;
                    });
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: dueDate != null
                      ? DateFormat('dd/MM/yyyy').format(dueDate!)
                      : DateFormat('dd/MM/yyyy').format(DateTime.now()),
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                criarAtividade(title, description, dueDate);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _editarAtividade(int index, Map<String, dynamic> activity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String titulo = activity['title'];
        String descricao = activity['description'];
        DateTime? data = activity['due_date'];
        return AlertDialog(
          title: Text('Editar Atividade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                onChanged: (value) {
                  titulo = value;
                },
                decoration: InputDecoration(
                  labelText: 'Título',
                  hintText: activity['title'],
                ),
              ),
              TextField(
                onChanged: (value) {
                  descricao = value;
                },
                decoration: InputDecoration(
                  labelText: 'Descrição',
                  hintText: activity['description'],
                ),
              ),
              TextField(
                onTap: () async {
                  final DateTime? picked = await showDatePicker(
                    context: context,
                    initialDate: data ?? DateTime.now(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2101),
                  );
                  if (picked != null && picked != data) {
                    setState(() {
                      data = picked;
                    });
                  }
                },
                readOnly: true,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: data != null
                      ? DateFormat('dd/MM/yyyy').format(data)
                      : 'Selecione uma data',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                editarAtividade(index, titulo, descricao, data);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deletarAtividade(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Atividade'),
          content: Text('Deseja realmente deletar esta atividade?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deletarAtividade(index);
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

  void criarAtividade(String titulo, String descricao, DateTime? data) {
    setState(() {
      widget.activities.add({
        'title': titulo,
        'description': descricao,
        'due_date': data ?? DateTime.now(),
      });
    });
  }

  void editarAtividade(
      int index, String titulo, String descricao, DateTime? data) {
    setState(() {
      widget.activities[index]['title'] = titulo;
      widget.activities[index]['description'] = descricao;
      widget.activities[index]['due_date'] = data ?? DateTime.now();
    });
  }

  void deletarAtividade(int index) {
    setState(() {
      widget.activities.removeAt(index);
    });
  }
}
