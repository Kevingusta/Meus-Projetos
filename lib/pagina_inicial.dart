import 'quiz_start_facil.dart';
import 'quiz_start_medio.dart';
import 'quiz_start_dificil.dart';
import 'package:flutter/material.dart';


class MyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Seleção de Dificuldade',
      home: MyWidgetPage(),
    );
  }
}

class MyWidgetPage extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidgetPage> {
  String? _selectedDifficulty;

  void _verificarDificuldade(value) {
    if (_selectedDifficulty == 'facil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizStartFacil()),
      );
    }
    if (_selectedDifficulty == 'medio') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizStartMedio()),
      );
    }
    if (_selectedDifficulty == 'dificil') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => QuizStartDificil()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Gym',
          style: TextStyle(color: Color.fromRGBO(240, 194, 42, 1),fontFamily: 'Queen'),
        ),
        backgroundColor: Color.fromARGB(255, 8, 8, 8),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Image.asset(
                'assets/imagens/quiz_gym2.png',
                fit: BoxFit.cover,
              ),
            ),
            
              AnimatedPositioned(
                       top: (MediaQuery.of(context).size.height + 50) / 2, // Position vertically
                      left: (MediaQuery.of(context).size.width - 270) / 2, 
                     duration: const Duration(milliseconds: 500),
                     curve: Curves.easeInOut,
                     child: SizedBox(
                      width: 240,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _selectedDifficulty != null
                            ? () {
                                _verificarDificuldade(_selectedDifficulty);
                              }
                            : null,
                        child: Text('Jogar',style: TextStyle(fontFamily: 'Poet',color: Color.fromRGBO(20, 20, 20, 1)),),
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromRGBO(231, 187, 42, 0.953),
                            textStyle: TextStyle(fontSize: 30),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          
                      ),
                    ),
                  ),
               Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 320,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(120),
                    child: Column(
                    children: [
                      RadioListTile(
                        value: 'facil',
                        groupValue: _selectedDifficulty,
                        title: const Text(
                          'Fácil',
                          style: TextStyle(color: Color.fromRGBO(228, 226, 226, 1),fontFamily: 'Poet'),
                        
                        ),
                        onChanged: (value) =>
                            setState(() => _selectedDifficulty = value),
                            activeColor: Color.fromRGBO(231, 187, 42, 0.953),
                      ),
                    
                  
                  RadioListTile(
                    value: 'medio',
                    groupValue: _selectedDifficulty,
                    title: const Text(
                      'Médio',
                      style: TextStyle(color: Color.fromRGBO(228, 226, 226, 1),fontFamily: 'Poet'),
                    ),
                    onChanged: (value) =>
                        setState(() => _selectedDifficulty = value),
                        activeColor: Color.fromRGBO(231, 187, 42, 0.953),
                  ),
                  RadioListTile(
                    value: 'dificil',
                    groupValue: _selectedDifficulty,
                    title: const Text(
                      'Difícil',
                      style: TextStyle(color: Color.fromRGBO(228, 226, 226, 1),fontFamily: 'Poet'),
                    ),
                    onChanged: (value) =>
                        setState(() => _selectedDifficulty = value),
                        activeColor: Color.fromRGBO(231, 187, 42, 0.953),
                  ),
                  ],),
                  ),
                  
                ],
              ),
            
          ],
        ),
      ),
    );
  }
}
