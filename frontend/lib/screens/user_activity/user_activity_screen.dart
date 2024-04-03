import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserActivitiesTable extends StatefulWidget {
  final List<Map<String, dynamic>> userActivities;
  final List<Map<String, dynamic>> users; // Lista de usuários
  final List<Map<String, dynamic>> activities; // Lista de atividades

  UserActivitiesTable({
    required this.userActivities,
    required this.users,
    required this.activities,
  });

  @override
  _UserActivitiesTableState createState() => _UserActivitiesTableState();
}

class _UserActivitiesTableState extends State<UserActivitiesTable> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: EdgeInsets.all(10),
      shrinkWrap: true,
      children: [
        ElevatedButton(
          onPressed: () {
            _criarUsuarioAtividade();
          },
          child: Text('Criar Associação Usuário-Atividade'),
        ),
        SizedBox(height: 10),
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
                    'ID do usuário',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID da atividade',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Data de entrega',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Nota',
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
            rows: widget.userActivities.map((userActivity) {
              return DataRow(
                cells: <DataCell>[
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['user_id'].toString()),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['activity_id'].toString()),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['due_date'] != null
                            ? DateFormat('dd/MM/yyyy')
                                .format(userActivity['due_date'])
                            : ''),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(userActivity['score'].toString()),
                      ],
                    )),
                  ),
                  DataCell(
                    Center(
                      child: Row(
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              _editarUsuarioAtividade(userActivity);
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              _deletarUsuarioAtividade(userActivity);
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

  void _criarUsuarioAtividade() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        String userId = '';
        String activityId = '';
        DateTime? dueDate;

        return AlertDialog(
          title: Text('Criar Associação Usuário-Atividade'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: userId,
                items: widget.users.map((user) {
                  return DropdownMenuItem<String>(
                    value: user['id'].toString(),
                    child: Text(user['name'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  userId = value!;
                },
                decoration: InputDecoration(labelText: 'Selecione o usuário'),
              ),
              DropdownButtonFormField<String>(
                value: activityId,
                items: widget.activities.map((activity) {
                  return DropdownMenuItem<String>(
                    value: activity['id'].toString(),
                    child: Text(activity['title'].toString()),
                  );
                }).toList(),
                onChanged: (value) {
                  activityId = value!;
                },
                decoration: InputDecoration(labelText: 'Selecione a atividade'),
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
                  labelText: 'Data de entrega',
                  hintText: dueDate != null
                      ? DateFormat('dd/MM/yyyy').format(dueDate!)
                      : 'Selecione uma data',
                ),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                criarUsuarioAtividade(userId, activityId, dueDate);
                Navigator.of(context).pop();
              },
              child: Text('Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _editarUsuarioAtividade(Map<String, dynamic> userActivity) {
    String userId = userActivity['user_id'].toString();
    String activityId = userActivity['activity_id'].toString();
    String? selectedUserId = userId;
    String? selectedActivityId = activityId;
    DateTime? dueDate = userActivity['due_date'];
    int score = userActivity['score'] ?? 0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: Text('Editar Associação Usuário-Atividade'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedUserId,
                    items: widget.users.map((user) {
                      return DropdownMenuItem<String>(
                        value: user['id'].toString(),
                        child: Text(user['name'].toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedUserId = value!;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Selecione o usuário'),
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedActivityId,
                    items: widget.activities.map((activity) {
                      return DropdownMenuItem<String>(
                        value: activity['id'].toString(),
                        child: Text(activity['title'].toString()),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedActivityId = value!;
                      });
                    },
                    decoration:
                        InputDecoration(labelText: 'Selecione a atividade'),
                  ),
                  TextField(
                    onChanged: (value) {
                      setState(() {
                        score = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                        labelText: 'Nota', hintText: 'Score atual: $score'),
                  ),
                  TextField(
                    onTap: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: dueDate ?? DateTime.now(),
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
                      labelText: 'Data de entrega',
                      hintText: dueDate != null
                          ? DateFormat('dd/MM/yyyy').format(dueDate!)
                          : 'Selecione uma data',
                    ),
                  ),
                ],
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    editarUsuarioAtividade(userActivity, selectedUserId!,
                        selectedActivityId!, score, dueDate);
                    Navigator.of(context).pop();
                  },
                  child: Text('Salvar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _deletarUsuarioAtividade(Map<String, dynamic> userActivity) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Deletar Associação Usuário-Atividade'),
          content: Text('Deseja realmente deletar esta associação?'),
          actions: [
            ElevatedButton(
              onPressed: () {
                deletarUsuarioAtividade(userActivity);
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

  void criarUsuarioAtividade(
      String userId, String activityId, DateTime? dueDate) {
    setState(() {
      widget.userActivities.add({
        'user_id': userId,
        'activity_id': activityId,
        'due_date': dueDate,
        'score': 0,
      });
    });
  }

  void editarUsuarioAtividade(Map<String, dynamic> userActivity, String userId,
      String activityId, int score, DateTime? dueDate) {
    setState(() {
      userActivity['user_id'] = userId;
      userActivity['activity_id'] = activityId;
      userActivity['score'] = score;
      userActivity['due_date'] = dueDate;
    });
  }

  void deletarUsuarioAtividade(Map<String, dynamic> userActivity) {
    setState(() {
      widget.userActivities.remove(userActivity);
    });
  }
}
