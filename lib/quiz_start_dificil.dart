import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'resultado.dart';
import 'dart:async';

class QuizStartDificil extends StatefulWidget {
  @override
  _TelaQuizState createState() => _TelaQuizState();
}

class _TelaQuizState extends State<QuizStartDificil> {
  int erros = 0;
  int _perguntaAtual = 0;
  int _pontuacao = 0;
  Timer? _timer;
  int _tempoRestante = 10;

  void initState() {
    super.initState();
    _startTimer();
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (Timer timer) {
      if (_tempoRestante > 0) {
        setState(() {
          _tempoRestante--;
        });
      } else {
        _timer?.cancel();
        _proximaPergunta();
      }
    });
  }

  void _proximaPergunta() {
    if (_perguntaAtual < _perguntasdificil.length - 1) {
      setState(() {
        _perguntaAtual++;
        _tempoRestante = 10;
        _startTimer();
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) =>
              TelaResultado(_pontuacao, _perguntasdificil.length, erros),
        ),
      );
    }
  }

  final List<Pergunta> _perguntasdificil = [
    Pergunta(
      pergunta: '1 - Como a adaptação neuromuscular contribui para o aumento da força muscular?',
      respostas: ['Aumento do número de unidades motoras recrutadas', 'Melhoria da eficiência da contração muscular', 'Aumento da força das fibras musculares', ' Todas as opções'],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/supino.png',
    ),
    Pergunta(
      pergunta:
          '2 - Qual técnica de treinamento envolve a utilização de pesos mais pesados e menos repetições?',
      respostas: ['Treino de força máxima', 'Treino de hipertrofia com repetições moderadas', ' Treino de resistência muscular', 'Treino de volume alemão'],
      respostaCorreta: 'Treino de força máxima',
      imagemPath: 'assets/imagens/deadlift.png',
    ),
    Pergunta(
      pergunta: '3 - Qual macronutriente fornece energia imediata durante o exercício intenso?',
      respostas: ['Carboidratos', 'Gorduras', 'Proteína', 'Glicose'],
      respostaCorreta: 'Glicose',
      imagemPath: 'assets/imagens/nutrientes.png',
    ),
    Pergunta(
      pergunta: '4 - Qual tipo de treinamento de alta intensidade é conhecido por aumentar significativamente o hormônio do crescimento (GH)?',
      respostas: [
        'Treino intervalado de alta intensidade (HIIT)',
        'Treino de força máxima',
        'Treino de volume alemão',
        'Treino de superconjuntos'
      ],
      respostaCorreta: 'Treino intervalado de alta intensidade (HIIT)',
      imagemPath: 'assets/imagens/ledpress.png',
    ),
    Pergunta(
      pergunta: '5 - Qual técnica de treinamento envolve a realização de séries com repetições muito altas (mais de 15)?',
      respostas: [
        'Treino de hipertrofia com repetições moderadas',
        'Treino de resistência muscular',
        'Treino de volume alemão',
        'Treino de alta intensidade com volume reduzido'
      ],
      respostaCorreta: 'Treino de volume alemão',
      imagemPath: 'assets/imagens/scot.png',
    ),
    Pergunta(
      pergunta: '6 - Qual suplemento pode auxiliar na preservação da massa muscular durante a fase de definição?',
      respostas: [
        'Creatina',
        'Beta-alanina',
        'Zinco',
        'Peptídeos de caseína'
      ],
      respostaCorreta: 'Peptídeos de caseína',
      imagemPath: 'assets/imagens/creatina.png',
    ),
    Pergunta(
      pergunta: '7 - Como a hipertrofia muscular sarcoplasmática contribui para o aumento do tamanho muscular?',
      respostas: ['Aumento do número de fibras musculares', 'Aumento do tamanho das fibras musculares', 'Aumento da força das fibras musculares', 'Todas as opções'],
      respostaCorreta: 'Aumento do tamanho das fibras musculares',
      imagemPath: 'assets/imagens/curvada.png',
    ),
    Pergunta(
      pergunta: '8 - Qual tipo de treinamento é mais eficaz para estimular o crescimento muscular de iniciantes?',
      respostas: ['Treino de alta intensidade com volume reduzido', 'Treino de volume alemão', 'Treino de hipertrofia com repetições moderadas', 'Treino de força máxima'],
      respostaCorreta: 'Treino de hipertrofia com repetições moderadas',
      imagemPath: 'assets/imagens/barra.png',
    ),
    Pergunta(
      pergunta: '9 - O que causa a dor muscular de início tardio (DOMS) após o exercício?',
      respostas: ['Acúmulo de ácido láctico', 'Depleção de glicogênio', 'Microlesões nas fibras musculares', 'Desequilíbrio hidroeletrolítico'],
      respostaCorreta: 'Microlesões nas fibras musculares',
      imagemPath: 'assets/imagens/dor_muscular.png',
    ),
    Pergunta(
      pergunta: '10 - Qual mecanismo fisiológico contribui para a fadiga muscular durante o exercício intenso?',
      respostas: ['Aumento da concentração de lactato nos músculos', 'Redução das reservas de glicogênio nos músculos', 'Aumento da temperatura corporal', 'Todas as opções'],
      respostaCorreta: 'Todas as opções',
      imagemPath: 'assets/imagens/cansaço.png',
    ),
  ];

  void _responderPergunta(String resposta) {
    if (_perguntasdificil[_perguntaAtual].respostaCorreta == resposta) {
      setState(() {
        _pontuacao++;
        print('acertou');
      });
    } else {
      erros++;
      print('errou');
    }

    if (_perguntaAtual < _perguntasdificil.length - 1) {
      setState(() {
        _timer?.cancel();
        _tempoRestante = 10;
        _startTimer();
        _perguntaAtual++;
      });
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                TelaResultado(_pontuacao, _perguntasdificil.length, erros)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz Gym',
          style: TextStyle(color: Color.fromARGB(255, 207, 196, 35),fontFamily: 'Queen'
          ),
        ),
        backgroundColor: Color.fromARGB(255, 79, 79, 79),
      ),
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Color.fromRGBO(212, 185, 28, 1),
                    Color.fromARGB(255, 180, 180, 180),
                    Color.fromARGB(255, 5, 5, 5),
                  ],
                ),
              ),
            ),
            AnimatedPositioned(
              width: MediaQuery.of(context).size.width * 0.8,
              height: MediaQuery.of(context).size.height * 0.8,
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeInOut,
              child: Container(
                decoration: BoxDecoration(
                    color: Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(20)),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Text('Pergunta ${_perguntaAtual + 1} de 10',style: TextStyle(fontFamily: 'Poet')),
                      ),
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          height: 70,
                          width: 70,
                          child: CircularProgressIndicator(
                            strokeWidth: 7,
                            value: _tempoRestante / 10,
                            color: Color.fromRGBO(156, 43, 179, 1),
                            backgroundColor: Color.fromRGBO(162, 132, 168, 1),
                          ),
                        ),
                        Column(
                          children: [
                            Text('$_tempoRestante',style: TextStyle(fontFamily: 'Poet'),),
                          ],
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    
                    SizedBox(
                      width: 120.0,
                      height: 120.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Image.asset(
                          _perguntasdificil[_perguntaAtual].imagemPath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 50),
                    Text(
                      _perguntasdificil[_perguntaAtual].pergunta,
                      style: TextStyle(fontSize: 20,fontFamily: 'Poet'),
                    ),
                    SizedBox(height: 50),
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasdificil[_perguntaAtual].respostas[0]);
                            },
                            child: Text(
                                _perguntasdificil[_perguntaAtual].respostas[0],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                                style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          
                      
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasdificil[_perguntaAtual].respostas[1]);
                            },
                            child: Text(
                                _perguntasdificil[_perguntaAtual].respostas[1],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                                   style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          
                      
                          
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30),
                    Wrap(
                      spacing: 15.0,
                      runSpacing: 15.0,
                      children: [
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasdificil[_perguntaAtual].respostas[2]);
                            },
                            child: Text(
                                _perguntasdificil[_perguntaAtual].respostas[2],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        ),
                        SizedBox(
                          width: 250,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              _responderPergunta(
                                  _perguntasdificil[_perguntaAtual].respostas[3]);
                            },
                            child: Text(
                                _perguntasdificil[_perguntaAtual].respostas[3],style: TextStyle(color: Color.fromRGBO(0, 0, 0, 1),fontFamily: 'Poet'),),
                          style: ElevatedButton.styleFrom(
                            textStyle: TextStyle(fontSize: 17),
                            elevation: 15,
                            shadowColor: Color.fromRGBO(0, 0, 0, 1)),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Pergunta {
  final String pergunta;
  final List<String> respostas;
  final String respostaCorreta;
  final String imagemPath;

  Pergunta({
    required this.pergunta,
    required this.respostas,
    required this.respostaCorreta,
    required this.imagemPath,
  });
}
