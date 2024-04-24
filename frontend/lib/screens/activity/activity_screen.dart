import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:opt120/screens/activity/activity_http_requests.dart';

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
          onPressed: _criarAtividade,
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
                            DateFormat('dd/MM/yyyy').format(
                              DateTime.parse(activity['due_date']),
                            ),
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
    TextEditingController datePickerController = TextEditingController();
    onTapFunction({required BuildContext context}) async {
      DateTime? pickedDate = await showDatePicker(
        context: context,
        lastDate: DateTime(2101),
        firstDate: DateTime(2024),
        initialDate: DateTime.now(),
      );
      if (pickedDate == null) return;
      datePickerController.text = DateFormat('dd/MM/yyyy').format(pickedDate);
    }

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
                onTap: () => onTapFunction(context: context),
                readOnly: true,
                controller: datePickerController,
                decoration: InputDecoration(
                  labelText: 'Data',
                  hintText: datePickerController.text.isEmpty
                      ? 'Selecione uma data'
                      : datePickerController.text,
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
    String titulo = activity['title'];
    String descricao = activity['description'];
    DateTime? data;

    if (activity['due_date'] != null &&
        RegExp(r'^\d{4}-\d{2}-\d{2}$').hasMatch(activity['due_date'])) {
      data = DateTime.parse(activity['due_date']);
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
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
                      ? DateFormat('dd/MM/yyyy').format(data!)
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
                ActivityService.deleteActivity(widget.activities[index]['id']);
                Navigator.of(context).pop();
                setState(() {
                  widget.activities.removeAt(index);
                });
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
    String dataString = DateFormat('yyyy-MM-dd').format(data ?? DateTime.now());
    // pega o ultimo id da lista de atividades e soma 1
    int id = widget.activities.last['id'] + 1;
    setState(() {
      widget.activities.add({
        'id': id,
        'title': titulo,
        'description': descricao,
        'due_date': dataString,
      });
    });
    ActivityService.createActivity(titulo, descricao, dataString);
  }

  void editarAtividade(
      int index, String titulo, String descricao, DateTime? data) {
    String dataString =
        data != null ? DateFormat('yyyy-MM-dd').format(data) : '';
    setState(() {
      widget.activities[index]['title'] = titulo;
      widget.activities[index]['description'] = descricao;
      widget.activities[index]['due_date'] = dataString;
    });

    int activityId = widget.activities[index]['id'];
    ActivityService.updateActivity(activityId, titulo, descricao, dataString);
  }
}
